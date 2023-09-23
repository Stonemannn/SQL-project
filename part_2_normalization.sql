-- Jiayu Shi
-- jiayu.shi@vanderbilt.edu
-- Project 1

DROP DATABASE IF EXISTS project_1;

CREATE DATABASE project_1;

-- !!!!!!!! SET project_1 as DEFAULT

DROP TABLE IF EXISTS data;

CREATE TABLE data(
		precinct_desc CHAR(20), 
        party_cd CHAR(10), 
        race_code CHAR(10), 
        ethnic_code CHAR(10), 
        sex_code CHAR(10), 
        age SMALLINT, 
        pct_portion CHAR(20),  -- include not only numeric values
        first_name CHAR(20), 
        middle_name CHAR(20), 
        last_name CHAR(40), 
        name_suffix_lbl CHAR(10), 
        full_name_mail CHAR(60), 
        mail_addr1 CHAR(60), 
        mail_addr2 CHAR(100), 
        mail_city_state_zip CHAR(60), 
        house_num MEDIUMINT, 
        street_dir CHAR(10), 
        street_name CHAR(40), 
        street_type_cd CHAR(10), 
        street_sufx_cd CHAR(10), 
        unit_num CHAR(10),  -- include not only numeric values
        res_city_desc CHAR(20), 
        state_cd CHAR(10), 
        zip_code MEDIUMINT, 
        registr_dt DATETIME, 
        voter_reg_num BIGINT ZEROFILL, 
        status_cd CHAR(10), 
        municipality_desc CHAR(20), 
        ward_desc CHAR(40), 
        cong_dist_desc CHAR(40), 
        super_court_desc CHAR(40), 
        nc_senate_desc CHAR(40), 
        nc_house_desc CHAR(40), 
        county_commiss_desc CHAR(40), 
        school_dist_desc CHAR(40), 
        E1 SMALLINT, 
        E1_Date DATE, 
        E1_VotingMethod CHAR(10),
        E1_PartyCd CHAR(10), 
        E2 SMALLINT, 
        E2_Date DATE, 
        E2_VotingMethod CHAR(10), 
        E2_PartyCd CHAR(10), 
        E3 SMALLINT, 
        E3_Date DATE, 
        E3_VotingMethod CHAR(10), 
        E3_PartyCd CHAR(10), 
        E4 SMALLINT, 
        E4_Date DATE, 
        E4_VotingMethod CHAR(10), 
        E4_PartyCd CHAR(10), 
        E5 SMALLINT, 
        E5_Date DATE, 
        E5_VotingMethod CHAR(10), 
        E5_PartyCd CHAR(10)
) ENGINE = INNODB;


LOAD DATA
    INFILE '/Users/stoneman/Library/CloudStorage/OneDrive-Vanderbilt/Database/project/1/part1/voterDataF22.csv'
    INTO TABLE data
    FIELDS TERMINATED BY ';' 
            ENCLOSED BY '$'
    LINES TERMINATED BY '\r\n'
    (	@precinct_desc,
        party_cd,
        race_code,
        ethnic_code,
        sex_code,
        age,
        pct_portion,
        first_name,
        @middle_name,
        last_name,
        @name_suffix_lbl,
        full_name_mail,
        mail_addr1,
        @mail_addr2,
        mail_city_state_zip,
        house_num,
        @street_dir,
        street_name,
        @street_type_cd,
        @street_sufx_cd,
        @unit_num,
        res_city_desc,
        state_cd,
        zip_code,
        registr_dt,
        voter_reg_num,
        status_cd,
        @municipality_desc,
        @ward_desc,
        @cong_dist_desc,
        @super_court_desc,
        @nc_senate_desc,
        @nc_house_desc,
        @county_commiss_desc,
        @school_dist_desc,
        E1,
        @E1_Date,
        @E1_VotingMethod,
        @E1_PartyCd,
        E2,
        @E2_Date,
        @E2_VotingMethod,
        @E2_PartyCd,
        E3,
        @E3_Date,
        @E3_VotingMethod,
        @E3_PartyCd,
        E4,
        @E4_Date,
        @E4_VotingMethod,
        @E4_PartyCd,
        E5,
        @E5_Date,
        @E5_VotingMethod,
        @E5_PartyCd
    )
