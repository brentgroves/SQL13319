select count(*) from Assembly_Machining_History  -- 1235
 SELECT * FROM Assembly_Machining_History amh;
CREATE TABLE Assembly_Machining_History_11_14  SELECT * FROM Assembly_Machining_History amh;  -- 1263
select 
amh.Assembly_Key,amh.Tool_Key,pta.Assembly_No, pt.Tool_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
inner join Part_v_Tool pt
on amh.Tool_Key = pt.Tool_Key 
order by End_Time desc
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
-- where Assembly_Key = 14
-- where Assembly_Key = 18 -- tool_life yes
order by Current_Value 

/* Test MachingHistory */
(300758,1,1,13,9,0),
(300758,2,14,14,6,0),  
Started 11/13 10:05 at 102
End at 11:14 02:11 with 200
Start: 11:14 02:24 with 2
Continue: 11:14 08:27 with 42
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
Assembly_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
where Assembly_Key = 18 -- 
order by Start_Time 
Start: 11/13 10:10, Current_Value = 156 End: 11/13 12:34 Running_Total=172
Start: 11/13 12:46,2 End: 11/14 08:18 124 Running_Total=124
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
select 
Assembly_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
where Assembly_Key = 23 -- 
order by Start_Time -- TL=226
Start_Time: 11/13 10:14  Current_Value = 184
11/13 11:58 Counter set back to 170 from 196
End_Time 11/13 17:03 Running_Total = 226
Start_Time: 11/13 17:17 Current_Value = 2
11/14 09:04 Current_Value 102



(300758,13,3,23,2,0), -- VC6,009240,SHLT110408N-PH1 IN2005,DATUM L ROUGH BORE & C'BORE
(300758,14,4,23,2,1), -- Alternate Tool for,008318, one of the T6 inserts.  
(300758,15,5,23,2,0), -- VC66,008318,SHLT140516N-FS IN1030 INSERT,DATUM L ROUGH BORE & C'BORE
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
