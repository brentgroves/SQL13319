-- NOT STARTED
(T1=3" FACE MILL)
(T21=2" FACE MILL)
(T22=M6 TAP DRILL-P558)
(T23=M6 TAP-P558)
(T72=15.1MM DRILL & CHAMFER)
(BEGIN T33=COMBO ROUGH BORE-P558)
(T33=CCMT 432MT TT7015 INSERT)
(T34=CCMT 32.52 -M3 TK1501 INSERT)
(END T33=COMBO ROUGH BORE-P558)
(T30=FINISH CENTER BORES-P558)
(T4=16.95MM DRILL)
(T15=1.937 ROUGH DRILL)
(T7=DATUM J ROUGH BORE & BACK FACE)
(BEGIN T6=DATUM L ROUGH BORE & C'BORE)
(T6= SHLT110408N-PH1 IN2005 INSERT)
(T66= SHLT140516N-FS IN1030 INSERT)
(END T6=DATUM L ROUGH BORE & C'BORE)
(T9=FINISH L BORE)
(T8=FINISH J BORE)
(T12=TAPER DREAMER)
(T13=PLUNGE BACK SIDE HOLES)
(T14=CHAMFER BACK SIDE OF HOLES)

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


inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 

select * from Tool_Var_Map tvm 
order by tvm.Assembly_Key 



(T1=3 FACE MILL)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 1
order by Start_Time 
-- NO TOOL CHANGE
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 1

-- select * from Assembly_Machining_History amh2 where Start_Time < '2020-11-18 11:00:00' and Tool_Key = 1
-- delete from Assembly_Machining_History amh2 where Start_Time < '2020-11-18 11:00:00' and Tool_Key = 1
(T21=2" FACE MILL)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 21
order by Start_Time 
-- NO TOOL CHANGES
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 21 
-- delete from Part_v_Tool_Life

(T22=M6 TAP DRILL-P558)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 22
order by Start_Time 
-- NO TOOL CHANGE YET
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 22 

(T23=M6 TAP-P558)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 23
order by Start_Time 
-- NO TOOL CHANGE YET
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 23 

(T72=15.1MM DRILL & CHAMFER)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 72
order by Start_Time 
-- NO TOOL CHANGE YET
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 72 

(BEGIN T33=COMBO ROUGH BORE-P558)
(T33=CCMT 432MT TT7015 INSERT)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 33
order by Start_Time 
2020-11-18 03:12:05 / 128
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 33 
2020-11-18 03:12:05 / 128  / PASSED

(T34=CCMT 32.52 -M3 TK1501 INSERT)
(END T33=COMBO ROUGH BORE-P558)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 34
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 34

(T30=FINISH CENTER BORES-P558)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 30
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 30

(T4=16.95MM DRILL)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 4
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 4
(T15=1.937 ROUGH DRILL)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 15
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 15
(T7=DATUM J ROUGH BORE & BACK FACE)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 7
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 7

(BEGIN T6=DATUM L ROUGH BORE & CBORE)
(T6= SHLT110408N-PH1 IN2005 INSERT)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 6
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 6
(T66= SHLT140516N-FS IN1030 INSERT)
(END T6=DATUM L ROUGH BORE & C'BORE)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 66
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 66

(T9=FINISH L BORE)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 9
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 9
(T8=FINISH J BORE)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 8
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 8

(T12=TAPER DREAMER)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 12
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 12

(T13=PLUNGE BACK SIDE HOLES)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 13
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 13

(T14=CHAMFER BACK SIDE OF HOLES)
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 14
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 14


