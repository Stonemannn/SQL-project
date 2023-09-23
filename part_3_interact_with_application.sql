
##############################
# PROJECT FINAL PART 3
##############################

--  Jiayu Shi & Edmund Hui
-- jiayu.shi@vanderbilt.edu
-- Edmund.Hui@Vanderbilt.Edu	

-- Project Part 3 - Modified 

##############################
# CREATE A NEW TABLE
##############################

DROP DATABASE IF EXISTS part3;
CREATE DATABASE IF NOT EXISTS part3;
USE part3;

DROP TABLE IF EXISTS voter_data_mega;
CREATE TABLE IF NOT EXISTS voter_data_mega(
	precinct_desc CHAR(7), 
    party_cd CHAR(3),
    race_code CHAR(1), 
    ethnic_code CHAR(2),
    sex_code CHAR(1), 
    age INT(11),
    pct_portion CHAR(255), 
    first_name VARCHAR(45),
	middle_name VARCHAR(45), 
    last_name VARCHAR(45), 
    name_suffix_lbl VARCHAR(45),
    full_name_mail VARCHAR(45), 
    mail_addr1 VARCHAR(255),
    mail_addr2 VARCHAR(255),
	mail_city_state_zip VARCHAR(100), 
    house_num VARCHAR(10), 
    street_dir VARCHAR(10), 
    street_name VARCHAR(50), 
    street_type_cd VARCHAR(10), 
    street_sufx_cd VARCHAR(5),
	unit_num VARCHAR(10), 
    res_city_desc VARCHAR(50), 
    state_cd CHAR(2), 
    zip_code VARCHAR(50), 
    registr_dt DATE, 
    voter_reg_num VARCHAR(50), 
    status_cd CHAR(2),		
	municipality_desc VARCHAR(50), 
    ward_desc VARCHAR(100),		
    cong_dist_desc VARCHAR(100),		
    super_court_desc VARCHAR(100), 
    nc_senate_desc VARCHAR(100),
	nc_house_desc VARCHAR(100), 
    county_commiss_desc VARCHAR(100), 
    school_dist_desc VARCHAR(100), 
    E1 VARCHAR(10), 
    E1_date DATE,		
    E1_VotingMethod VARCHAR(20),
	E1_PartyCd CHAR(3), 
    E2 VARCHAR(10), 
    E2_Date DATE, 
    E2_VotingMethod VARCHAR(20), 
    E2_PartyCd CHAR(3),		
    E3 VARCHAR(10), 
    E3_Date DATE, 
    E3_VotingMethod VARCHAR(20),
	E3_PartyCd CHAR(3), 
    E4 VARCHAR(10), 
    E4_Date DATE, 
    E4_VotingMethod VARCHAR(20),		
    E4_PartyCd CHAR(3), 
    E5 VARCHAR(10), 
    E5_Date DATE,		
    E5_VotingMethod	VARCHAR(20),		
	E5_PartyCd VARCHAR(1000)
);

SET SESSION sql_mode = '';

LOAD DATA 
	INFILE '/Users/stoneman/Library/CloudStorage/OneDrive-Vanderbilt/Database/project/1/part1/voterDataF22.csv' 
    INTO TABLE voter_data_mega
    FIELDS TERMINATED BY ';' ENCLOSED BY '$'
    LINES TERMINATED BY '\r\n'
    
    (precinct_desc, party_cd, race_code, ethnic_code, sex_code, age, pct_portion, first_name,
	middle_name, last_name, name_suffix_lbl, full_name_mail, mail_addr1,		mail_addr2,
	mail_city_state_zip, house_num, street_dir, street_name, street_type_cd, street_sufx_cd,
	unit_num, res_city_desc, state_cd, zip_code, registr_dt, voter_reg_num, status_cd,		
	municipality_desc, ward_desc, cong_dist_desc,		super_court_desc, nc_senate_desc,
	nc_house_desc, county_commiss_desc, school_dist_desc, E1, @E1_date,		E1_VotingMethod,
	E1_PartyCd, E2, @E2_date, E2_VotingMethod, E2_PartyCd,		E3, @E3_date, E3_VotingMethod,
	E3_PartyCd, E4, @E4_Date, E4_VotingMethod,		E4_PartyCd, E5, @E5_Date,		E5_VotingMethod	,		
	E5_PartyCd)
    
    SET E1_Date = STR_TO_DATE(CASE WHEN @E1_date = '' THEN NULL ELSE @E1_date END,'%m/%d/%Y'),
		E2_Date = STR_TO_DATE(CASE WHEN @E2_date = '' THEN NULL ELSE @E2_date END,'%m/%d/%Y'),
        E3_Date = STR_TO_DATE(CASE WHEN @E3_date = '' THEN NULL ELSE @E3_date END,'%m/%d/%Y'),
        E4_Date = STR_TO_DATE(CASE WHEN @E4_date = '' THEN NULL ELSE @E4_date END,'%m/%d/%Y'),
        E5_Date = STR_TO_DATE(CASE WHEN @E5_date = '' THEN NULL ELSE @E5_date END,'%m/%d/%Y');
    
