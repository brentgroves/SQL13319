	select 
		cp.CNC_Part_Operation_Assembly_Key, 
		c.CNC, 
		p.Name,
		CONCAT(CONCAT(p.Part_No," Rev"),p.Revision) Part_No, 
		o.Operation_Code,
		ta.Assembly_No,
		ta.Description, 
		cp.Tool_Life,
		tc.Actual_Tool_Assembly_Life,
		tc.Trans_Date 
		from Tool_Assembly_Change_History tc 
		inner join CNC c 
		on tc.CNC_Key = c.CNC_Key  -- 1 to 1 
		inner join CNC_Part_Operation_Assembly cp 
		on tc.CNC_Key = cp.CNC_Key 
		and tc.Part_Key = cp.Part_Key 
		and tc.Operation_Key = cp.Operation_Key 
		and tc.Assembly_Key = cp.Assembly_Key  -- 1 to 1 
		inner join Part p 
		on tc.Part_Key = p.Part_Key -- 1 to 1
		inner join Operation o 
		on tc.Operation_Key = o.Operation_Key -- 1 to 1
		inner join Tool_Assembly ta  
		on tc.Assembly_Key=ta.Assembly_Key -- 1 to 1
		where tc.Trans_Date BETWEEN '2020-09-05 09:50:00' and '2020-09-08 23:59:59'
		
		
  set @startDate = '2020-09-05 09:50:00';
  set @endDate = '2020-10-03 23:59:59';
  set @tableName = 'rpt0909a';
-- select * from rpt0909a;
-- select @returnValue;
-- drop table rpt0909a;
call WeeklyToolChangeSummary(@startDate,@endDate,@tableName,@recordCount,@returnValue);
-- drop procedure WeeklyToolChangeSummary;
CREATE DEFINER=`brent`@`%` PROCEDURE `mach2`.`WeeklyToolChangeSummary`(
	pStartDate DATETIME,
	pEndDate DATETIME,
	pTableName varchar(12),
	OUT pRecordCount INT,
	OUT pReturnValue INT
	
)
BEGIN
	DECLARE startDate,endDate,startWeekStartDate,endWeekEndDate DATETIME;
	DECLARE tableName varchar(12);
	DECLARE startWeek,endWeek INT;

	SET tableName = pTableName;
	set startDate =pStartDate;
	set endDate =pEndDate;
	SET tableName = pTableName;  