SET
	precinct_desc =  NULLIF(@precinct_desc,''),
	middle_name = NULLIF(@middle_name,''),
	name_suffix_lbl = NULLIF(@name_suffix_lbl, ''),
    mail_addr2 = NULLIF(@mail_addr2, ''),
    street_dir = NULLIF(@street_dir, ''),
	street_type_cd = NULLIF(@street_type_cd, ''),
    street_sufx_cd = NULLIF(@street_sufx_cd, ''),
    unit_num = NULLIF(@unit_num, ''),
    municipality_desc = NULLIF(@municipality_desc, ''),
    ward_desc = NULLIF(@ward_desc, ''),
    cong_dist_desc = NULLIF(@cong_dist_desc, ''),
    super_court_desc = NULLIF(@super_court_desc, ''),
    nc_senate_desc = NULLIF(@nc_senate_desc, ''),
    nc_house_desc = NULLIF(@nc_house_desc, ''),
    county_commiss_desc = NULLIF(@county_commiss_desc, ''),
    school_dist_desc = NULLIF(@school_dist_desc, ''),
    E1_VotingMethod = NULLIF(@E1_VotingMethod, ''),
    E1_PartyCd = NULLIF(@E1_PartyCd, ''),
    E2_VotingMethod = NULLIF(@E2_VotingMethod, ''),
    E2_PartyCd = NULLIF(@E2_PartyCd, ''),
    E3_VotingMethod = NULLIF(@E3_VotingMethod, ''),
    E3_PartyCd = NULLIF(@E3_PartyCd, ''),
    E4_VotingMethod = NULLIF(@E4_VotingMethod, ''),
    E4_PartyCd = NULLIF(@E4_PartyCd, ''),
    E5_VotingMethod = NULLIF(@E5_VotingMethod, ''),
    E5_PartyCd = NULLIF(@E5_PartyCd, ''),
    E1_Date = STR_TO_DATE(NULLIF(@E1_Date, ''), '%m/%d/%Y'),
    E2_Date = STR_TO_DATE(NULLIF(@E2_Date, ''), '%m/%d/%Y'),
    E3_Date = STR_TO_DATE(NULLIF(@E3_Date, ''), '%m/%d/%Y'),
    E4_Date = STR_TO_DATE(NULLIF(@E4_Date, ''), '%m/%d/%Y'),
    E5_Date = STR_TO_DATE(NULLIF(@E5_Date, ''), '%m/%d/%Y');



-- First create a new table for the exceptions and one for table dropped exceptions
CREATE TABLE exception_table(
		precinct_desc CHAR(20), 
        party_cd CHAR(10), 
        race_code CHAR(10), 
        ethnic_code CHAR(10), 
        sex_code CHAR(10), 
        age SMALLINT, 
        pct_portion CHAR(20),  -- include not only numeric values
        first_name CHAR(20), 
        middle_name CHAR(20), 
        last_name CHAR(40), 
        name_suffix_lbl CHAR(10), 
        full_name_mail CHAR(60), 
        mail_addr1 CHAR(60), 
        mail_addr2 CHAR(100), 
        mail_city_state_zip CHAR(60), 
        house_num MEDIUMINT, 
        street_dir CHAR(10), 
        street_name CHAR(40), 
        street_type_cd CHAR(10), 
        street_sufx_cd CHAR(10), 
        unit_num CHAR(10),  -- include not only numeric values
        res_city_desc CHAR(20), 
        state_cd CHAR(10), 
        zip_code MEDIUMINT, 
        registr_dt DATETIME, 
        voter_reg_num BIGINT ZEROFILL, 
        status_cd CHAR(10), 
        municipality_desc CHAR(20), 
        ward_desc CHAR(40), 
        cong_dist_desc CHAR(40), 
        super_court_desc CHAR(40), 
        nc_senate_desc CHAR(40), 
        nc_house_desc CHAR(40), 
        county_commiss_desc CHAR(40), 
        school_dist_desc CHAR(40), 
        E1 SMALLINT, 
        E1_Date DATE, 
        E1_VotingMethod CHAR(10),
        E1_PartyCd CHAR(10), 
        E2 SMALLINT, 
        E2_Date DATE, 
        E2_VotingMethod CHAR(10), 
        E2_PartyCd CHAR(10), 
        E3 SMALLINT, 
        E3_Date DATE, 
        E3_VotingMethod CHAR(10), 
        E3_PartyCd CHAR(10), 
        E4 SMALLINT, 
        E4_Date DATE, 
        E4_VotingMethod CHAR(10), 
        E4_PartyCd CHAR(10), 
        E5 SMALLINT, 
        E5_Date DATE, 
        E5_VotingMethod CHAR(10), 
        E5_PartyCd CHAR(10)
) ENGINE = INNODB;

CREATE TABLE cleaned_table(
		precinct_desc CHAR(20), 
        party_cd CHAR(10), 
        race_code CHAR(10), 
        ethnic_code CHAR(10), 
        sex_code CHAR(10), 
        age SMALLINT, 
        pct_portion CHAR(20),  -- include not only numeric values
        first_name CHAR(20), 
        middle_name CHAR(20), 
        last_name CHAR(40), 
        name_suffix_lbl CHAR(10), 
        full_name_mail CHAR(60), 
        mail_addr1 CHAR(60), 
        mail_addr2 CHAR(100), 
        mail_city_state_zip CHAR(60), 
        house_num MEDIUMINT, 
        street_dir CHAR(10), 
        street_name CHAR(40), 
        street_type_cd CHAR(10), 
        street_sufx_cd CHAR(10), 
        unit_num CHAR(10),  -- include not only numeric values
        res_city_desc CHAR(20), 
        state_cd CHAR(10), 
        zip_code MEDIUMINT, 
        registr_dt DATETIME, 
        voter_reg_num BIGINT ZEROFILL, 
        status_cd CHAR(10), 
        municipality_desc CHAR(20), 
        ward_desc CHAR(40), 
        cong_dist_desc CHAR(40), 
        super_court_desc CHAR(40), 
        nc_senate_desc CHAR(40), 
        nc_house_desc CHAR(40), 
        county_commiss_desc CHAR(40), 
        school_dist_desc CHAR(40), 
        E1 SMALLINT, 
        E1_Date DATE, 
        E1_VotingMethod CHAR(10),
        E1_PartyCd CHAR(10), 
        E2 SMALLINT, 
        E2_Date DATE, 
        E2_VotingMethod CHAR(10), 
        E2_PartyCd CHAR(10), 
        E3 SMALLINT, 
        E3_Date DATE, 
        E3_VotingMethod CHAR(10), 
        E3_PartyCd CHAR(10), 
        E4 SMALLINT, 
        E4_Date DATE, 
        E4_VotingMethod CHAR(10), 
        E4_PartyCd CHAR(10), 
        E5 SMALLINT, 
        E5_Date DATE, 
        E5_VotingMethod CHAR(10), 
        E5_PartyCd CHAR(10)
) ENGINE = INNODB;

