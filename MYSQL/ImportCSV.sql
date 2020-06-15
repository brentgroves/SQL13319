-- /home/brent/srcsql/bpgsql/kors/MySQL/Import.csv
-- https://www.mysqltutorial.org/import-csv-file-mysql-table/

/*
 * Export data from the production Kors database and import it into the MySQL docker container.
 * 1. Go to the production Kors database at 10.30.1.17 and run the following query:
 */
select 
	Workcenter_Code,
	Job_number,
	Part_number,
	Data_hour,
	Hourly_planned_production_count,
	Hourly_actual_production_count,
	Cumulative_planned_production_count,
	Cumulative_actual_production_count,
	scrap_count,
	Downtime_minutes,
	Date_time_stamp
from HourlyOEEValues ho 
-- Production count
select count(*) HourlyOEEValues from HourlyOEEValues;  -- 06/15,49000
/*
 * 2 choose export from the result window’s context menu.
 *   choose utf-8, quote always disabled, and select quote never.
 * 3. Use nvim to verify csv looks ok.
 * 4. Open a new terminal on host and go to CSV files directory.
 * Rename CSV file to Kors.csv.
 * sudo docker cp Kors.csv db:/Kors.csv
 * Open terminal and open an interactive terminal to the running docker container. 
 * sudo sudo docker exec -it db /bin/bash
 * Run ls command to verify the file transferred.
 * Run the following command from dbeaver
 */

-- BE CAREFUL WITH TRUNCATE!!!!!
-- MAKE SURE YOU ARE ON THE CONTAINER AND NOT THE PRODUCTION SYSTEM !!!!!!!!!!1
select count(*) HourlyOEEValues from HourlyOEEValues;  -- 672 = 06/14,
-- !!!!!!!!! TRUNCATE TABLE HourlyOEEValues;  BE CAREFUL YOU ARE CONNECTED TO THE DOCKER CONTAINER!!!!!!!!!!!!!!!!



/*
 * PATH IS LOCAL TO THE DATABASE SERVER IN THIS CASE
 * would have to move import file to docker container.
 */
LOAD DATA INFILE '/Kors.csv'  
INTO TABLE HourlyOEEValues
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(	Workcenter_Code,
	Job_number,
	Part_number,
	Data_hour,
	Hourly_planned_production_count,
	Hourly_actual_production_count,
	Cumulative_planned_production_count,
	Cumulative_actual_production_count,
	scrap_count,
	Downtime_minutes,
	Date_time_stamp)
	
select count(*) HourlyOEEValues from HourlyOEEValues;  -- 49,898 = 06/15,
select * from HourlyOEEValues LIMIT 100 OFFSET 0; 

/*
 * This path is local to the database client and it will not be usable
 * unless special privilidges are configured in the database.  I
 * have not imported data from the client filesystem yet. 
 */
LOAD DATA LOCAL INFILE  '/home/brent/srcsql/bpgsql/kors/MySQL/Import.csv'
INTO TABLE discounts
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(title,@expired_date,amount)
SET expired_date = STR_TO_DATE(@expired_date, '%m/%d/%Y');


/*
 * This section was for something else beside App13319
 */


-- TRUNCATE TABLE PlxAlbSupplyItem0612;
-- DROP TABLE PlxAlbSupplyItem0612;
CREATE TABLE PlxAlbSupplyItem0612 (
	item_no varchar(50),
	brief_description varchar (100)
)

LOAD DATA
  INFILE '/AlbionLE10000.csv'
  INTO TABLE PlxAlbSupplyItem0612
  FIELDS
    TERMINATED BY ','
    ESCAPED BY '"'
  LINES
    TERMINATED BY '\n'
  --IGNORE 1 LINES
;

LOAD DATA
  INFILE '/AlbionLE10000.csv'
  INTO TABLE PlxAlbSupplyItem0612
  FIELDS
    TERMINATED BY ','
    ESCAPED BY '#'
  LINES
    TERMINATED BY '\n'
(item_no,@brief_description)    
SET brief_description = REPLACE(@brief_description,'@','"');    
  --IGNORE 1 LINES
;


LOAD DATA INFILE '/AlbionLE10000.csv'  
INTO TABLE PlxAlbSupplyItem0612
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS
(item_no,brief_description)
SET expired_date = STR_TO_DATE(@expired_date, '%m/%d/%Y');

select * from PlxAlbSupplyItem0612