-- /* 
    -- https://www.w3resource.com/mysql/date-and-time-functions/mysql-week-function.php
    -- Week 1 is the first week with a sunday; range: 0 - 53
	-- 52 -- set @startDate ='2019-12-31 00:00:00';  
	-- 0 -- set @startDate ='2020-01-01 00:00:00';  
	-- 1 -- set @startDate ='2020-01-05 00:00:00';  
	-- set @startDate ='2020-02-15 00:00:00';
	-- set @endDate ='2020-02-09 23:59:59';	
	-- SET @tableName = 'TempTable';  -- Debug 
-- */
	SET @sqlQuery = CONCAT('DROP TABLE IF EXISTS ',tableName);
   	PREPARE stmt FROM @sqlQuery;
	execute stmt;
    DEALLOCATE PREPARE stmt;
 
    -- STD_WEEK() is a user function that mimics TSQL 
   	set startWeek = STD_WEEK(startDate);
	set endWeek = STD_WEEK(endDate);

	set startWeekStartDate = FIRST_DAY_OF_WEEK(startDate);
	set endWeekEndDate = LAST_DAY_OF_WEEK(endDate);
    IF @DEBUG then
      	INSERT INTO debugger VALUES (CONCAT('[WeeklyToolChangeSummary:startDate=',startDate,',endDate=',endDate,',startWeek=',startWeek,',endWeek=',endWeek,',startWeekStartDate=',startWeekStartDate,',endWeekEndDate=',endWeekEndDate,']'));
	End If;

	DROP temporary TABLE IF EXISTS primary_key;
	create temporary table primary_key 
	(
	  primary_key int,
	  year_week int,
  	  year_week_fmt varchar(10),
      start_week datetime,
	  end_week datetime,
	  CNC_Key int,
	  Part_Key int,
	  Operation_Key int,
	  Assembly_Key int,
	  CNC varchar(10), 
	  Name varchar(100),
	  Part_No varchar(100), 
	  Operation_Code varchar(30),
	  Assembly_No varchar(50),
	  Description varchar(100), 
	  Tool_Life int
	  
	) ENGINE = MEMORY;

	insert into primary_key(primary_key,year_week,year_week_fmt,start_week,end_week,CNC_Key,Part_Key,Operation_Key,Assembly_Key,
	CNC,Name,Part_No,Operation_Code,Assembly_No,Description,Tool_Life)
	(
	  select 
	  ROW_NUMBER() OVER (
	    ORDER BY year * 100 + week,CNC_Key,Part_Key,Operation_Key,Assembly_Key
	  ) primary_key,
	  year * 100 + week year_week,
	  CASE 
	  when week < 10 then CONCAT(year,'-0',week)
	  else CONCAT(year,'-',week) 
	  end year_week_fmt,
	  start_week,
	  end_week,
	  CNC_Key,
	  Part_Key,
	  Operation_Key,
	  Assembly_Key,
	  CNC, 
	  Name,
	  Part_No, 
	  Operation_Code,
	  Assembly_No,
	  Description, 
	  Tool_Life
	  from 
	  (
	    select
	    YEAR(tc.Trans_Date) year,
	    STD_WEEK(tc.Trans_Date) week,
		FIRST_DAY_OF_WEEK(tc.Trans_Date) start_week,
	  	LAST_DAY_OF_WEEK(tc.Trans_Date) end_week,
	    tc.CNC_Key,
	    tc.Part_Key,
	    tc.Operation_Key,
	    tc.Assembly_Key,
		c.CNC, 
		p.Name,
		CONCAT(CONCAT(p.Part_No," Rev"),p.Revision) Part_No, 
		o.Operation_Code,
		ta.Assembly_No,
		ta.Description, 
		cp.Tool_Life
	    from Tool_Assembly_Change_History tc 
		inner join CNC c 
		on tc.CNC_Key = c.CNC_Key  -- 1 to 1 
		inner join CNC_Part_Operation_Assembly cp 
		on tc.CNC_Key = cp.CNC_Key 
		and tc.Part_Key = cp.Part_Key 
		and tc.Operation_Key = cp.Operation_Key 
		and tc.Assembly_Key = cp.Assembly_Key  -- 1 to 1 
		inner join Part p 
		on tc.Part_Key = p.Part_Key -- 1 to 1
		inner join Operation o 
		on tc.Operation_Key = o.Operation_Key -- 1 to 1
		inner join Tool_Assembly ta  
		on tc.Assembly_Key=ta.Assembly_Key -- 1 to 1
	    where Trans_Date between startWeekStartDate and endWeekEndDate
	  )s1 
	  group by year,week,start_week,end_week,CNC_Key,Part_Key,Operation_Key,Assembly_Key,CNC,Name,Part_No,Operation_Code,Assembly_No,Description,Tool_Life

	);  
	-- select * from primary_key;
	
	DROP temporary TABLE IF EXISTS set2group;
	create temporary table set2group
	(
		primary_key int,
		Actual_Tool_Assembly_Life int
	) ENGINE = MEMORY;

	insert into set2group (primary_key,Actual_Tool_Assembly_Life)
	(
		select
		pk.primary_key, 
		Actual_Tool_Assembly_Life
		from primary_key pk
		inner join
		(
		  select
		    YEAR(Trans_Date) * 100 + STD_WEEK(Trans_Date) year_week,
		    CNC_Key,
		    Part_Key,
		    Operation_Key,
		    Assembly_Key,
			Actual_Tool_Assembly_Life
		  from Tool_Assembly_Change_History 
		  where Trans_Date between startWeekStartDate and endWeekEndDate
		) tl
		on pk.year_week=tl.year_week
		and pk.CNC_Key=tl.CNC_Key 
		and pk.Part_Key=tl.Part_Key 
		and pk.Operation_Key=tl.Operation_Key 
		and pk.Assembly_Key=tl.Assembly_Key
	);
	-- select * from set2group limit 100;

	DROP temporary TABLE IF EXISTS results;
	create temporary table results
	(
	  primary_key int,
  	  year_week_fmt varchar(10),
  	  start_week varchar(12),
	  end_week varchar(12),
	  CNC_Key int,
	  Part_Key int,
	  Operation_Key int,
	  Assembly_Key int,
	  CNC varchar(10), 
	  Name varchar(100),
	  Part_No varchar(100), 
	  Operation_Code varchar(30),
	  Assembly_No varchar(50),
	  Description varchar(100), 
	  Tool_Life int,
	  Avg_Tool_Life int
	) ENGINE = MEMORY;
	insert into results (primary_key,year_week_fmt,start_week,end_week,CNC_Key,Part_Key,Operation_Key,Assembly_Key,
	CNC,Name,Part_No,Operation_Code,Assembly_No,Description,Tool_Life,Avg_Tool_Life)
	(
		select
		pk.primary_key,
		pk.year_week_fmt,
		DATE_FORMAT(start_week,'%m/%d/%Y') start_week,
		DATE_FORMAT(end_week,'%m/%d/%Y') end_week,
		pk.CNC_Key,pk.Part_Key,pk.Operation_Key,pk.Assembly_Key,
		pk.CNC,
		pk.Name,
		pk.Part_No,
		pk.Operation_Code,
		pk.Assembly_No,
		pk.Description,
		pk.Tool_Life,
		Avg_Tool_Life
		from
		(
			select
			primary_key,
			round(sum(Actual_Tool_Assembly_Life) / count(*),0) Avg_Tool_Life
			from set2group 
			group by primary_key
		) sg
		inner join primary_key as pk
		on sg.primary_key = pk.primary_key
	);	
	set @sqlQuery = CONCAT('create table ',tableName,' select * from results order by primary_key');
	PREPARE stmt FROM @sqlQuery;
	execute stmt;
    DEALLOCATE PREPARE stmt;

   	-- SELECT ROW_COUNT(); -- 0
	set pRecordCount = FOUND_ROWS();
	set pReturnValue = 1;
end;