INSERT INTO cleaned_table
	SELECT *
	FROM data;


SET SQL_SAFE_UPDATES = 0;





/*
-- Then, find out the exceptions and put them into the exception_table

-- I suppose the combination of first_name, middle_name, last_name, name_suffix_lbl is equal to full_name_mail
SELECT *
FROM data
WHERE NOT CONCAT_WS(' ', first_name, middle_name, last_name, name_suffix_lbl) = full_name_mail;
-- 2 rows returned which are exceptions

-- INSERT exceptions into exception_table and drop the exceptions from cleaned_table
INSERT INTO exception_table
	SELECT *
	FROM cleaned_table
	WHERE NOT CONCAT_WS(' ', first_name, middle_name, last_name, name_suffix_lbl) = full_name_mail;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM cleaned_table
WHERE NOT CONCAT_WS(' ', first_name, middle_name, last_name, name_suffix_lbl) = full_name_mail;
*/

/*

-- I suppose the combination of res_city_desc (or municipality_desc), state_cd, zip_code is equal to mail_city_state_zip
SELECT res_city_desc, state_cd, zip_code, mail_city_state_zip
FROM cleaned_table
WHERE NOT CONCAT_WS(' ', res_city_desc, state_cd, zip_code) = mail_city_state_zip;
-- 7815 rows (2%) returned 
SELECT municipality_desc, state_cd, zip_code, mail_city_state_zip
FROM cleaned_table
WHERE NOT CONCAT_WS(' ', municipality_desc, state_cd, zip_code) = mail_city_state_zip
LIMIT 100000;
-- more than 10000 rows returned

-- Check the difference between res_city_desc and municipality_desc
SELECT res_city_desc, municipality_desc
FROM cleaned_table
WHERE NOT res_city_desc = municipality_desc
LIMIT 100000;
-- over 10000 rows returned which means res_city_desc is not equal to municipality_desc

-- I suppose the combination of house_num, street_dir, street_name, street_type_cd, street_sufx_cd, unit_num is equal to mail_addr1
SELECT CONCAT_WS(' # ', CONCAT_WS(' ',house_num, street_dir, street_name, street_type_cd, street_sufx_cd), unit_num ), mail_addr1
FROM cleaned_table
WHERE NOT CONCAT_WS(' # ', CONCAT_WS(' ',house_num, street_dir, street_name, street_type_cd, street_sufx_cd), unit_num ) = mail_addr1
LIMIT 100000;
-- over 10000 rows returned which means my guess is wrong


*/

SELECT DISTINCT state_cd
FROM cleaned_table;
-- There is only one unique value in state_cd: NC. So I maybe drop this field and only add this field back when trying to join back all the table to the original mega table.





-- Try to find the number of distinct values for the last several fields
/*
SELECT DISTINCT status_cd
FROM cleaned_table;
-- 2 rows A and I

SELECT DISTINCT municipality_desc
FROM cleaned_table;
-- 9 rows including NULL

SELECT DISTINCT ward_desc
FROM cleaned_table;
-- 8 rows including NULL

SELECT DISTINCT cong_dist_desc
FROM cleaned_table;
-- 3 rows including NULL

SELECT DISTINCT super_court_desc
FROM cleaned_table;
-- 9 rows including NULL

SELECT DISTINCT nc_senate_desc
FROM cleaned_table;
-- 6 rows including NULL

SELECT DISTINCT nc_house_desc
FROM cleaned_table;
-- 13 rows including NULL

SELECT DISTINCT county_commiss_desc
FROM cleaned_table;
-- 7 rows including NULL

SELECT DISTINCT school_dist_desc
FROM cleaned_table;
-- 7 rows including NULL

SELECT DISTINCT E1
FROM cleaned_table;
-- 1 row: 115

SELECT DISTINCT E1_Date
FROM cleaned_table;
-- 2 rows including NULL and '2018-11-06'

SELECT DISTINCT E1_VotingMethod
FROM cleaned_table;
-- 8 rows including NULL

SELECT DISTINCT E1_PartyCd
FROM cleaned_table;
-- 7 rows including NULL

*/


-- TRY to find camdidate key

SELECT 
	COUNT(*),
    COUNT(DISTINCT first_name, middle_name, last_name, age),
	COUNT(DISTINCT full_name_mail, age),
    COUNT(DISTINCT full_name_mail),
    COUNT(DISTINCT mail_addr1),
    COUNT(DISTINCT registr_dt),
    COUNT(DISTINCT voter_reg_num)
