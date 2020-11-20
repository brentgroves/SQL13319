
select count(*) from Assembly_Machining_History  -- 1398
 SELECT * FROM Assembly_Machining_History amh;
-- CREATE TABLE Assembly_Machining_History_11_16  SELECT * FROM Assembly_Machining_History amh;  -- 1263

/*
 * Last update values
 */
select 
-- amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,
amh.Assembly_Key,amh.Tool_Key,
pta.Assembly_No,amh.Current_Value,amh.Running_Total, pta.Description,
pt.Tool_No,tt.Tool_Type_Code,pt.Description, 
pl.Standard_Tool_Life,
pl.Standard_Tool_Life - amh.Current_Value PartsToToolChange
-- select count(*)
from Assembly_Machining_History amh 
inner join 
(
	select amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key,max(amh.Start_Time) Last_Start_Time 
	-- select count(*)
	from Assembly_Machining_History amh 
	group by amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key  -- 16
)lst -- last assembly time recorded
on amh.Plexus_Customer_No = lst.Plexus_Customer_No
and amh.Workcenter_Key = lst.Workcenter_Key 
and amh.CNC_Key = lst.CNC_Key 
and amh.Part_Key = lst.Part_Key
and amh.Part_Operation_Key = lst.Part_Operation_Key
and amh.Assembly_Key = lst.Assembly_Key 
and amh.Tool_Key = lst.Tool_Key  
and amh.Start_Time = lst.Last_Start_Time -- 1 to 1  -- 16
inner join Part_v_Part_Operation po 
on amh.Plexus_Customer_No = po.Plexus_Customer_No 
and amh.Part_Operation_Key = po.Part_Operation_Key -- 1 to 1
inner join Part_v_Tool_Op_Part_Life pl 
on amh.Plexus_Customer_No = pl.PCN 
and amh.Part_Key = pl.Part_Key 
and po.Operation_Key = pl.Operation_Key 
and amh.Assembly_Key = pl.Assembly_Key 
and amh.Tool_Key = pl.Tool_Key -- 1 to 1  -- 16
inner join Part_v_Tool_Assembly pta 
on amh.Plexus_Customer_No = pta.Plexus_Customer_No 
and amh.Assembly_Key = pta.Assembly_Key
inner join Part_v_Tool pt
on amh.Plexus_Customer_No = pt.Plexus_Customer_No 
and amh.Tool_Key = pt.Tool_Key
inner join Part_v_Tool_Type tt 
on pt.Tool_Type_Key = tt.Tool_Type_Key -- 1 to 1
order by pl.Standard_Tool_Life - amh.Current_Value


/*
 * PartsToToolChange is < 0
 */
-- How many Tool changes
select amh.Assembly_Key,amh.Tool_Key,amh.Two_Count,pta.Assembly_No,pta.Description,pt.Tool_No,pt.Description 
from 
(
	SELECT Plexus_Customer_No, Assembly_Key, Tool_Key, count(*) Two_Count 
	FROM Assembly_Machining_History amh 
	group by Plexus_Customer_No,Assembly_Key, Tool_Key, Current_Value 
	having Current_Value = 2
)amh 
inner join Part_v_Tool_Assembly pta 
on amh.Plexus_Customer_No = pta.Plexus_Customer_No 
and amh.Assembly_Key = pta.Assembly_Key
inner join Part_v_Tool pt
on amh.Plexus_Customer_No = pt.Plexus_Customer_No 
and amh.Tool_Key = pt.Tool_Key
where amh.Two_Count > 1

