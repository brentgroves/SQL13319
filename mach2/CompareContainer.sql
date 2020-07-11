-- DROP TABLE IF EXISTS CompareContainer
-- truncate CompareContainer
CREATE TABLE CompareContainer(
  CompareContainer_Key INT NOT NULL AUTO_INCREMENT, 
  TransDate datetime DEFAULT NULL,
  PCN varchar(50) NULL,
  Workcenter varchar(50) NULL,
  CNC varchar(25) NULL,
  Name varchar(50) NULL,
  Part_No varchar(50) NULL,
  Serial_No varchar(50) NULL,
  tst_Serial_No varchar(50) NULL,
  Quantity INT NULL,
  tst_Quantity INT NULL,
  Container_Status varchar(50),
  Status varchar(50),
  PRIMARY KEY (CompareContainer_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
select * from SetupContainer sc 

set @transDate = '2020-07-09 09:45:00';
-- set @transDate = '2020-06-25 00:00:00';
-- delete from CompareContainer where CompareSetupContainer_Key = 3
-- call CompareContainer(@transDate); 
-- select * from CompareContainer limit 10 offset 0
set @startDate = '2020-07-09 11:30:00';
set @endDate = '2020-07-09 15:30:00';
-- set @startDate = '2020-07-09T11:30:00.000Z';  -- 1
-- set @endDate = '2020-07-09T15:30:00.000Z'; -- 234
select @pRecordCount := count(*) from CompareContainer where transDate between @startDate and @endDate order by CompareContainer_Key;
select @pRecordCount;
select * from CompareContainer where transDate between @startDate and @endDate ORDER BY CompareContainer_Key LIMIT 100 OFFSET 0;
   	-- SELECT ROW_COUNT(); -- -1
   	select FOUND_ROWS(); --  144
select count(*) from CompareContainer where transDate between @startDate and @endDate ORDER BY CompareContainer_Key 

-- drop procedure CompareContainer
CREATE DEFINER=`brent`@`%` PROCEDURE `mach2`.`CompareContainer`(
    IN  p_TransDate VARCHAR(25)
)
BEGIN
	
/* set @p_TransDate = '2019-12-15 09:00'; */
drop temporary table if exists ProdServer;
create temporary table ProdServer engine=memory	
select 
TransDate,PCN,Workcenter,CNC,Name,Part_no,Serial_No,ProdServer,Quantity,Container_Status 
from SetupContainer 
where TransDate = p_TransDate and ProdServer = 1; 

drop temporary table if exists TestServer;
create temporary table TestServer engine=memory	
select 
TransDate tst_TransDate,PCN tst_PCN,Workcenter tst_Workcenter,CNC tst_CNC,Name tst_Name, Part_no tst_Part_No,Serial_No tst_Serial_No,ProdServer tst_ProdServer,Quantity tst_Quantity,Container_Status tst_Container_Status
from SetupContainer 
where TransDate = p_TransDate and ProdServer = 0; 

insert into CompareContainer ( TransDate,PCN,Workcenter,CNC,Name,Part_No,Serial_No,tst_Serial_No,Quantity,tst_Quantity,Container_Status,Status)
(
	select 
	TransDate,PCN, Workcenter,CNC,Name,Part_no,Serial_No,tst_Serial_No, Quantity,tst_Quantity, Container_Status,
	case 
	when Serial_No <> tst_Serial_No then 'Red'
	when ((Serial_No = tst_Serial_No) and (Quantity <> tst_Quantity)) then 'Yellow'
	when ((Serial_No = tst_Serial_No) and (Quantity = tst_Quantity)) then 'Green'
	when ((Serial_No = tst_Serial_No) and (Quantity is Null) and (tst_Quantity is Null)) then 'Green'
	end Status
	from ProdServer ps
	left outer join TestServer ts
	on ps.TransDate = ts.tst_TransDate
	and ps.PCN = ts.tst_PCN
	and ps.Workcenter = ts.tst_Workcenter
	and ps.Part_No = ts.tst_Part_No
	and ps.Container_Status= ts.tst_Container_Status
);
select 
TransDate,PCN,Workcenter,CNC,Name,Part_No,Serial_No,tst_Serial_No,Quantity,tst_Quantity,Container_Status,Status
from CompareContainer
where TransDate = p_TransDate
order by TransDate,Part_no,Serial_no,Container_Status;

END;


set @startDate = '2020-07-09 11:30:00';
set @endDate = '2020-07-09 15:30:00';
-- set @startDate = '2020-07-09T11:30:00.000Z';  -- 1
-- set @endDate = '2020-07-09T15:30:00.000Z'; -- 234
select count(*) 
into @pRecordCount
from CompareContainer where transDate between @startDate and @endDate ORDER BY CompareContainer_Key;
select @pRecordCount;


set @startDate = '2020-07-09 11:30:00';
set @endDate = '2020-07-09 15:30:00';
call CompareContainerFetch(@startDate,@endDate,90,2, @rec); 
select @rec;
-- drop procedure CompareContainerFetch
CREATE DEFINER=`brent`@`%` PROCEDURE CompareContainerFetch (
	pStartDate DATETIME,
	pEndDate DATETIME,
	pLimit int,
	pSkip int,
	OUT pRecordCount INT 
)
BEGIN

	DECLARE startDate,endDate DATETIME;
	DECLARE startWeek,endWeek INT;

	set startDate =pStartDate;
	set endDate =pEndDate;

	select 
	CompareContainer_Key,
	-- convert_tz(TransDate,'UTC',@@session.time_zone) TransDate,
	-- CONVERT_TZ( TransDate, 'UTC','America/Fort_Wayne' ) TransDate,
	date_format(TransDate, '%Y-%m-%d %H:%i') TransDate,
 	PCN,
 	Workcenter,
 	CNC,
 	Name,
 	Part_No,
 	Serial_No,
 	tst_Serial_No,
 	Quantity,
 	tst_Quantity,
 	Container_Status,
 	Status 
	from CompareContainer where transDate between pStartDate and pEndDate ORDER BY CompareContainer_Key LIMIT pLimit OFFSET pSkip; 
	-- select * from CompareContainer where transDate between pStartDate and pEndDate ORDER BY CompareContainer_Key LIMIT pLimit OFFSET pSkip;  
	-- select @pRecordCount := count(*) from CompareContainer where transDate between pStartDate and pEndDate;
	-- set pRecordCount = @pRecordCount;
	select count(*) 
	into pRecordCount
	from CompareContainer 
	where transDate between pStartDate and pEndDate;	

   	-- SELECT ROW_COUNT(); -- 0
   	-- set pRecordCount = FOUND_ROWS();
end;