FROM cleaned_table;
--  find voter_reg_num as a candidate key
--  but as (full_name_mail, age) 
--  violates the definition of candidate key on less than 0.1% records, after seperating these records into another table, the violation can be resolved.

-- INSERT exceptions into exception_table and drop the exceptions from cleaned_table
INSERT INTO exception_table
	SELECT *
	FROM cleaned_table
	WHERE (full_name_mail, age) IN
		(SELECT full_name_mail, age
		FROM cleaned_table
		GROUP BY full_name_mail, age
		HAVING COUNT(*) > 1);
-- 145 rows of exception

-- Create a temporary table with the duplicate records
CREATE TEMPORARY TABLE duplicates AS
    SELECT full_name_mail, age
    FROM cleaned_table
    GROUP BY full_name_mail, age
    HAVING COUNT(*) > 1;

-- Delete the duplicates from the original table using the temporary table
DELETE FROM cleaned_table
WHERE (full_name_mail, age) IN
    (SELECT full_name_mail, age
    FROM duplicates);

-- Drop the temporary table
DROP TEMPORARY TABLE duplicates;

-- Now, I have 2 candidate keys: (full_name_mail, age) and voter_reg_num. 
-- I can check them.
SELECT 
	COUNT(*),
	COUNT(DISTINCT full_name_mail, age),
    COUNT(DISTINCT voter_reg_num)
FROM cleaned_table;
-- Two candidate keys Checked.



-- ---------------------------
-- Check functional dependency

-- First, Check the functional dependency: full_name_mail -> first_name, middle_name, last_name, name_suffix_lbl
SELECT full_name_mail  
FROM cleaned_table
GROUP BY  full_name_mail
HAVING COUNT(DISTINCT first_name) > 1 OR COUNT(DISTINCT middle_name)>1 OR COUNT(DISTINCT last_name) >1 OR COUNT(DISTINCT name_suffix_lbl)>1;
-- There are supposed to be 0 rows if FD holds
-- Check what is wrong in this table
SELECT *
FROM cleaned_table
WHERE full_name_mail IN
(SELECT full_name_mail 
FROM cleaned_table
GROUP BY full_name_mail 
HAVING COUNT(DISTINCT first_name) > 1  OR COUNT(DISTINCT middle_name)>1 OR COUNT(DISTINCT last_name) >1 OR COUNT(DISTINCT name_suffix_lbl)>1);
-- There are 4 rows where middle names are wrongly placed into first_name.

-- INSERT these exceptions into exception_table and drop the exceptions from cleaned_table
INSERT INTO exception_table
	SELECT *
	FROM cleaned_table
	WHERE full_name_mail IN
		(SELECT full_name_mail 
		FROM cleaned_table
		GROUP BY full_name_mail 
		HAVING COUNT(DISTINCT first_name) > 1  OR COUNT(DISTINCT middle_name)>1 OR COUNT(DISTINCT last_name) >1 OR COUNT(DISTINCT name_suffix_lbl)>1);
        
-- Create a temporary table with the duplicate records
CREATE TEMPORARY TABLE duplicates AS
		SELECT full_name_mail 
		FROM cleaned_table
		GROUP BY full_name_mail 
		HAVING COUNT(DISTINCT first_name) > 1  OR COUNT(DISTINCT middle_name)>1 OR COUNT(DISTINCT last_name) >1 OR COUNT(DISTINCT name_suffix_lbl)>1;

-- Delete the duplicates from the original table using the temporary table

DELETE FROM cleaned_table
WHERE full_name_mail IN
		(SELECT *
        FROM duplicates);

-- Drop the temporary table
DROP TEMPORARY TABLE duplicates;

-- Check Again the functional dependency: full_name_mail -> first_name, middle_name, last_name, name_suffix_lbl
SELECT full_name_mail  
FROM cleaned_table
GROUP BY  full_name_mail
HAVING COUNT(DISTINCT first_name) > 1 OR COUNT(DISTINCT middle_name)>1 OR COUNT(DISTINCT last_name) >1 OR COUNT(DISTINCT name_suffix_lbl)>1;
-- 0 rows returned means FD holds

-- Then, Check the reverse functional dependency: first_name, middle_name, last_name, name_suffix_lbl   ->  full_name_mail
SELECT first_name, middle_name, last_name, name_suffix_lbl
FROM cleaned_table
GROUP BY first_name, middle_name, last_name, name_suffix_lbl
HAVING NOT (MIN(full_name_mail) <=> MAX(full_name_mail)); /* <=> is NULL safe equality */
-- 0 rows returned means FD holds


/*
-- Second, Check  the functional dependency: mail_addr1 -> house_num, street_name, street_type_cd, street_sufx_cd, unit_num
SELECT mail_addr1  
FROM cleaned_table
GROUP BY  mail_addr1
HAVING COUNT(DISTINCT house_num) > 1 OR COUNT(DISTINCT street_dir)>1 OR COUNT(DISTINCT street_name)>1 OR COUNT(DISTINCT street_type_cd) >1 OR COUNT(DISTINCT street_sufx_cd)>1 OR COUNT(DISTINCT unit_num)>1;
-- 1050 rows returned. Then check what is wrong.

SELECT mail_addr1, house_num, street_dir, street_name, street_type_cd, street_sufx_cd, unit_num
FROM cleaned_table
WHERE mail_addr1 IN (SELECT mail_addr1  
FROM cleaned_table
GROUP BY  mail_addr1
HAVING COUNT(DISTINCT house_num) > 1 OR COUNT(DISTINCT street_dir)>1 OR COUNT(DISTINCT street_name)>1 OR COUNT(DISTINCT street_type_cd) >1 OR COUNT(DISTINCT street_sufx_cd)>1 OR COUNT(DISTINCT unit_num)>1);
-- 4205 rows returned which my guess is wrong. 
*/