-- 
-- All Upcoming Tool Changes
select 
-- amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,
amh.Assembly_Key,amh.Tool_Key,
pta.Assembly_No,pta.Description,
pt.Tool_No,tt.Tool_Type_Code,pt.Description, 
pl.Standard_Tool_Life,amh.Current_Value,
pl.Standard_Tool_Life - amh.Current_Value PartsToToolChange
-- select count(*)
from Assembly_Machining_History amh 
inner join 
(
	select amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key,max(amh.Start_Time) Last_Start_Time 
	-- select count(*)
	from Assembly_Machining_History amh 
	group by amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key  -- 16
)lst -- last assembly time recorded
on amh.Plexus_Customer_No = lst.Plexus_Customer_No
and amh.Workcenter_Key = lst.Workcenter_Key 
and amh.CNC_Key = lst.CNC_Key 
and amh.Part_Key = lst.Part_Key
and amh.Part_Operation_Key = lst.Part_Operation_Key
and amh.Assembly_Key = lst.Assembly_Key 
and amh.Tool_Key = lst.Tool_Key  
and amh.Start_Time = lst.Last_Start_Time -- 1 to 1  -- 16
inner join Part_v_Part_Operation po 
on amh.Plexus_Customer_No = po.Plexus_Customer_No 
and amh.Part_Operation_Key = po.Part_Operation_Key -- 1 to 1
inner join Part_v_Tool_Op_Part_Life pl 
on amh.Plexus_Customer_No = pl.PCN 
and amh.Part_Key = pl.Part_Key 
and po.Operation_Key = pl.Operation_Key 
and amh.Assembly_Key = pl.Assembly_Key 
and amh.Tool_Key = pl.Tool_Key -- 1 to 1  -- 16
inner join Part_v_Tool_Assembly pta 
on amh.Plexus_Customer_No = pta.Plexus_Customer_No 
and amh.Assembly_Key = pta.Assembly_Key
inner join Part_v_Tool pt
on amh.Plexus_Customer_No = pt.Plexus_Customer_No 
and amh.Tool_Key = pt.Tool_Key
inner join Part_v_Tool_Type tt 
on pt.Tool_Type_Key = tt.Tool_Type_Key -- 1 to 1
order by pl.Standard_Tool_Life - amh.Current_Value

-- Upcoming Tool Changes that have been running the entire time
select 
-- amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,
amh.Assembly_Key,amh.Tool_Key,
pta.Assembly_No,pta.Description,
pt.Tool_No,tt.Tool_Type_Code,pt.Description, 
pl.Standard_Tool_Life,amh.Current_Value,
pl.Standard_Tool_Life - amh.Current_Value PartsToToolChange
-- select count(*)
from Assembly_Machining_History amh 
inner join 
(
	select DISTINCT amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key
	from Assembly_Machining_History amh
	where Current_Value = 2
)et 
on amh.Plexus_Customer_No = et.Plexus_Customer_No
and amh.Workcenter_Key = et.Workcenter_Key 
and amh.CNC_Key = et.CNC_Key 
and amh.Part_Key = et.Part_Key
and amh.Part_Operation_Key = et.Part_Operation_Key
and amh.Assembly_Key = et.Assembly_Key 
and amh.Tool_Key = et.Tool_Key  -- 379
inner join 
(
	select amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key,max(amh.Start_Time) Last_Start_Time 
	-- select count(*)
	from Assembly_Machining_History amh 
	group by amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key  -- 16
)lst -- last assembly time recorded
on amh.Plexus_Customer_No = lst.Plexus_Customer_No
and amh.Workcenter_Key = lst.Workcenter_Key 
and amh.CNC_Key = lst.CNC_Key 
and amh.Part_Key = lst.Part_Key
and amh.Part_Operation_Key = lst.Part_Operation_Key
and amh.Assembly_Key = lst.Assembly_Key 
and amh.Tool_Key = lst.Tool_Key  
and amh.Start_Time = lst.Last_Start_Time -- 1 to 1  -- 16
inner join Part_v_Part_Operation po 
on amh.Plexus_Customer_No = po.Plexus_Customer_No 
and amh.Part_Operation_Key = po.Part_Operation_Key -- 1 to 1
inner join Part_v_Tool_Op_Part_Life pl 
on amh.Plexus_Customer_No = pl.PCN 
and amh.Part_Key = pl.Part_Key 
and po.Operation_Key = pl.Operation_Key 
and amh.Assembly_Key = pl.Assembly_Key 
and amh.Tool_Key = pl.Tool_Key -- 1 to 1  -- 16
inner join Part_v_Tool_Assembly pta 
on amh.Plexus_Customer_No = pta.Plexus_Customer_No 
and amh.Assembly_Key = pta.Assembly_Key
inner join Part_v_Tool pt
on amh.Plexus_Customer_No = pt.Plexus_Customer_No 
and amh.Tool_Key = pt.Tool_Key
inner join Part_v_Tool_Type tt 
on pt.Tool_Type_Key = tt.Tool_Type_Key -- 1 to 1
order by pl.Standard_Tool_Life - amh.Current_Value


