/*
 * MSSQL 
 * 
 * 
 */

-- Drop table

-- drop TABLE Kors.dbo.HourlyOEEValues
CREATE TABLE Kors.dbo.HourlyOEEValues (
	ID int IDENTITY (1,1) NOT NULL,
	Workcenter_Code varchar(50),
	Job_number varchar(20),
	Part_number varchar(60),
	Data_hour INT,
	Hourly_planned_production_count INT,
	Hourly_actual_production_count INT,
	Cumulative_planned_production_count INT,
	Cumulative_actual_production_count INT,
	scrap_count INT,
	Downtime_minutes float,
	Date_time_stamp DATETIME
) 


select 
--top(100)
*
--into hourlyoeevalues0213 
from hourlyoeevalues
select 
top(100) *
--count(*) cnt --14808
from hourlyoeevalues0213


CREATE PROCEDURE InsertHourlyOEEValues
	@Workcenter_Code varchar(50),
	@Job_number varchar(20),
	@Part_number varchar(60),
	@Data_hour INT,
	@Hourly_planned_production_count INT,
	@Hourly_actual_production_count INT,
	@Cumulative_planned_production_count INT,
	@Cumulative_actual_production_count INT,
	@scrap_count INT,
	@Downtime_minutes float,
	@Date_time_stamp DATETIME
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
   
-- Table variable   
DECLARE @MyTableVar table( ID int,
                           Workcenter_Code varchar(50));
   
INSERT INTO Kors.dbo.HourlyOEEValues
(Workcenter_Code, Job_number, Part_number, Data_hour, Hourly_planned_production_count, Hourly_actual_production_count, Cumulative_planned_production_count, Cumulative_actual_production_count, scrap_count, Downtime_minutes, Date_time_stamp)
OUTPUT INSERTED.ID, INSERTED.Workcenter_Code
into @MyTableVar
VALUES(@Workcenter_Code, @Job_number, @Part_number, @Data_hour, @Hourly_planned_production_count, @Hourly_actual_production_count, @Cumulative_planned_production_count, @Cumulative_actual_production_count, @scrap_count, @Downtime_minutes, @Date_time_stamp);
--values (' VSC_5', '1210', '4140', 'Production', 10, 41, 38, 834,582, 0, 0,'2014-07-02 14:29', 0)

--Display the result set of the table variable.
SELECT ID, Workcenter_Code FROM @MyTableVar;
--Display the result set of the table.
--select * from HourlyOEEValues h

END;

CREATE PROCEDURE Sproc200206
	@start_date DATETIME,
	@end_date DATETIME,
	@table_name varchar(12),
	@record_count INT OUTPUT
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;
IF OBJECT_ID(@table_name) IS NOT NULL
	EXEC ('DROP Table ' + @table_name)

/* TESTING ONLY
DECLARE @start_date DATETIME,
	@end_date DATETIME,
	@table_name varchar(12),
	@record_count INT
set @start_date ='2020-02-09T00:00:00';
set @end_date ='2020-02-15T23:59:59';
set @table_name = 'rpt0213test'
*/ -- END TESTING ONLY
	
Declare @start_year char(4)
Declare @start_week int
Declare @end_year char(4)
Declare @end_week int
Declare @start_of_week_for_start_date datetime
Declare @end_of_week_for_end_date datetime

set @start_year = DATEPART(YEAR,@Start_Date)
set @start_week = DATEPART(WEEK,@Start_Date)
set @end_year = DATEPART(YEAR,@End_Date)
set @end_week = DATEPART(WEEK,@End_Date)


set @start_of_week_for_start_date = DATEADD(wk, DATEDIFF(wk, 6, '1/1/' + @start_year) + (@start_week-1), 6)  --start of week
set @end_of_week_for_end_date = DATEADD(wk, DATEDIFF(wk, 5, '1/1/' + @end_year) + (@end_week-1), 5)  --end of week

set @end_of_week_for_end_date = DATEADD(day, 1, @end_of_week_for_end_date);
set @end_of_week_for_end_date = DATEADD(second,-1,@end_of_week_for_end_date);