-- Third, Check the functional dependency: pct_portion -> precinct_desc
SELECT 	pct_portion,
		COUNT(DISTINCT precinct_desc)
FROM cleaned_table
GROUP BY pct_portion
HAVING COUNT(DISTINCT precinct_desc) > 1;
-- 0 rows returned means FD holds



-- Fourth, Check the functional dependency: nc_senate_desc, precinct_desc -> school_dist_desc
SELECT precinct_desc, nc_senate_desc
FROM cleaned_table
GROUP BY precinct_desc, nc_senate_desc
HAVING NOT (MIN(school_dist_desc) <=> MAX(school_dist_desc)); /* <=> is NULL safe equality */
-- 0 rows returned means FD holds

-- Fifth, Check the functional dependency: nc_senate_desc, precinct_desc -> ward_desc
SELECT precinct_desc, nc_senate_desc
FROM cleaned_table
GROUP BY precinct_desc, nc_senate_desc
HAVING NOT (MIN(ward_desc) <=> MAX(ward_desc)); /* <=> is NULL safe equality */
-- 0 rows returned means FD holds

-- Sixth, Check the functional dependency: nc_senate_desc, precinct_desc -> cong_dist_desc
SELECT precinct_desc, nc_senate_desc
FROM cleaned_table
GROUP BY precinct_desc, nc_senate_desc
HAVING NOT (MIN(cong_dist_desc) <=> MAX(cong_dist_desc)); /* <=> is NULL safe equality */
-- 0 rows returned means FD holds

-- 7th, Check the functional dependency: nc_senate_desc, precinct_desc -> super_court_desc
SELECT precinct_desc, nc_senate_desc
FROM cleaned_table
GROUP BY precinct_desc, nc_senate_desc
HAVING NOT (MIN(super_court_desc) <=> MAX(super_court_desc)); /* <=> is NULL safe equality */
-- 0 rows returned means FD holds

/*
-- 8th, Check the functional dependency: nc_senate_desc, precinct_desc -> nc_house_desc
SELECT precinct_desc, nc_senate_desc
FROM cleaned_table
GROUP BY precinct_desc, nc_senate_desc
HAVING NOT (MIN(nc_house_desc) <=> MAX(nc_house_desc)); /* <=> is NULL safe equality 
-- 2 rows returned means FD doesn't hold
*/

-- 9th, Check the functional dependency: nc_senate_desc, precinct_desc -> county_commiss_desc
SELECT precinct_desc, nc_senate_desc
FROM cleaned_table
GROUP BY precinct_desc, nc_senate_desc
HAVING NOT (MIN(county_commiss_desc) <=> MAX(county_commiss_desc)); /* <=> is NULL safe equality */
-- 0 rows returned means FD holds









-- --------------------------
-- CREATE TABLES
-- As the original table is not even in 1NF because of the repeating groups E1 to E5
-- To make the original table be in 1NF, I can pivot the wide table into long table. But as the final goal is to decompose the original table into 3NF. I can directly decompose the original table into 6 tables at the beginning.
-- The first table contains all the fields before E1 field and E1, E2... E5 as each of these 5 columns has only one single value. And the rest of 5 tables contain voter_reg_num and the relevant Election information, like E1, E1_Date, E1_VotingMethod, E1_PartyCd
-- Then decompose the first table again into voter_registration, voter_identification, voter_address, voter_precinct, constant_value

DROP TABLE IF EXISTS voter_registration;
CREATE TABLE voter_registration(
        voter_reg_num BIGINT ZEROFILL, 
        registr_dt DATETIME NOT NULL, 
        status_cd CHAR(10) NOT NULL,
		party_cd CHAR(10)  NOT NULL, 
        
        PRIMARY KEY(voter_reg_num)
) ENGINE = INNODB;        

/*
DROP TABLE IF EXISTS voter_identification;
CREATE TABLE voter_identification(
		full_name_mail CHAR(60) NOT NULL, 
		age SMALLINT NOT NULL, 
        voter_reg_num BIGINT ZEROFILL, 
        race_code CHAR(10) NOT NULL, 
        ethnic_code CHAR(10) NOT NULL, 
        sex_code CHAR(10) NOT NULL, 
        first_name CHAR(20) NOT NULL, 
        middle_name CHAR(20), 
        last_name CHAR(40) NOT NULL, 
        name_suffix_lbl CHAR(10),
        
        PRIMARY KEY(full_name_mail, age),
		CONSTRAINT fk_voter_identification_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;
*/