/*
 * All history records of most current runs of assemblies that have been running the entire time
 */
select ta.Assembly_Key AKey,pt.Tool_Key TKey, 
ta.Assembly_No TN,ta.Description,pt.Tool_No,
ptc.PartsToToolChange ToGo,amh.Current_Value,amh.Running_Total, 
amh.Start_Time,amh.End_Time,amh.Run_Time 
-- select count(*)
from Assembly_Machining_History amh
inner join 
(
	-- Find start of most recent run of assemblies that ran the entire time
	select amh.*,st.Start_Time Last_Run_Start_Time
	FROM Assembly_Machining_History amh 
	inner join
	 (
		 SELECT Plexus_Customer_No,Workcenter_Key,CNC_Key,Part_Key, Part_Operation_Key, Assembly_Key,Tool_Key, max(Start_Time) Start_Time 
		 FROM Assembly_Machining_History amh 
		 group by Plexus_Customer_No,Workcenter_Key,CNC_Key,Part_Key, Part_Operation_Key, Assembly_Key,Tool_Key,Current_Value 
		 having Current_Value = 2
	 )st 
	on amh.Plexus_Customer_No = st.Plexus_Customer_No
	and amh.Workcenter_Key = st.Workcenter_Key 
	and amh.CNC_Key = st.CNC_Key
	and amh.Part_Key = st.Part_Key 
	and amh.Part_Operation_Key = st.Part_Operation_Key
	and amh.Assembly_Key = st.Assembly_Key
	and amh.Tool_Key = st.Tool_Key
	and amh.Start_Time = st.Start_Time  -- 1 to 1
)lr  -- Calculate Start_Time of last run
on amh.Plexus_Customer_No = lr.Plexus_Customer_No
and amh.Workcenter_Key = lr.Workcenter_Key 
and amh.CNC_Key = lr.CNC_Key
and amh.Part_Key = lr.Part_Key 
and amh.Part_Operation_Key = lr.Part_Operation_Key
and amh.Assembly_Key = lr.Assembly_Key
and amh.Tool_Key = lr.Tool_Key  -- 1 to 1  -- 373 
inner join 
(  -- Parts to Tool Change
	select amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key,pl.Standard_Tool_Life,amh.Current_Value,
	pl.Standard_Tool_Life - amh.Current_Value PartsToToolChange
	-- select count(*)
	from Assembly_Machining_History amh 
	inner join 
	(
		select amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key,max(amh.Start_Time) Last_Start_Time 
		-- select count(*)
		from Assembly_Machining_History amh 
		group by amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key  -- 16
	)lst -- last assembly time recorded
	on amh.Plexus_Customer_No = lst.Plexus_Customer_No
	and amh.Workcenter_Key = lst.Workcenter_Key 
	and amh.CNC_Key = lst.CNC_Key 
	and amh.Part_Key = lst.Part_Key
	and amh.Part_Operation_Key = lst.Part_Operation_Key
	and amh.Assembly_Key = lst.Assembly_Key 
	and amh.Tool_Key = lst.Tool_Key  
	and amh.Start_Time = lst.Last_Start_Time -- 1 to 1  -- 16
	inner join Part_v_Part_Operation po 
	on amh.Plexus_Customer_No = po.Plexus_Customer_No 
	and amh.Part_Operation_Key = po.Part_Operation_Key -- 1 to 1
	inner join Part_v_Tool_Op_Part_Life pl 
	on amh.Plexus_Customer_No = pl.PCN 
	and amh.Part_Key = pl.Part_Key 
	and po.Operation_Key = pl.Operation_Key 
	and amh.Assembly_Key = pl.Assembly_Key 
	and amh.Tool_Key = pl.Tool_Key -- 1 to 1  -- 16
) ptc
on amh.Plexus_Customer_No = ptc.Plexus_Customer_No
and amh.Workcenter_Key = ptc.Workcenter_Key 
and amh.CNC_Key = ptc.CNC_Key
and amh.Part_Key = ptc.Part_Key 
and amh.Part_Operation_Key = ptc.Part_Operation_Key
and amh.Assembly_Key = ptc.Assembly_Key
and amh.Tool_Key = ptc.Tool_Key  -- 1 to 1  -- 871
inner join Part_v_Tool_Assembly ta 
on amh.Plexus_Customer_No = ta.Plexus_Customer_No 
and amh.Assembly_Key = ta.Assembly_Key -- 1 to 1
inner join Part_v_Tool pt 
on amh.Plexus_Customer_No = pt.Plexus_Customer_No 
and amh.Tool_Key = pt.Tool_Key -- 374
-- where amh.Assembly_Key = 23
-- where amh.Assembly_Key = 23