/* may be necessary if multiple calls are done on the same connection
decdrop table #resultslare @sqlDropPK nvarchar(4000)
declare @PKTable nvarchar(50)
set @PKTable = quotename(@table_name + 'PK')
--select @PKTable
set @sqlDropPK = N'DROP Table ' + @PKTable 
--select @sqlDropPK
IF OBJECT_ID(@PKTable) IS NOT NULL
EXEC sp_executesql @sqlDropPK
*/
--drop table #primary_key
create table #primary_key
(
  primary_key int,
  year_week int,
  start_week datetime,
  end_week datetime,
  part_number varchar(60),
  workcenter_code varchar(50)
)
insert into #primary_key(primary_key,year_week,start_week,end_week,part_number,workcenter_code)
(
  select 
  --top 10
  ROW_NUMBER() OVER (
    ORDER BY year * 100 + week,part_number,workcenter_code
  ) primary_key,
  year * 100 + week year_week,
  DATEADD(wk, DATEDIFF(wk, 6, '1/1/' + CONVERT(varchar, year)) + (week-1), 6) start_week, 
  DATEADD(wk, DATEDIFF(wk, 5, '1/1/' + CONVERT(varchar, year)) + (week-1), 5) end_week, 
  part_number,
  workcenter_code
  from 
  (
    select
    DATEPART(YEAR,date_time_stamp) year,
    DATEPART(WEEK,date_time_stamp) week,
    part_number,
    workcenter_code
    from HourlyOEEValues 
    where date_time_stamp between @start_of_week_for_start_date and @end_of_week_for_end_date
  )s1 
  group by year,week,part_number,workcenter_code
)  

--drop table #set2group
--select count(*) #primary_key from #primary_key  --16
--select top(100) * from #primary_key
--FORMAT ( @d, 'd', 'en-US' ) 
create table #set2group
(
	primary_key int,
	Hourly_planned_production_count int,
	Hourly_actual_production_count int,
	scrap_count int,
	Downtime_minutes float
)


insert into #set2group (primary_key,Hourly_planned_production_count,Hourly_actual_production_count,scrap_count,Downtime_minutes)
(
select
pk.primary_key, 
hv.Hourly_planned_production_count,
hv.Hourly_actual_production_count,
hv.scrap_count,
hv.Downtime_minutes
from #primary_key pk
inner join
(
  select
  DATEPART(YEAR,date_time_stamp) * 100 + DATEPART(WEEK,date_time_stamp) year_week,
    part_number,
    workcenter_code,
	Hourly_planned_production_count,
	Hourly_actual_production_count,
	scrap_count,
	Downtime_minutes
  from HourlyOEEValues 
  where date_time_stamp between @start_of_week_for_start_date and @end_of_week_for_end_date
) hv
on pk.year_week=hv.year_week
and pk.part_number=hv.Part_number 
and pk.workcenter_code=hv.Workcenter_Code 
)
--select top(100) * from #set2group 
--select count(*) #set2group from #set2group  --1404
--drop table #primary_key
--drop table #set2group
--drop table #results
create table #results
(
  primary_key int,
  start_week varchar(12),
  end_week varchar(12),
  part_number varchar(60),
  workcenter_code varchar(50),
  planned_production_count nvarchar(10),
  actual_production_count nvarchar(10),
  actual_vrs_planned_percent varchar(10),
  scrap_count varchar(10),
  scrap_percent varchar(10),
  downtime_minutes varchar(20)
)