DROP TABLE IF EXISTS voter_address;
CREATE TABLE voter_address(
        voter_reg_num BIGINT ZEROFILL, 
        mail_addr1 CHAR(60)  NOT NULL, 
        mail_addr2 CHAR(100), 
        mail_city_state_zip CHAR(60) NOT NULL, 
        house_num MEDIUMINT NOT NULL, 
        street_dir CHAR(10), 
        street_name CHAR(40) NOT NULL, 
        street_type_cd CHAR(10), 
        street_sufx_cd CHAR(10), 
        unit_num CHAR(10),  -- include not only numeric values
        res_city_desc CHAR(20) NOT NULL, 
        zip_code MEDIUMINT NOT NULL,
        
		PRIMARY KEY(voter_reg_num),
		CONSTRAINT fk_voter_address_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE        
) ENGINE = INNODB;


/*
DROP TABLE IF EXISTS voter_precinct;
CREATE TABLE voter_precinct(
        voter_reg_num BIGINT ZEROFILL, 
		pct_portion CHAR(20),  -- include not only numeric values
		precinct_desc CHAR(20), 
        municipality_desc CHAR(20), 
        ward_desc CHAR(40), 
        cong_dist_desc CHAR(40), 
        super_court_desc CHAR(40), 
        nc_senate_desc CHAR(40), 
        nc_house_desc CHAR(40), 
        county_commiss_desc CHAR(40), 
        school_dist_desc CHAR(40),
        
        PRIMARY KEY(voter_reg_num),
		CONSTRAINT fk_voter_precinct_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE        
) ENGINE = INNODB;
*/

DROP TABLE IF EXISTS constant_value;
CREATE TABLE constant_value(
        E1 SMALLINT NOT NULL, 
        E2 SMALLINT NOT NULL,         
		E3 SMALLINT NOT NULL, 
		E4 SMALLINT NOT NULL, 
		E5 SMALLINT NOT NULL, 
		state_cd CHAR(10) NOT NULL
) ENGINE = INNODB;
-- AS this table seems to violate the 3NF, but I has only 1 row, by leaving this table alone can save huge amount of space
-- AS this table only has one row which means no need to have primary key. In the end, when I join every table together, I can natural join this constant_value table to the other table.

