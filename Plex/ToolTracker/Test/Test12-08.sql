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
select * from Assembly_Machining_History amh order by Start_Time desc limit 10
/*
 * T04,T08,and T30 all had the same issue of not recieving the counter
 * until it was 4 after a tool change. The patch was applied for
 * this at 11/23 13:56
 */
-- Counter Check
select 
-- amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,
amh.Assembly_Key,amh.Start_Time, amh.Tool_Key,
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
order by amh.Assembly_Key
-- order by pl.Standard_Tool_Life - amh.Current_Value
-- order by pl.Standard_Tool_Life - amh.Current_Value


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
and Start_Time > '2020-12-01'
order by Start_Time 
-- run started at 2 on 2020-12-05 19:08:42
-- and ended on 2020-12-07 20:59:42
-- T01 went from 16 to 20 skipping 18 for unknown reason.
-- FAILED
-- did i delete some tool life records for tool var 1
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 1
-- 2020-11-20 07:37:19  OK

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
and Start_Time > '2020-12-01' 
order by Start_Time 
-- PASSED ON 12/7
-- BUT FAILED ON 12/08
-- count jumped from 52 to 56 skipping 54 at 09:27 to 09:57 so did not run entire time.


select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 21 
-- 2020-11-20 12:29:08 PASS

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
and Start_Time > '2020-12-01' 
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
and Start_Time > '2020-12-01' 
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
and Start_Time > '2020-12-01' 
order by Start_Time 
-- PASSED

select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 33 
-- 2020-11-19 10:46:17 PASS

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
and Start_Time > '2020-12-01' 

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
and Start_Time > '2020-12-01' 
-- PASSED
order by Start_Time 
/*
 * Found a bug in UDP13319.ToolLifeUpdate(). When we did not receive the COM9 call after a tool change
 * because of a tool setter single stepping through the code and stopping before the OCOM9 call the first
 * UDP message we would receive would have a counter value of 2 * IncrementBy.  Changed the code
 * to call Tool change code in this scenario.
 */
/*
at 2020-11-19 18:32:34 the counter was reset to 0 but there
was no label in the log book.  Jeremy showed me how we can check 
macman history to verify that the program was reloaded after a 
tool change.  If the program is not reloaded that means the 
tool length measurement from the parsetter was not updated
which could cause problems. 
*/
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
and Start_Time > '2020-12-01' 

order by Start_Time 
/*
 * Found a bug in UDP13319.ToolLifeUpdate(). When we did not receive the COM9 call after a tool change
 * because of a tool setter single stepping through the code and stopping before the OCOM9 call the first
 * UDP message we would receive would have a counter value of 2 * IncrementBy.  Changed the code
 * to call Tool change code in this scenario.
 */
/*
at 2020-11-23 17:34:26 the counter was reset to 0 but there
was no label in the log book.  Jeremy showed me how we can check 
macman history to verify that the program was reloaded after a 
tool change.  If the program is not reloaded that means the 
tool length measurement from the parsetter was not updated
which could cause problems. 
*/
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
and Start_Time > '2020-12-01' 
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
and Start_Time > '2020-12-01' 
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
amh.Assembly_Key,amh.Tool_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 6
and Start_Time > '2020-12-01' 

order by Start_Time 
-- 2020-11-20 02:16:26
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 6

(T66= SHLT140516N-FS IN1030 INSERT)
(END T6=DATUM L ROUGH BORE & CBORE)

select 
amh.Assembly_Key,amh.Tool_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 66
-- and Start_Time > '2020-12-01' 
order by Start_Time 

-- PASSED

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
and Start_Time > '2020-12-01' 
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
amh.Assembly_Machining_History_Key,amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,Running_Entire_Time,Increment_By_Check,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 8
and amh.Start_Time > '2020-12-01'
order by Start_Time
-- delete from Assembly_Machining_History amh where amh.Assembly_Machining_History_Key between 7198 and 7203
/*
 * Found a bug in UDP13319.ToolLifeUpdate(). When we did not receive the COM9 call after a tool change
 * because of a tool setter single stepping through the code and stopping before the OCOM9 call the first
 * UDP message we would receive would have a counter value of 2 * IncrementBy.  Changed the code
 * to call Tool change code in this scenario.
 */
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
and amh.Start_Time > '2020-12-01'
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
and amh.Start_Time > '2020-12-01'
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
and amh.Start_Time > '2020-12-01'
order by Start_Time 
-- NO TOOL CHANGE TODAY
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 14


/*
 * Log Check: PASSED
 */
select 
amh.Assembly_Key,amh.Tool_Key,pta.Assembly_No, Current_Value,Running_Total,
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

select tvm.Tool_Var, tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 1