insert into #results (primary_key,start_week,end_week,part_number,workcenter_code,planned_production_count,actual_production_count,actual_vrs_planned_percent,scrap_count,scrap_percent,downtime_minutes)
(
		select
		primary_key,
		start_week,
		end_week,
		--FORMAT ( pk.start_week, 'd', 'en-US' ) start_week, 
		--FORMAT ( pk.end_week, 'd', 'en-US' ) end_week, 
		part_number,
		workcenter_code,
		format(planned_production_count, 'N0'),
		format(actual_production_count, 'N0'),
		CONVERT(varchar(10),actual_vrs_planned_percent) + '%' as actual_vrs_planned_percent,  
		format(scrap_count, 'N0'),
		CONVERT(varchar(10),scrap_percent) + '%' as scrap_percent,  
		format(downtime_minutes, 'N0') + ' mins'
		from
		(
			select
			pk.primary_key,
			CONVERT(VARCHAR, start_week ,101) start_week,
			CONVERT(VARCHAR, end_week ,101) end_week,
			--FORMAT ( pk.start_week, 'd', 'en-US' ) start_week, 
			--FORMAT ( pk.end_week, 'd', 'en-US' ) end_week, 
			pk.part_number,
			pk.workcenter_code,
			planned_production_count,
			actual_production_count,
			case
			when planned_production_count = 0 then cast(0.00 as decimal(18,2))
			else cast (actual_production_count*100./planned_production_count as decimal(18,2))
			end actual_vrs_planned_percent, 
			scrap_count,
			case
			when actual_production_count = 0 then cast(0.00 as decimal(18,2))
			else cast (scrap_count*100./actual_production_count as decimal(18,2))
			end scrap_percent, 
			downtime_minutes 
			from
			(
				select
				primary_key,
				sum(Hourly_planned_production_count) planned_production_count,
				sum(Hourly_actual_production_count) actual_production_count,
				sum(scrap_count) scrap_count,
				floor(sum(Downtime_minutes)) Downtime_minutes 
				from #set2group 
				group by primary_key
			) sg
			inner join #primary_key pk
			on sg.primary_key = pk.primary_key
		)s1
)
	--select * from #results 
	--DECLARE @table_name varchar(12),
	--	@record_count INT
	--set @table_name = 'rpt0213test'
	--*/ -- END TESTING ONLY
	--drop table rpt0213test
	declare @sql nvarchar(4000)
	select @sql = N'SELECT * into ' + quotename(@table_name) + N' from #results order by primary_key'
	
	--select @sql = N'SELECT start_week,end_week,part_number,workcenter_code,planned_production_count,actual_production_count,actual_vrs_planned_percent,scrap_count,downtime_minutes into ' + quotename(@table_name) + N' from #results order by primary_key'
	
	EXEC sp_executesql @sql
	    
	SELECT @record_count = @@ROWCOUNT;
--select @record_count
END;

CREATE PROCEDURE Sproc200221
	@start_date DATETIME,
	@end_date DATETIME,
	@table_name varchar(12),
	@record_count INT OUTPUT
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;
IF OBJECT_ID(@table_name) IS NOT NULL
	EXEC ('DROP Table ' + @table_name)

/* TESTING ONLY
DECLARE @start_date DATETIME,
	@end_date DATETIME,
	@table_name varchar(12),
	@record_count INT
set @start_date ='2020-02-09T00:00:00';
set @end_date ='2020-02-15T23:59:59';
--drop table rpt0221test
set @table_name = 'rpt0221test'
*/-- END TESTING ONLY
	
Declare @start_year char(4)
Declare @start_week int
Declare @end_year char(4)
Declare @end_week int
Declare @start_of_week_for_start_date datetime
Declare @end_of_week_for_end_date datetime

set @start_year = DATEPART(YEAR,@Start_Date)
set @start_week = DATEPART(WEEK,@Start_Date)
set @end_year = DATEPART(YEAR,@End_Date)
set @end_week = DATEPART(WEEK,@End_Date)


set @start_of_week_for_start_date = DATEADD(wk, DATEDIFF(wk, 6, '1/1/' + @start_year) + (@start_week-1), 6)  --start of week
set @end_of_week_for_end_date = DATEADD(wk, DATEDIFF(wk, 5, '1/1/' + @end_year) + (@end_week-1), 5)  --end of week

set @end_of_week_for_end_date = DATEADD(day, 1, @end_of_week_for_end_date);
set @end_of_week_for_end_date = DATEADD(second,-1,@end_of_week_for_end_date);