-- where amh.Start_Time >= lr.Start_Time  -- 380
order by ptc.PartsToToolChange,amh.Plexus_Customer_No, amh.Workcenter_Key, amh.CNC_Key,amh.Part_Key, amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key,amh.Start_Time 


/*
 * Parts to tool change is < 0
 */
select 
-- amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,
amh.Assembly_Key,amh.Tool_Key,ta.Description, ta.Assembly_No,pt.Tool_No,tvm.Tool_Var,pl.Standard_Tool_Life,amh.Current_Value,
pl.Standard_Tool_Life - amh.Current_Value PartsToToolChange
-- select count(*)
from Assembly_Machining_History amh 
inner join 
(
	select amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key,max(amh.Start_Time) Last_Start_Time 
	-- select count(*)
	from Assembly_Machining_History amh 
	group by amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,amh.Assembly_Key,amh.Tool_Key  -- 16
)lst -- last assembly time recorded
on amh.Plexus_Customer_No = lst.Plexus_Customer_No
and amh.Workcenter_Key = lst.Workcenter_Key 
and amh.CNC_Key = lst.CNC_Key 
and amh.Part_Key = lst.Part_Key
and amh.Part_Operation_Key = lst.Part_Operation_Key
and amh.Assembly_Key = lst.Assembly_Key 
and amh.Tool_Key = lst.Tool_Key  
and amh.Start_Time = lst.Last_Start_Time -- 1 to 1  -- 16
inner join Part_v_Part_Operation po 
on amh.Plexus_Customer_No = po.Plexus_Customer_No 
and amh.Part_Operation_Key = po.Part_Operation_Key -- 1 to 1
inner join Part_v_Tool_Op_Part_Life pl 
on amh.Plexus_Customer_No = pl.PCN 
and amh.Part_Key = pl.Part_Key 
and po.Operation_Key = pl.Operation_Key 
and amh.Assembly_Key = pl.Assembly_Key 
and amh.Tool_Key = pl.Tool_Key -- 1 to 1  -- 16
inner join Part_v_Tool_Assembly ta 
on amh.Plexus_Customer_No = ta.Plexus_Customer_No 
and amh.Assembly_Key = ta.Assembly_Key -- 1 to 1
inner join Part_v_Tool pt 
on amh.Plexus_Customer_No = pt.Plexus_Customer_No 
and amh.Tool_Key = pt.Tool_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where amh.Assembly_Key in (23,18)
-- where (pl.Standard_Tool_Life - amh.Current_Value) < 0


 /*
Assembly_Key|
------------|
          23|YES
          19|
          14|
          18|
          13|
          21|
          15|
          
Assembly_Key|Start_Time         
------------|-------------------
          14|2020-11-16 20:56:47
          18|2020-11-17 09:51:03
          20|2020-11-16 21:52:34
          13|2020-11-17 04:54:13          
*/

select 
amh.Assembly_Key,amh.Tool_Key,pta.Assembly_No, pt.Tool_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Part_v_Tool pt
on amh.Tool_Key = pt.Tool_Key 
order by End_Time desc i

select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
where amh.Assembly_Key = 14
-- where Assembly_Key = 18 -- tool_life yes
order by Current_Value 

/* Test MachingHistory */
(300758,1,1,13,9,0),
(300758,2,14,14,6,0),  -- T21
Started 2020-11-16 15:25:36 at 158
End at 2020-11-16 20:39:25 with 200
Start: 2020-11-16 20:56:47 with 2
Continue: 2020-11-17 14:47:28 with 132
select pl.Assembly_Key,pl.Tool_Key, cpl.Current_Value,cpl.Running_Total,cpl.Last_Update from  Part_v_Tool_Op_Part_Life pl
inner join CNC_Tool_Op_Part_Life cpl 
on pl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key -- 1 to many 
where pl.Tool_Key = 14

