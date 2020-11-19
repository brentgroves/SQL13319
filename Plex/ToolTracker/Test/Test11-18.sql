DONE: 11/18 16:20
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


(T1=3" FACE MILL)
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
2020-11-18 09:04:34|2020-11-18 09:05:51  -- end time when counter is 2
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 1

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
2020-11-18 00:39:52  -- end time when counter is 2
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 21 
-- FAILED TO INSERT TOOL LIFE

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


