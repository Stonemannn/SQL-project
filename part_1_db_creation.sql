-- Jiayu Shi
-- jiayu.shi@vanderbilt.edu
-- Project 1

DROP DATABASE IF EXISTS project_1;

CREATE DATABASE project_1;

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
        E1_date CHAR(20), 
        E1_VotingMethod CHAR(10),
        E1_PartyCd CHAR(10), 
        E2 SMALLINT, 
        E2_Date CHAR(20), 
        E2_VotingMethod CHAR(10), 
        E2_PartyCd CHAR(10), 
        E3 SMALLINT, 
        E3_Date CHAR(20), 
        E3_VotingMethod CHAR(10), 
        E3_PartyCd CHAR(10), 
        E4 SMALLINT, 
        E4_Date CHAR(20), 
        E4_VotingMethod CHAR(10), 
        E4_PartyCd CHAR(10), 
        E5 SMALLINT, 
        E5_Date CHAR(20), 
        E5_VotingMethod CHAR(10), 
        E5_PartyCd CHAR(10)
) ENGINE = INNODB;


LOAD DATA
    INFILE '/Users/stoneman/Library/CloudStorage/OneDrive-Vanderbilt/Database/project/1/voterDataF22.csv'
    INTO TABLE data
    FIELDS 	TERMINATED BY ';' 
			ENCLOSED BY '$'
	LINES TERMINATED BY '\r\n';
-- 	(precinct_desc, party_cd, race_code, ethnic_code, sex_code, age, pct_portion, first_name, middle_name, last_name, name_suffix_lbl, full_name_mail, mail_addr1, mail_addr2, mail_city_state_zip, house_num, street_dir, street_name, street_type_cd, street_sufx_cd, unit_num, res_city_desc, state_cd, zip_code, registr_dt, voter_reg_num, status_cd, municipality_desc, ward_desc, cong_dist_desc, super_court_desc, nc_senate_desc, nc_house_desc, county_commiss_desc, school_dist_desc, E1, E1_date, E1_VotingMethod,E1_PartyCd, E2, E2_Date, E2_VotingMethod, E2_PartyCd, E3, E3_Date, E3_VotingMethod, E3_PartyCd, E4, E4_Date, E4_VotingMethod, E4_PartyCd, E5, E5_Date, E5_VotingMethod , E5_PartyCd);
-- 	(E1_date)
-- 	SET E1_date = STR_TO_DATE(@E1_date, '%d/%m/%Y');



-- Q7
SELECT street_sufx_cd, street_dir, COUNT(*)
  FROM data
  GROUP BY street_sufx_cd, street_dir;

-- Q8a
SELECT count(*)
FROM data 
WHERE nc_senate_desc = '';

-- Q8b
SELECT full_name_mail
FROM data
WHERE precinct_desc = '' 
		AND NOT(E1_PartyCd='' AND E2_PartyCd='' AND E3_PartyCd='' AND E4_PartyCd='' AND E5_PartyCd='');
-- 40 voters

-- Q8c
SELECT full_name_mail, mail_addr1 
FROM data
WHERE NOT RIGHT(precinct_desc,3) = LEFT(pct_portion,3);

-- Q8d
SELECT count(*)
FROM data
WHERE sex_code ='F' AND party_cd = 'DEM';