(300758,3,15,15,1,0),
(300758,4,16,16,1,0),
(300758,5,20,17,1,0),
(300758,6,18,18,1,0), -- VC34
(300758,7,19,18,9,0), -- VC33,CCMT 432MT TT7015 INSERT,INBOARD
select 
amh.Assembly_Key,amh.Tool_Key,pta.Assembly_No, pt.Tool_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Part_v_Tool pt
on amh.Tool_Key = pt.Tool_Key 
where amh.Tool_Key = 19  -- VC33
order by Start_Time 
start: 2020-11-16 15:30:39, CV=118
end: 2020-11-16 21:16:51, CV=164
start: 2020-11-16 21:31:07, CV=2
end:  2020-11-17 09:33:58, cv=86
start: 2020-11-17 09:51:03, cv=2
continue: 2020-11-17 14:50:25, cv= 42
select * from Part_v_Tool_Life pvtl 
-- delete from Part_v_Tool_Life
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
where amh.Assembly_Key = 18
and Tool_Key = 18  -- VC34
order by Start_Time -- changed code top to OTLMB; WAS USING OLD OTLM.SSB FILE THAT DID NOT HAVE T66 OR T34
start: 2020-11-16 15:30:39 cv= 14
continue: 2020-11-17 15:35:03, cv= 192

(300758,8,17,19,2,0),
(300758,9,2,20,1,0),
(300758,10,12,21,2,1), -- Alternate Tool for T15;
(300758,11,13,21,2,0),
select 
Assembly_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
where Assembly_Key = 21 -- 
order by Start_Time 
start_time: 11/13 10:13 Current_Value = 236 
End_Time: 11/13 20:18 Running_Total = 300 
Start_Time: 11/13 20:40 Current_Value = 2

select * from Part_v_Tool_Life pvtl where Tool_Key = 19

(300758,12,6,22,7,0),


(300758,13,3,23,2,0), -- VC6,009240,SHLT110408N-PH1 IN2005,DATUM L ROUGH BORE & C'BORE
(300758,14,4,23,2,1), -- Alternate Tool for,008318, one of the T6 inserts.  
(300758,15,5,23,2,0), -- VC66,008318,SHLT140516N-FS IN1030 INSERT,DATUM L ROUGH BORE & C'BORE
-- delete from Assembly_Machining_History amh
select 
Assembly_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
where Assembly_Key = 23 -- 
and Tool_Key = 3  -- VC6
order by Start_Time 

select pl.Assembly_Key,pl.Tool_Key, cpl.Current_Value,cpl.Running_Total,cpl.Last_Update from  Part_v_Tool_Op_Part_Life pl
inner join CNC_Tool_Op_Part_Life cpl 
on pl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key -- 1 to many 
where pl.Tool_Key = 3

select 
Assembly_Key,Tool_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
-- where Tool_Key = 5
where Assembly_Key = 23 -- 
and Tool_Key = 5  -- VC66 -- changed code top to OTLMB; WAS USING OLD OTLM.SSB FILE THAT DID NOT HAVE T66 OR T34
-- THE 1ST TOOL LIFE WILL BE WRONG BECAUSE THIS TOOL WAS NOT CHANGED AND THE RUNNING TOTAL IS NOT CORRECT.
order by Start_Time 

select pl.Assembly_Key,pl.Tool_Key, cpl.Current_Value,cpl.Running_Total,cpl.Last_Update from  Part_v_Tool_Op_Part_Life pl
inner join CNC_Tool_Op_Part_Life cpl 
on pl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key -- 1 to many 
where pl.Tool_Key = 5

select * from Part_v_Tool_Life pvtl 
-- truncate table Part_v_Tool_Life  
-- truncate table Assembly_Machining_History
Start_Time: 11/14 13:38 Current_Value = 140 
End_Time: 11/15 05:16 Running_Total = 200 
Start_Time: 11/15 05:37 Current_Value = 2
End_Time: 11/16 12:46 Running_Total = 200


(300758,16,7,24,1,0),
(300758,17,7,25,1,0),
(300758,18,8,26,1,0),
(300758,19,9,26,1,1),  -- Alternate Tool for T12; 
(300758,20,10,27,2,0),
select 
Assembly_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
where Assembly_Key = 27 -- 
order by Start_Time 
Start_Time: 11/13 10:17 Current_Value = 726
End_Time 11:13 21:44 Running_Total = 800


(300758,21,11,28,2,0)