DROP TABLE IF EXISTS election_1;
CREATE TABLE election_1(
        voter_reg_num BIGINT ZEROFILL, 
        E1_Date DATE NOT NULL, 
        E1_VotingMethod CHAR(10) NOT NULL,
        E1_PartyCd CHAR(10) NOT NULL,
        
        PRIMARY KEY(voter_reg_num),
		CONSTRAINT fk_election_1_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;
 
 DROP TABLE IF EXISTS election_2;
CREATE TABLE election_2(
        voter_reg_num BIGINT ZEROFILL, 
        E2_Date DATE NOT NULL, 
        E2_VotingMethod CHAR(10) NOT NULL,
        E2_PartyCd CHAR(10) NOT NULL,
        
        PRIMARY KEY(voter_reg_num),
		CONSTRAINT fk_election_2_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;

DROP TABLE IF EXISTS election_3;
CREATE TABLE election_3(
        voter_reg_num BIGINT ZEROFILL, 
        E3_Date DATE NOT NULL, 
        E3_VotingMethod CHAR(10) NOT NULL,
        E3_PartyCd CHAR(10) NOT NULL,
        
        PRIMARY KEY(voter_reg_num),
		CONSTRAINT fk_election_3_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;

DROP TABLE IF EXISTS election_4;
CREATE TABLE election_4(
        voter_reg_num BIGINT ZEROFILL, 
        E4_Date DATE NOT NULL, 
        E4_VotingMethod CHAR(10) NOT NULL,
        E4_PartyCd CHAR(10) NOT NULL,
        
        PRIMARY KEY(voter_reg_num),
		CONSTRAINT fk_election_4_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;

DROP TABLE IF EXISTS election_5;
CREATE TABLE election_5(
        voter_reg_num BIGINT ZEROFILL, 
        E5_Date DATE NOT NULL, 
        E5_VotingMethod CHAR(10) NOT NULL,
        E5_PartyCd CHAR(10) NOT NULL,
        
        PRIMARY KEY(voter_reg_num),
		CONSTRAINT fk_election_5_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;


-- ----------------------
-- Based on the FDs I found, try to decompose the above tables

-- First FD,   full_name_mail -> first_name, middle_name, last_name, name_suffix_lbl
-- And because (full_name_mail, age) and voter_reg_num both are candidate key
-- Which means full_name_mail, age -> voter_reg_num,  voter_reg_num -> full_name_mail, age 
-- Decompose the table voter_identification into 3 tables

/*
DROP TABLE IF EXISTS voter_identification;
CREATE TABLE voter_identification(
		full_name_mail CHAR(60) NOT NULL, 
		age SMALLINT NOT NULL, 
        voter_reg_num BIGINT ZEROFILL, 
        race_code CHAR(10) NOT NULL, 
        ethnic_code CHAR(10) NOT NULL, 
        sex_code CHAR(10) NOT NULL, 
        pct_portion CHAR(20),  -- include not only numeric values
        
        PRIMARY KEY(full_name_mail, age),
		CONSTRAINT fk_voter_identification_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;
*/

DROP TABLE IF EXISTS voter_identification;
CREATE TABLE voter_identification(
		full_name_mail CHAR(60) NOT NULL, 
		age SMALLINT NOT NULL, 
        voter_reg_num BIGINT ZEROFILL, 
        PRIMARY KEY(full_name_mail, age),
		CONSTRAINT fk_voter_identification_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;

DROP TABLE IF EXISTS voter_demographic;
CREATE TABLE voter_demographic(
		voter_reg_num BIGINT ZEROFILL, 
        race_code CHAR(10) NOT NULL, 
        ethnic_code CHAR(10) NOT NULL, 
        sex_code CHAR(10) NOT NULL,
        
        PRIMARY KEY(voter_reg_num),
		CONSTRAINT fk_voter_demographic_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;


DROP TABLE IF EXISTS voter_full_name;
CREATE TABLE voter_full_name(
		full_name_mail CHAR(60) NOT NULL, 
        first_name CHAR(20) NOT NULL, 
        middle_name CHAR(20), 
        last_name CHAR(40) NOT NULL, 
        name_suffix_lbl CHAR(10),
        
        PRIMARY KEY(full_name_mail),
		CONSTRAINT fk_voter_full_name_voter_identification	
			FOREIGN KEY (full_name_mail)
			REFERENCES voter_identification(full_name_mail)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;

-- Second,   pct_portion -> precinct_desc
-- nc_senate_desc, precinct_desc -> ward_desc,	school_dist_desc,	county_commiss_desc, cong_dist_desc,	super_court_desc
-- Because of pct_portion -> precinct_desc, nc_senate_desc, precinct_desc -> ward_desc,	school_dist_desc,	county_commiss_desc, cong_dist_desc,	super_court_desc can be converted into
-- nc_senate_desc, pct_portion -> ward_desc,	school_dist_desc,	county_commiss_desc, cong_dist_desc,	super_court_desc
-- Decompose the table voter_precinct into several tables

DROP TABLE IF EXISTS voter_precinct;
CREATE TABLE voter_precinct(
        voter_reg_num BIGINT ZEROFILL, 
		pct_portion CHAR(20),  -- include not only numeric values
        municipality_desc CHAR(20), 
        nc_senate_desc CHAR(40), 
        nc_house_desc CHAR(40), 
        
        PRIMARY KEY(voter_reg_num),
		CONSTRAINT fk_voter_precinct_voter_registration	
			FOREIGN KEY (voter_reg_num)
			REFERENCES voter_registration(voter_reg_num)
			ON DELETE CASCADE
			ON UPDATE CASCADE        
) ENGINE = INNODB;

DROP TABLE IF EXISTS pct_portion_precinct_desc;
CREATE TABLE pct_portion_precinct_desc(
		pct_portion CHAR(20),  -- include not only numeric values
		precinct_desc CHAR(20), 
        
        PRIMARY KEY(pct_portion)
) ENGINE = INNODB;
-- As pct_portion in the voter_precinct table is not a primary key or unique key. It cannot be a foreign key.

DROP TABLE IF EXISTS ward_desc;
CREATE TABLE ward_desc(
		pct_portion CHAR(20),  -- include not only numeric values
        nc_senate_desc CHAR(40),
		ward_desc CHAR(40), 
                
        UNIQUE KEY(nc_senate_desc, pct_portion)
) ENGINE = INNODB;

DROP TABLE IF EXISTS school_dist_desc;
CREATE TABLE school_dist_desc(
		pct_portion CHAR(20),  -- include not only numeric values
        nc_senate_desc CHAR(40),
		school_dist_desc CHAR(40),
                
        UNIQUE KEY(nc_senate_desc, pct_portion)
) ENGINE = INNODB;

DROP TABLE IF EXISTS county_commiss_desc;
CREATE TABLE county_commiss_desc(
		pct_portion CHAR(20),  -- include not only numeric values
        nc_senate_desc CHAR(40),
        county_commiss_desc CHAR(40), 
                
        UNIQUE KEY(nc_senate_desc, pct_portion)
) ENGINE = INNODB;

DROP TABLE IF EXISTS cong_dist_desc;
CREATE TABLE cong_dist_desc(
		pct_portion CHAR(20),  -- include not only numeric values
        nc_senate_desc CHAR(40),
        cong_dist_desc CHAR(40),
                
        UNIQUE KEY(nc_senate_desc, pct_portion)
) ENGINE = INNODB;

DROP TABLE IF EXISTS super_court_desc;
CREATE TABLE super_court_desc(
		pct_portion CHAR(20),  -- include not only numeric values
        nc_senate_desc CHAR(40),
        super_court_desc CHAR(40), 
                
        UNIQUE KEY(nc_senate_desc, pct_portion)
) ENGINE = INNODB;




-- ----------------------------
-- INSERT data from the original table to the new table structures.

SELECT COUNT(*)
FROM cleaned_table;
-- !!!!!  The total number of rows for the cleaned_table is '383248' 

SELECT COUNT(*)
FROM exception_table;
-- !!!!!  The total number of rows for the exception_table is '149' 

SELECT COUNT(*)
FROM data;
-- !!!!!  The total number of rows for the megatable is '383397'
-- 383397 = 383248 + 149


-- -----------------------
INSERT INTO voter_registration
SELECT    voter_reg_num, registr_dt, status_cd, party_cd 
FROM cleaned_table;

SELECT COUNT(*)
FROM voter_registration;
-- '383248'

-- -----------------------
INSERT INTO voter_address
SELECT  voter_reg_num, 
        mail_addr1, 
        mail_addr2, 
        mail_city_state_zip, 
        house_num, 
        street_dir, 
        street_name, 
        street_type_cd, 
        street_sufx_cd, 
        unit_num,
        res_city_desc, 
        zip_code
FROM cleaned_table;

SELECT COUNT(*)
FROM voter_address;
-- '383248'

-- -----------------------
INSERT INTO voter_identification
SELECT	full_name_mail, 
		age, 
        voter_reg_num
FROM cleaned_table;

SELECT COUNT(*)
FROM voter_identification;
-- '383248' ----------------


-- -----------------------
INSERT INTO voter_demographic
SELECT	voter_reg_num, 
        race_code, 
        ethnic_code, 
        sex_code
FROM cleaned_table;

SELECT COUNT(*)
FROM voter_demographic;
-- '383248' ----------------






-- -----------------------
INSERT INTO voter_full_name
SELECT	DISTINCT full_name_mail, 
        first_name, 
        middle_name, 
        last_name, 
        name_suffix_lbl
FROM cleaned_table;

SELECT COUNT(*)
FROM voter_full_name;
-- '381591' Because I use DISTINCT


-- -----------------------
INSERT INTO voter_precinct
SELECT  voter_reg_num, 
		pct_portion,
        municipality_desc, 
        nc_senate_desc, 
        nc_house_desc
FROM cleaned_table;

SELECT COUNT(*)
FROM voter_precinct;
-- '383248' ----------------


-- -----------------------
INSERT INTO pct_portion_precinct_desc
SELECT DISTINCT pct_portion, precinct_desc
FROM cleaned_table
WHERE pct_portion <> '';

SELECT COUNT(*)
FROM pct_portion_precinct_desc;
-- '135' rows----------------




-- -----------------------
INSERT INTO ward_desc
SELECT DISTINCT pct_portion,
        nc_senate_desc ,
		ward_desc
FROM cleaned_table;

SELECT COUNT(*)
FROM ward_desc;
-- '137' rows----------------


-- -----------------------
INSERT INTO school_dist_desc
SELECT DISTINCT pct_portion,
        nc_senate_desc,
		school_dist_desc
FROM cleaned_table;

SELECT COUNT(*)
FROM school_dist_desc;
-- '137' rows----------------


-- -----------------------
INSERT INTO county_commiss_desc
SELECT DISTINCT pct_portion,
        nc_senate_desc,
        county_commiss_desc
FROM cleaned_table;

SELECT COUNT(*)
FROM county_commiss_desc;
-- '137' rows----------------

-- -----------------------
INSERT INTO cong_dist_desc
SELECT DISTINCT pct_portion,
        nc_senate_desc,
        cong_dist_desc
FROM cleaned_table;

SELECT COUNT(*)
FROM cong_dist_desc;
-- '137' rows----------------

-- -----------------------
INSERT INTO super_court_desc
SELECT DISTINCT pct_portion,
        nc_senate_desc,
		super_court_desc
FROM cleaned_table;

SELECT COUNT(*)
FROM super_court_desc;
-- '137' rows----------------

-- -----------------------
INSERT INTO constant_value
SELECT DISTINCT  E1, 
        E2,         
		E3, 
		E4, 
		E5, 
		state_cd
FROM cleaned_table;

SELECT COUNT(*)
FROM constant_value;
-- ONLY '1' row----------------

-- -----------------------
INSERT INTO election_1
SELECT  voter_reg_num, 
        E1_Date, 
        E1_VotingMethod,
        E1_PartyCd
FROM cleaned_table
WHERE NOT E1_Date IS NULL; -- So there won't be records for those who didn't attend the election

SELECT COUNT(*)
FROM election_1;
-- '208735'----------------


-- -----------------------
INSERT INTO election_2
SELECT  voter_reg_num, 
        E2_Date, 
        E2_VotingMethod,
        E2_PartyCd
FROM cleaned_table
WHERE NOT E2_Date IS NULL; -- So there won't be records for those who didn't attend the election

SELECT COUNT(*)
FROM election_2;
-- '43198'----------------

-- -----------------------
INSERT INTO election_3
SELECT  voter_reg_num, 
        E3_Date, 
        E3_VotingMethod,
        E3_PartyCd
FROM cleaned_table
WHERE NOT E3_Date IS NULL; -- So there won't be records for those who didn't attend the election

SELECT COUNT(*)
FROM election_3;
-- '82831'----------------

-- -----------------------
INSERT INTO election_4
SELECT  voter_reg_num, 
        E4_Date, 
        E4_VotingMethod,
        E4_PartyCd
FROM cleaned_table
WHERE NOT E4_Date IS NULL; -- So there won't be records for those who didn't attend the election

SELECT COUNT(*)
FROM election_4;
-- '23767'----------------

-- -----------------------
INSERT INTO election_5
SELECT  voter_reg_num, 
        E5_Date, 
        E5_VotingMethod,
        E5_PartyCd
FROM cleaned_table
WHERE NOT E5_Date IS NULL; -- So there won't be records for those who didn't attend the election

SELECT COUNT(*)
FROM election_5;
-- '247393'----------------