-- ################################################
-- Now Create and INSERT into new tables
-- ################################################
SET FOREIGN_KEY_CHECKS=0; -- to disable them
#SET FOREIGN_KEY_CHECKS=1; -- to re-enable them
-- Table 1: city_state
DROP TABLE IF EXISTS city_state;
CREATE TABLE IF NOT EXISTS city_state(
	res_city_desc VARCHAR(45),
    state_cd VARCHAR(45),
    PRIMARY KEY (res_city_desc)
);

INSERT INTO city_state (res_city_desc, state_cd)
SELECT DISTINCT res_city_desc, state_cd
FROM voter_data_mega;

-- Table 2: zip_city
DROP TABLE IF EXISTS zip_city;
CREATE TABLE IF NOT EXISTS zip_city(
	zip_code CHAR(5),
    res_city_desc VARCHAR(45),
    PRIMARY KEY (zip_code),
    FOREIGN KEY (res_city_desc) 
		REFERENCES city_state(res_city_desc)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

INSERT INTO zip_city(zip_code, res_city_desc)
SELECT DISTINCT zip_code, res_city_desc
FROM voter_data_mega;

-- Table 3: person 
DROP TABLE IF EXISTS person;
CREATE TABLE IF NOT EXISTS person(
	voter_reg_num BIGINT(20),
    party_cd VARCHAR(255),
    race_code VARCHAR(255),
    ethnic_code VARCHAR(255),
    sex_code VARCHAR(255),
    age TINYINT(3),
    first_name VARCHAR(255),
    middle_name VARCHAR(255),
    last_name VARCHAR(255),
    full_name_mail VARCHAR(255),
    name_suffix_lbl VARCHAR(255),
    registr_dt DATETIME,
    status_cd VARCHAR(255),
    PRIMARY KEY (voter_reg_num)
);

INSERT INTO person
SELECT voter_reg_num, party_cd, race_code, ethnic_code, sex_code, age, first_name, middle_name, last_name,
	full_name_mail, name_suffix_lbl, registr_dt, status_cd
FROM voter_data_mega;

-- Table 4: area
DROP TABLE IF EXISTS area;
CREATE TABLE IF NOT EXISTS area(
	pct_portion CHAR(200),
    precinct_desc VARCHAR(255),
    ward_desc VARCHAR(255),
    cong_dist_desc VARCHAR(255),
    super_court_desc VARCHAR(255),
    nc_senate_desc VARCHAR(255),
    nc_house_desc VARCHAR(255),
    county_commiss_desc VARCHAR(255),
    school_dist_desc VARCHAR(255),
    PRIMARY KEY (pct_portion)
);

INSERT IGNORE INTO area
SELECT pct_portion, precinct_desc,ward_desc, cong_dist_desc, super_court_desc, nc_senate_desc, 
	nc_house_desc, county_commiss_desc, school_dist_desc
FROM voter_data_mega;

-- Table 5: residential_address_info
DROP TABLE IF EXISTS residential_address_info;
CREATE TABLE IF NOT EXISTS residential_address_info(
	voter_reg_num BIGINT(20),
    house_num VARCHAR(45),
    street_dir VARCHAR(45),
    street_type_cd VARCHAR(45),
    street_sufx_cd VARCHAR(45),
    unit_num VARCHAR(45),
    zip_code CHAR(5),
    pct_portion CHAR(200),
    PRIMARY KEY (voter_reg_num),
    FOREIGN KEY (zip_code) 
		REFERENCES zip_city(zip_code)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY (voter_reg_num) 
		REFERENCES person(voter_reg_num)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY (pct_portion) 
		REFERENCES area(pct_portion)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

INSERT IGNORE INTO residential_address_info
SELECT voter_reg_num, house_num, street_dir,street_type_cd, street_sufx_cd,
	unit_num, zip_code, pct_portion
FROM voter_data_mega;

-- Table 6: election
CREATE TABLE IF NOT EXISTS election(
	election_ID INT,
    election_Name CHAR(2),
    election_Date DATE,
    PRIMARY KEY (election_ID)
);

INSERT IGNORE INTO election (election_ID, election_Name, election_Date) 
SELECT DISTINCT E1, 'E1', E1_date FROM voter_data_mega
UNION ALL
SELECT DISTINCT E2, 'E2', E2_date FROM voter_data_mega
UNION ALL
SELECT DISTINCT E3, 'E3', E3_date FROM voter_data_mega
UNION ALL
SELECT DISTINCT E4, 'E4', E4_date FROM voter_data_mega
UNION ALL
SELECT DISTINCT E5, 'E5', E5_date FROM voter_data_mega;

-- Table 7: voting_history
DROP TABLE IF EXISTS voting_history;
CREATE TABLE IF NOT EXISTS voting_history(
	voter_reg_num BIGINT(20),
    election_ID INT,
    voting_method CHAR(1),
    party_cd CHAR(3),
    PRIMARY KEY (voter_reg_num, election_ID),
    FOREIGN KEY (election_ID) 
		REFERENCES election(election_ID)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY (voter_reg_num) 
		REFERENCES person(voter_reg_num)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

INSERT IGNORE INTO voting_history(voter_reg_num, election_ID, voting_method, party_cd)
SELECT voter_reg_num, 1 AS election_ID, E1_VotingMethod AS voting_method, E1_PartyCd AS party_cd
FROM voter_data_mega
WHERE E1_date IS NOT NULL
UNION ALL
SELECT voter_reg_num, 2 AS election_ID, E2_VotingMethod AS voting_method, E2_PartyCd AS party_cd
from voter_data_mega
WHERE E2_date IS NOT NULL
UNION ALL
SELECT voter_reg_num, 3 AS election_ID,  E3_VotingMethod AS voting_method, E3_PartyCd AS party_cd
from voter_data_mega
WHERE E3_date IS NOT NULL
UNION ALL
SELECT voter_reg_num, 4 AS election_ID,  E4_VotingMethod AS voting_method, E4_PartyCd AS party_cd
from voter_data_mega
WHERE E4_date IS NOT NULL
UNION ALL
SELECT voter_reg_num,5 AS election_ID,  E5_VotingMethod AS voting_method, E5_PartyCd AS party_cd
from voter_data_mega
WHERE E5_date IS NOT NULL;

##############################
# SEARCH VOTER
##############################

-- FUNCTIONALITY 1: 
-- Name given voter registration

DROP PROCEDURE IF EXISTS get_name;

DELIMITER //

CREATE PROCEDURE get_name(IN vrn BIGINT(20))

BEGIN

SELECT full_name_mail 
FROM person 
WHERE voter_reg_num = vrn;

END // 

DELIMITER ; 

-- FUNCTIONALITY 2: 
-- Voter history given voter registration

DROP PROCEDURE IF EXISTS get_voting_record;
DELIMITER //

CREATE PROCEDURE get_voting_record(IN vrn BIGINT(20))

BEGIN

SELECT election_ID, voting_method, party_cd FROM voting_history 
WHERE voter_reg_num = vrn;

END // 

DELIMITER ; 

CALL get_voting_record(2);

##############################
# INSERT NEW VOTER
##############################

# Insert voter procedure

DROP PROCEDURE IF EXISTS insert_voter;

DELIMITER // 

CREATE PROCEDURE insert_voter(IN vrn BIGINT(20), 
							 IN fn VARCHAR(255), 
							 IN mn VARCHAR(255), 
							 IN lsn VARCHAR(255), 
							 IN sfx VARCHAR(255), 
							 IN prty VARCHAR(255),
                             OUT msg VARCHAR(255)
							 )

BEGIN

INSERT INTO person(voter_reg_num, first_name, middle_name, last_name, name_suffix_lbl, party_cd)
VALUES(vrn, fn, mn, lsn, sfx, prty);

SELECT 'Insertion Complete' INTO msg;
SELECT msg;

END // 

DELIMITER ;

# Audit table for new registration
-- DROP TABLE IF EXISTS new_voters;
CREATE TABLE IF NOT EXISTS new_voters(
	voter_reg_num BIGINT(20),
    reg_timestamp VARCHAR(255)
);

# Trigger for new registration to be set to N/A

DROP TRIGGER IF EXISTS insertion_confirmation;

DELIMITER // 

CREATE TRIGGER insertion_confirmation 
BEFORE INSERT
ON person
FOR EACH ROW
IF NEW.party_cd NOT IN ('REP', 'DEM', 'UNA') THEN 
SET NEW.party_cd = 'N/A';
END IF;

//

# Trigger for storing audited timestamp

DROP TRIGGER IF EXISTS insertion_timestamp;

DELIMITER // 

CREATE TRIGGER insertion_timestamp
AFTER INSERT
ON person
FOR EACH ROW
INSERT INTO new_voters
VALUES (NEW.voter_reg_num, CURRENT_TIMESTAMP())

//

##############################
# DELETE A VOTER
##############################

DROP PROCEDURE IF EXISTS delete_voter;

DELIMITER // 
CREATE PROCEDURE delete_voter(IN vrn BIGINT(20))

BEGIN
	START TRANSACTION;
	DELETE FROM person 
	WHERE voter_reg_num = vrn;
    COMMIT;
END //

DELIMITER ;

# Audit Table

CREATE TABLE IF NOT EXISTS deleted_voters(
	voter_reg_num BIGINT(20),
    party_cd VARCHAR(255),
    race_code VARCHAR(255),
    ethnic_code VARCHAR(255),
    sex_code VARCHAR(255),
    age TINYINT(3),
    first_name VARCHAR(255),
    middle_name VARCHAR(255),
    last_name VARCHAR(255),
    full_name_mail VARCHAR(255),
    name_suffix_lbl VARCHAR(255),
    registr_dt DATETIME,
    status_cd VARCHAR(255)
    
);

CREATE TRIGGER delete_audit
AFTER DELETE
ON person
FOR EACH ROW
INSERT INTO deleted_voters
VALUES (OLD.voter_reg_num ,
    OLD.party_cd,
    OLD.race_code,
    OLD.ethnic_code,
    OLD.sex_code,
    OLD.age,
    OLD.first_name,
    OLD.middle_name,
    OLD.last_name,
    OLD.full_name_mail,
    OLD.name_suffix_lbl,
    OLD.registr_dt,
    OLD.status_cd);

##############################
# TESTING
##############################

CALL insert_voter(4, 'q', 'w', 'e', 'r', 'APDSJFS', @msg);
CALL delete_voter(5);
SELECT * FROM person;
SELECT * FROM deleted_voters;
SELECT * FROM new_voters;


SELECT @msg;
SELECT * FROM person;




##############################
# ANALYTICS 1
##############################

# Get Constituents Stats

DROP VIEW IF EXISTS constituent_stats;
CREATE VIEW constituent_stats AS
SELECT
  party_cd,
  COUNT(*),
  (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM person) AS percentage
FROM person
GROUP BY party_cd
ORDER BY COUNT(*) DESC;

# Get Dem Regional Stats

DROP VIEW IF EXISTS intermediate_results;
CREATE VIEW intermediate_results AS
SELECT res_city_desc
FROM (	SELECT 	voter_reg_num 
					FROM	person) as DEM_vrn
		JOIN residential_address_info USING(voter_reg_num)
		JOIN voting_history USING(voter_reg_num)
		JOIN zip_city USING(zip_code)
WHERE voting_history.party_cd = 'DEM';
DROP VIEW IF EXISTS dem_region_stats;
CREATE VIEW dem_region_stats AS
SELECT
	res_city_desc,
	COUNT(*),
	(COUNT(*) * 100.0) / (SELECT COUNT(*) FROM intermediate_results) AS percentage
FROM	intermediate_results
GROUP BY res_city_desc
ORDER BY COUNT(*) DESC;

# Get Dem Gender Stats

DROP VIEW IF EXISTS dem_gender_stats;
CREATE VIEW dem_gender_stats AS
SELECT
	sex_code,
	COUNT(sex_code),
	(COUNT(*) * 100.0) / (SELECT COUNT(*) FROM person WHERE party_cd = 'DEM') AS percentage
FROM	person
WHERE party_cd = 'DEM'
GROUP BY sex_code
ORDER BY COUNT(*) DESC;

# Get switch number

DROP PROCEDURE IF EXISTS switched_election;
DELIMITER //

CREATE PROCEDURE switched_election(IN party CHAR(10), IN num TINYINT)

BEGIN

SELECT COUNT(*) AS first_name
FROM 	voting_history
JOIN	(SELECT voter_reg_num, party_cd
		FROM person
		WHERE party_cd = party) AS eligible_vrn
        USING(voter_reg_num)
WHERE 	election_ID = num AND NOT eligible_vrn.party_cd = voting_history.party_cd;

END // 

DELIMITER ; 

##############################
# ANALYTICS 2
##############################

# Customer1 Stats

DROP VIEW IF EXISTS custom1;
CREATE VIEW custom1 AS
SELECT 
  CASE # Do the age classification, classifying different ages into different categories
    WHEN age BETWEEN 0 AND 20 THEN '0-20'
    WHEN age BETWEEN 21 AND 40 THEN '21-40'
    WHEN age BETWEEN 41 AND 60 THEN '41-60'
    WHEN age BETWEEN 61 AND 80 THEN '61-80'
    WHEN age BETWEEN 81 AND 100 THEN '81-100'
    ELSE '101-120'
  END AS age_range, 
  COUNT(*)
FROM person
GROUP BY age_range
ORDER BY COUNT(*) DESC;

# Customer2 Stats

DROP VIEW IF EXISTS custom2;
CREATE VIEW custom2 AS
SELECT 
  age_range, 
  CASE # Find the most popular parties in different age range
    WHEN MAX(dem_proportion) >= MAX(rep_proportion) AND MAX(dem_proportion) >= MAX(other_proportion) THEN 'DEM'
    WHEN MAX(rep_proportion) >= MAX(dem_proportion) AND MAX(rep_proportion) >= MAX(other_proportion) THEN 'REP'
    ELSE 'Other' # Classify all the parties other than DEM or REP into Other
  END AS highest_proportion
FROM (
  SELECT 
    CASE # Do the age classification, classifying different ages into different categories
      WHEN age BETWEEN 0 AND 20 THEN '0-20'
      WHEN age BETWEEN 21 AND 40 THEN '21-40'
      WHEN age BETWEEN 41 AND 60 THEN '41-60'
      WHEN age BETWEEN 61 AND 80 THEN '61-80'
      WHEN age BETWEEN 81 AND 100 THEN '81-100'
      ELSE '101-120'
    END AS age_range, 
    SUM(CASE WHEN party_cd = 'DEM' THEN 1 ELSE 0 END) / COUNT(*) AS dem_proportion,
    SUM(CASE WHEN party_cd = 'REP' THEN 1 ELSE 0 END) / COUNT(*) AS rep_proportion,
    SUM(CASE WHEN (NOT party_cd = 'REP' AND NOT party_cd = 'DEM') THEN 1 ELSE 0 END) / COUNT(*) AS other_proportion
  FROM person
  GROUP BY age_range
) AS party_proportions
GROUP BY age_range
ORDER BY age_range;