/* may be necessary if multiple calls are done on the same connection
declare @sqlDropPK nvarchar(4000)
declare @PKTable nvarchar(50)
set @PKTable = quotename(@table_name + 'PK')
--select @PKTable
set @sqlDropPK = N'DROP Table ' + @PKTable 
--select @sqlDropPK
IF OBJECT_ID(@PKTable) IS NOT NULL
EXEC sp_executesql @sqlDropPK
*/
--drop table #primary_key
create table #primary_key
(
  primary_key int,
  part_number varchar(60)
)
insert into #primary_key(primary_key,part_number)
(
  select 
  --top 10
  ROW_NUMBER() OVER (
    ORDER BY part_number
  ) primary_key,
  part_number
  from 
  (
    select
    part_number
    from HourlyOEEValues 
    where date_time_stamp between @start_of_week_for_start_date and @end_of_week_for_end_date
  )s1 
  group by part_number
)  

--drop table #primary_key
--select count(*) #primary_key from #primary_key  --16
--select top(100) * from #primary_key
--FORMAT ( @d, 'd', 'en-US' ) 
create table #set2group
(
	primary_key int,
	Hourly_planned_production_count int,
	Hourly_actual_production_count int,
	scrap_count int,
	Downtime_minutes float
)

insert into #set2group (primary_key,Hourly_planned_production_count,Hourly_actual_production_count,scrap_count,Downtime_minutes)
(
select
pk.primary_key, 
hv.Hourly_planned_production_count,
hv.Hourly_actual_production_count,
hv.scrap_count,
hv.Downtime_minutes
from #primary_key pk
inner join
(
  select
    part_number,
    workcenter_code,
	Hourly_planned_production_count,
	Hourly_actual_production_count,
	scrap_count,
	Downtime_minutes
  from HourlyOEEValues 
  where date_time_stamp between @start_of_week_for_start_date and @end_of_week_for_end_date
) hv
on pk.part_number=hv.Part_number 
)
--select top(100) * from #set2group 
--select count(*) #set2group from #set2group  --1404
--drop table #primary_key
--drop table #set2group
--drop table #results
create table #results
(
  primary_key int,
  part_number varchar(60),
  actual_vrs_planned_percent decimal(18,2),
  scrap_count int,
  scrap_percent int,
  downtime_minutes int
)



insert into #results (primary_key,part_number,actual_vrs_planned_percent,scrap_count,scrap_percent,downtime_minutes)
(
select
pk.primary_key,
pk.part_number,
case
when planned_production_count = 0 then cast(0.00 as decimal(18,2))
else cast (actual_production_count*100./planned_production_count as decimal(18,2))
end actual_vrs_planned_percent, 
scrap_count,
case
when actual_production_count = 0 then cast(0.00 as decimal(18,2))
else cast (scrap_count*100./actual_production_count as decimal(18,2))
end scrap_percent, 
downtime_minutes 
from
(
select
primary_key,
sum(Hourly_planned_production_count) planned_production_count,
sum(Hourly_actual_production_count) actual_production_count,
sum(scrap_count) scrap_count,
floor(sum(Downtime_minutes)) Downtime_minutes 
from #set2group 
group by primary_key
) sg
inner join #primary_key pk
on sg.primary_key = pk.primary_key
)
--select * from #results 
--DECLARE @table_name varchar(12),
--	@record_count INT
--set @table_name = 'rpt0213test'
--*/ -- END TESTING ONLY
--drop table rpt0213test
declare @sql nvarchar(4000)
select @sql = N'SELECT * into ' + quotename(@table_name) + N' from #results order by primary_key'

--select @sql = N'SELECT start_week,end_week,part_number,workcenter_code,planned_production_count,actual_production_count,actual_vrs_planned_percent,scrap_count,downtime_minutes into ' + quotename(@table_name) + N' from #results order by primary_key'

EXEC sp_executesql @sql
    
SELECT @record_count = @@ROWCOUNT;
--select @record_count
END;



