/*
This report shows the average tool life for each tool assembly for each week
as recorded by the Plex Tool Tracker.  The target tool life is taken from the CNC’s OTLM.SSB subroutine. 
*/

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
	  Building_Key int,
	  Workcenter_Key int,
	  CNC_Key int,
	  Part_Key int,
	  Operation_Key int,
	  Assembly_Key int,
	  Building_No int,
	  Workcenter varchar (100),  -- Name
	  CNC varchar(10), 
	  Name varchar(100),
	  Part_No varchar(100), 
	  Operation_Code varchar(30),
	  Assembly_No varchar(50),
	  Description varchar(100), 
	  STD_Tool_Life int
	  
	) ENGINE = MEMORY;

	insert into primary_key(primary_key,year_week,year_week_fmt,start_week,end_week,Building_Key,Workcenter_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key,
	Building_No,Workcenter,CNC,Name,Part_No,Operation_Code,Assembly_No,Description,STD_Tool_Life)
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
	  Building_Key,
	  Workcenter_Key,
	  CNC_Key,
	  Part_Key,
	  Operation_Key,
	  Assembly_Key,
	  Building_No,
	  Workcenter,
	  CNC, 
	  Name,
	  Part_No, 
	  Operation_Code,
	  Assembly_No,
	  Description, 
	  STD_Tool_Life
	  from 
	  (
	    select
	    YEAR(tc.Trans_Date) year,
	    STD_WEEK(tc.Trans_Date) week,
		FIRST_DAY_OF_WEEK(tc.Trans_Date) start_week,
	  	LAST_DAY_OF_WEEK(tc.Trans_Date) end_week,
	  	b.Building_Key,
	  	w.Workcenter_Key,
	    tc.CNC_Key,
	    tc.Part_Key,
	    tc.Operation_Key,
	    tc.Assembly_Key,
	    b.Building_No,
	    w.Name Workcenter,
		c.CNC, 
		p.Name,
		CONCAT(CONCAT(p.Part_No," Rev"),p.Revision) Part_No, 
		o.Operation_Code,
		ta.Assembly_No,
		ta.Description, 
		cp.Tool_Life STD_Tool_Life
	    from Tool_Assembly_Change_History tc 
		inner join CNC c 
		on tc.CNC_Key = c.CNC_Key  -- 1 to 1 
		inner join CNC_Workcenter cw 
		on c.CNC_Key = cw.CNC_Key -- 1 to 1
		inner join Workcenter w 
		on cw.Workcenter_Key = w.Workcenter_Key  -- 1 to 1 
		inner join Building b 
		on w.Building_Key = b.Building_Key -- 1 to 1
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
	  group by year,week,start_week,end_week,Building_Key,Workcenter_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key,Building_No,Workcenter,CNC,Name,Part_No,Operation_Code,Assembly_No,Description,STD_Tool_Life

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

	DROP temporary TABLE IF EXISTS Week_Tool_Life;
	create temporary table Week_Tool_Life
	(
		primary_key int,
		Week_Tool_Life int,
		Tool_Change_Count int
	);
	insert into Week_Tool_Life (primary_key,Week_Tool_Life,Tool_Change_Count)
	(
		select
		primary_key,
		round(sum(Actual_Tool_Assembly_Life) / count(*),0) Week_Tool_Life,
		count(*) Tool_Change_Count
		from set2group 
		group by primary_key
	);

	-- select * from Week_Tool_Life;

	DROP temporary TABLE IF EXISTS STD_CPU;
	create temporary table STD_CPU
	(
		primary_key int,
		Price_Per_Tool_Change decimal(12,5),
		Frm_Price_Per_Tool_Change varchar(25),
		STD_CPU varchar(25)
	) ENGINE = MEMORY;

	insert into STD_CPU (primary_key,Price_Per_Tool_Change,Frm_Price_Per_Tool_Change,STD_CPU)
	(
		select 
		pk.primary_key,s.Price_Per_Tool_Change,s.Frm_Price_Per_Tool_Change,s.STD_CPU
		from  
		(
			select 
			-- r.CNC,r.Part_No,r.Operation_Code,r.Assembly_No,r.Description,r.Tool_Life,
			-- r.primary_key,
			CNC_Key,Part_Key,Operation_Key,Assembly_Key,
			sum(Adj_Price_Per_Tool_Change) Price_Per_Tool_Change,
			Format(sum(Adj_Price_Per_Tool_Change),2) Frm_Price_Per_Tool_Change,
			Format(sum(Adj_Price_Per_Tool_Change) / r.Tool_Life,5) STD_CPU
			
			-- select r.*
			from
			(
				SELECT 
				a1.CNC,a1.Part_No,a1.Operation_Code,a1.Assembly_No, a1.Description,a1.Tool_No,
				a1.CNC_Key,a1.Part_Key,a1.Operation_Key,a1.Assembly_Key,
				a1.Tool_Life, -- Tool Life in OTLM.SSB
				a1.QuantityPerCuttingEdge,mQ.MinQuantityPerCuttingEdge,
				mQ.MinQuantityPerCuttingEdge/a1.QuantityPerCuttingEdge Tool_Life_Ratio,
				a1.Price_Per_Tool_Change,
				a1.Price_Per_Tool_Change*(mQ.MinQuantityPerCuttingEdge/a1.QuantityPerCuttingEdge) Adj_Price_Per_Tool_Change
				-- select a1.Tool_Life,a1.Price_Per_Tool_Change*(mQ.MinQuantityPerCuttingEdge/a1.QuantityPerCuttingEdge) Adj_Price_Per_Tool_Change
				from 
				(
				
					select 
					ca.CNC_Part_Operation_Assembly_Key,
					-- c.CNC,p.Part_No,o.Operation_Code,ta.Assembly_No,
					min(tb.QuantityPerCuttingEdge) MinQuantityPerCuttingEdge 
					from CNC_Part_Operation_Assembly ca 
					inner join CNC c 
					on ca.CNC_Key=c.CNC_Key -- 1 to 1
					inner join Part p 
					on ca.Part_Key = p.Part_Key 
					inner join Operation o 
					on ca.Operation_Key = o.Operation_Key 
					inner join Tool_Assembly ta 
					on ca.Assembly_Key=ta.Assembly_Key   -- 1 to 1
					inner join Tool_BOM tb 
					on ca.Assembly_Key = tb.Assembly_Key  -- 1 to many
					inner join Tool t 
					on tb.Tool_Key=t.Tool_Key -- 1 to many
					inner join Tool_Type tt 
					on t.Tool_Type_Key=tt.Tool_Type_Key  -- 1 to 1
					inner join Tool_Group tg 
					on t.Tool_Group_Key=tg.Tool_Group_key  -- 1 to 1
					group by ca.CNC_Part_Operation_Assembly_Key,c.CNC,p.Part_No,o.Operation_Code,ta.Assembly_No
				)mQ
				inner join 
				(
					select 
					-- ta.Description, tt.Tool_Type_Code,tg.Tool_Group_Code,t.Description,tb.Quantity_Required,t.NumberOfCuttingEdges
					ca.CNC_Part_Operation_Assembly_Key,
					ca.CNC_Key,ca.Part_Key,ca.Operation_Key,ca.Assembly_Key,
					c.CNC,p.Part_No,o.Operation_Code,ta.Assembly_No, ta.Description,t.Tool_No,tt.Tool_Type_Code,tg.Tool_Group_Code,ca.Tool_Life,
					tb.Quantity_Required,tb.QuantityPerCuttingEdge,t.NumberOfCuttingEdges,t.Price,
					t.price/t.NumberOfCuttingEdges Price_Per_Cutting_Edge,
					tb.Quantity_Required*(t.price/t.NumberOfCuttingEdges) Price_Per_Tool_Change
					from CNC_Part_Operation_Assembly ca 
					inner join CNC c 
					on ca.CNC_Key=c.CNC_Key -- 1 to 1
					inner join Part p 
					on ca.Part_Key = p.Part_Key 
					inner join Operation o 
					on ca.Operation_Key = o.Operation_Key 
					inner join Tool_Assembly ta 
					on ca.Assembly_Key=ta.Assembly_Key   -- 1 to 1
					inner join Tool_BOM tb 
					on ca.Assembly_Key = tb.Assembly_Key  -- 1 to many
					inner join Tool t 
					on tb.Tool_Key=t.Tool_Key -- 1 to many
					inner join Tool_Type tt 
					on t.Tool_Type_Key=tt.Tool_Type_Key  -- 1 to 1
					inner join Tool_Group tg 
					on t.Tool_Group_Key=tg.Tool_Group_key  -- 1 to 1
				)a1
				on mQ.CNC_Part_Operation_Assembly_Key=a1.CNC_Part_Operation_Assembly_Key
			)r
			group by r.CNC_Key,r.Part_Key,r.Operation_Key,r.Assembly_Key,r.CNC,r.Part_No,r.Operation_Code,r.Assembly_No,r.Description,r.Tool_Life
		)s 
		inner join primary_key pk
		on s.CNC_Key=pk.CNC_Key 
		and s.Part_Key=pk.Part_Key 
		and s.Operation_Key=pk.Operation_Key 
		and s.Assembly_Key=pk.Assembly_Key  -- 1 to many
		
	);

	DROP temporary TABLE IF EXISTS Week_CPU;
	create temporary table Week_CPU
	(
		primary_key int,
		Week_CPU varchar(25)
	) ENGINE = MEMORY;
	insert into Week_CPU (primary_key,Week_CPU)
	(
		select 
		pk.primary_key,
		Format(std.Price_Per_Tool_Change / wtl.Week_Tool_Life,5) Week_CPU
		from STD_CPU std  -- Not based on week, but only CNC_Key,Part_Key,Operation_Key,Assembly_Key
		inner join primary_key pk
		on std.primary_key=pk.primary_key -- 1 to many
		inner join Week_Tool_Life wtl 
		on pk.primary_key=wtl.primary_key  -- 1 to 1
	   -- Primary key is based upon records from Tool_Assembly_Change_History and so is Week_Tool_Life through set2group
	   -- It is a grouping of year_week,CNC_Key,Part_Key,Operation_Key,Assembly_Key records in Tool_Assembly_Change_History
	   -- so ever primary_key record should have an Week_Tool_Life record.
	   -- We could have included this in the STD_CPU query by adding another level and changing it's name to CPU
	 );

	DROP temporary TABLE IF EXISTS results;
	create temporary table results
	(
	  primary_key int,
	  year_week int,
  	  year_week_fmt varchar(10),
  	  start_week varchar(12),
	  end_week varchar(12),
	  Building_Key int,
	  Workcenter_Key int,
	  CNC_Key int,
	  Part_Key int,
	  Operation_Key int,
	  Assembly_Key int,
	  Building_No int,
	  Workcenter varchar (100),  -- Name
	  CNC varchar(10), 
	  Name varchar(100),
	  Part_No varchar(100), 
	  Operation_Code varchar(30),
	  Assembly_No varchar(50),
	  Description varchar(100), 
	  STD_CPU varchar(25),
	  Week_CPU varchar(25),
	  STD_Tool_Life int,
	  Week_Tool_Life int,
	  Tool_Change_Count int
	) ENGINE = MEMORY;
	insert into results (primary_key,year_week,year_week_fmt,start_week,end_week,Building_Key,Workcenter_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key,
	Building_No,Workcenter,CNC,Name,Part_No,Operation_Code,Assembly_No,Description,STD_CPU,Week_CPU,STD_Tool_Life,Week_Tool_Life,Tool_Change_Count)
	(
		select
		pk.primary_key,
		pk.year_week,
		pk.year_week_fmt,
		DATE_FORMAT(start_week,'%m/%d/%Y') start_week,
		DATE_FORMAT(end_week,'%m/%d/%Y') end_week,
		pk.Building_Key,pk.Workcenter_Key,pk.CNC_Key,pk.Part_Key,pk.Operation_Key,pk.Assembly_Key,
		pk.Building_No,
		pk.Workcenter,
		pk.CNC,
		pk.Name,
		pk.Part_No,
		pk.Operation_Code,
		pk.Assembly_No,
		pk.Description,
		std.STD_CPU,
		cpu.Week_CPU,
		pk.STD_Tool_Life,
		wtl.Week_Tool_Life,
		Tool_Change_Count
		from primary_key pk 
		inner join Week_Tool_Life wtl 
		on pk.primary_key=wtl.primary_key  -- 1 to 1
		inner join STD_CPU std 
		on pk.primary_key = std.primary_key  -- many to 1 
		inner join Week_CPU cpu
		on pk.primary_key=cpu.primary_key  -- 1 to 1 
		
	);	
	set @sqlQuery = CONCAT('create table ',tableName,' select * from results order by Building_No,CNC,Part_No,Operation_Code,Assembly_No,year_week');
	PREPARE stmt FROM @sqlQuery;
	execute stmt;
    DEALLOCATE PREPARE stmt;

   	-- SELECT ROW_COUNT(); -- 0
	set pRecordCount = FOUND_ROWS();
	set pReturnValue = 1;
end;



select
c.CNC,ta.Assembly_No,ta.Description,
tc.Actual_Tool_Assembly_Life,
Trans_Date
from Tool_Assembly_Change_History tc 
		inner join CNC c 
		on tc.CNC_Key = c.CNC_Key  -- 1 to 1 
		inner join CNC_Workcenter cw 
		on c.CNC_Key = cw.CNC_Key -- 1 to 1
		inner join Workcenter w 
		on cw.Workcenter_Key = w.Workcenter_Key  -- 1 to 1 
		inner join Building b 
		on w.Building_Key = b.Building_Key -- 1 to 1
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
where tc.CNC_Key = 3 

select *
from Tool_Assembly_Change_History tc 
where tc.CNC_Key = 3