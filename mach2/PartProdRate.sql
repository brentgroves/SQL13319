-- drop table PartProdRate
-- truncate table PartProdRate
create table PartProdRate
(
  PartProdRate_Key INT NOT NULL AUTO_INCREMENT, 
  part_key long,
  part_no varchar (113),  
  period int,
  start_date datetime,
  end_date datetime,
  quantity int,
  rate decimal (9,2),	
  PRIMARY KEY (PartProdRate_Key)  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- LOAD DATA INFILE '/prod0.csv' INTO TABLE PartProdRate FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA INFILE '/prod0.csv' INTO TABLE PartProdRate FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (part_key,part_no,period,start_date,end_date,quantity,rate);

LOAD DATA INFILE '/prod0.csv'
INTO TABLE PartProdRate 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(part_key,part_no,period,start_date,end_date,quantity,rate);

select * from PartProdRate ppr 
order by end_date desc


set @startPeriod =  0;
set @endPeriod = 4;
select count(*) 
into @pRecordCount
from PartProdRate ppr where period between @startPeriod and @endPeriod ORDER BY PartProdRate_Key;
select @pRecordCount;


set @startPeriod =  0;
set @endPeriod = 4;
call PartProdRateFetch(@startPeriod,@endPeriod,90,0, @rec); 
select @rec;
-- drop procedure PartProdRateFetch
CREATE DEFINER=`brent`@`%` PROCEDURE PartProdRateFetch (
	pStartPeriod int,
	pEndPeriod int,
	pLimit int,
	pSkip int,
	OUT pRecordCount INT 
)
BEGIN

	select 
	PartProdRate_Key,
	part_key,
	part_no,
	period,
	date_format(start_date, '%Y-%m-%d %H:%i') start_date,
	date_format(end_date, '%Y-%m-%d %H:%i') end_date,
	Quantity,
	Rate
	-- format(Quantity/480,2) ProdRate
	from PartProdRate ppr where period between pStartPeriod and pEndPeriod ORDER BY PartProdRate_Key LIMIT pLimit OFFSET pSkip; 
	-- select * from CompareContainer where transDate between pStartDate and pEndDate ORDER BY CompareContainer_Key LIMIT pLimit OFFSET pSkip;  
	-- select @pRecordCount := count(*) from CompareContainer where transDate between pStartDate and pEndDate;
	-- set pRecordCount = @pRecordCount;
	select count(*) 
	into pRecordCount
	from PartProdRate ppr 
	where period between pStartPeriod and pEndPeriod;	

   	-- SELECT ROW_COUNT(); -- 0
   	-- set pRecordCount = FOUND_ROWS();
end;


