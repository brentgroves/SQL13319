Declare @Start_Date datetime 
Declare @End_Date datetime

-- 5932
-- set @Start_Date = '20190401'
-- set @End_Date = '20190430'

-- 5129
-- set @Start_Date = '20190501'
-- set @End_Date = '20190530'

-- 64
-- set @Start_Date = '20190601'
-- set @End_Date = '20190630'

-- 48
-- set @Start_Date = '20200101'
-- set @End_Date = '20200130'

-- 56 
-- set @Start_Date = '20200201'
-- set @End_Date = '20200228'

--42
-- set @Start_Date = '20200301'
-- set @End_Date = '20200330'

--4
-- set @Start_Date = '20200401'
-- set @End_Date = '20200430'

--7
-- set @Start_Date = '20200501'
-- set @End_Date = '20200530'

-- 25
-- set @Start_Date = '20200601'
-- set @End_Date = '20200630'

-- 17 
-- set @Start_Date = '20200701'
-- set @End_Date = '20200730'

-- 76786
-- set @Start_Date = '20190401'
-- set @End_Date = '20200730'

/*
primary_key: Determine primary key of result set.
production rates based on 480 production hour periods which start on 04/01/2019
and end on the last day of the month that is 2 months previous to todays date. These periods are unique 
for every part.
*/


set @Start_Date = '2019-04-01 00:00:00' -- '20190401'
set @End_Date = '2020-05-31 23:00:00' --'20200531'


create table #pre_primary_key
(
  primary_key int,
  part_key int,
  part_no varchar (113),   
  period int,
  periodHours int,
  maxPeriodCompleted int,
  start_date datetime,
  end_date datetime
)

insert into #pre_primary_key(primary_key,part_key,part_no,period,periodHours,maxPeriodCompleted,start_date,end_date)
(
      select
      ROW_NUMBER() OVER (
        ORDER BY part_no,period
      ) primary_key,
      part_key,
      part_no,
      period,
      max(runningTotal) periodHours,
      cast((floor(max(runningTotal) / 480)-1) as int) as maxPeriodCompleted,
      --cast(((max(runningTotal) / 480)-1) as int) as maxPeriodCompleted,
      min(cost_date) start_date,
      max(cost_date) end_date
      from
      (
        select
        s1.part_key,
        s1.part_no,
        s1.hours,
        s1.cost_date,
        cast((s1.runningTotal / 480) as int) as period,
        s1.runningTotal
        from
        (
          select
          p.part_key,
          p.part_no,
          cc.quantity hours,
          cc.cost_date cost_date,
          sum(cc.quantity) over (partition by p.part_key order by cc.cost_date) as runningTotal
          from part_v_part p
          inner join common_v_cost cc
          on p.part_key=cc.part_key
          inner join common_v_cost_sub_type cst
          on cc.cost_sub_type_key = cst.cost_sub_type_key
        --  where p.part_no = '18190-RNO-A012-S10'
      --    and cc.cost_date between @start_of_week_for_start_date and @end_of_week_for_end_date
          where cc.cost_date between @Start_Date and @End_Date
          and cst.cost_sub_type = 'Production'
        )s1
      )s2
      group by s2.part_key,s2.part_no,s2.period

    --where s3.period <= s3.maxPeriodCompleted
)

create table #primary_key
(
  primary_key int,
  part_key int,
  part_no varchar (113),   
  period int,
  periodHours int,
  maxPeriodCompleted int,
  start_date datetime,
  end_date datetime
)

insert into #primary_key(primary_key,part_key,part_no,period,periodHours,maxPeriodCompleted,start_date,end_date)
(
select 
pk.primary_key,
pk.part_key,
pk.part_no,
pk.period,
pk.periodHours,
--pk.maxPeriodCompleted,
s1.maxPeriodCompleted,
pk.start_date,
pk.end_date
from #pre_primary_key pk
inner join
(
    select
    part_key,
    max(maxPeriodCompleted)  as maxPeriodCompleted
    from #pre_primary_key
    group by part_key
)s1
on pk.part_key=s1.part_key
where pk.period <= s1.maxPeriodCompleted
)

-- select * from #primary_key order by part_key,period
-- select count(*) from #primary_key

create table #set2group
(
  part_key int,
  part_no varchar (113),   
  first_moved datetime,
  serial_no varchar(25),
  -- quantity decimal (19,5)	
  quantity int
)

insert into #set2group(part_key,part_no,first_moved,serial_no,quantity)
(
  select
  s1.part_key,
  s1.part_no,
  min(s1.change_date) first_moved,
  s1.serial_no,
  s1.quantity
  -- sum(s1.quantity) over (partition by s1.part_key order by min(s1.change_date)) RunningTotalQuantity,
  --count(*) cnt
  from
  (
    select
    --count(*)
    p.part_key,
    p.part_no,
    c.serial_no,
    c.quantity,
    cc.change_date
    from sales_v_shipper_container sc --85808
    inner join part_v_container c
    on sc.serial_no=c.serial_no  -- 1 to 1 ; There can be more than one shipper_container with the same serial_no but not more than 1 part_v_container.
    inner join part_v_part p
    on c.part_key=p.part_key -- 1 to 1
    inner join part_v_container_change2 cc
    on c.serial_no=cc.serial_no  --1 to many, 1,627,750
    inner join sales_v_shipper_line sl
    on sc.shipper_line_key=sl.shipper_line_key  -- 1 to 1 
    inner join sales_v_shipper sh
    on sl.shipper_key=sh.shipper_key  -- 1 to 1 
    inner join sales_v_shipper_status ss
    on sh.shipper_status_key=ss.shipper_status_key  -- 1 to 1, 1,627,750 
    where 
    ss.shipper_status = 'Shipped'  -- 1,626,271
    and c.container_status = 'Shipped'  -- 1,626,271
    and cc.location like 'Finished%'
    and cc.last_action = 'Container Move'  -- moved to Finished, 	81,400
    and cc.change_date between @Start_Date and @End_Date
  ) s1
  group by s1.part_key,s1.part_no,s1.serial_no,s1.quantity
);

-- select count(*) #set2Group from #set2Group

create table #result
(
  part_key int,
  part_no varchar (113),   
  period int,
  start_date varchar(25),
  end_date varchar(25),
  quantity int,
  rate decimal (19,5)
)

insert into #result(part_key,part_no,period,start_date,end_date,quantity,rate)
(
select
s1.part_key,
s1.part_no,
s1.period,
CONVERT(VARCHAR, s1.start_date, 121) start_date,
CONVERT(VARCHAR, s1.end_date, 121) end_date,
sum(s1.quantity) quantity,
-- NOT CORRECT BECAUSE A PERIOD WILL ALWAYS BE >= 480 HOURS
sum(s1.quantity)/CAST(480 AS DECIMAL) rate
from
(
  select 
  pk.part_key,
  pk.part_no,
  pk.period,
  pk.start_date,
  pk.end_date,
  gr.quantity
  from #primary_key pk 
  inner join #set2group gr 
  on pk.part_key=gr.part_key
  and gr.first_moved between pk.start_date and pk.end_date
) s1
group by s1.part_key,s1.part_no,s1.period,s1.start_date,s1.end_date
)

-- select count(*) #result from #result  --1125

select
--top 100
*
from #result
order by part_no,period