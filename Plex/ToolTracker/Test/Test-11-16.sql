-- Test
-- 11-16 3rd shift

/*
 * Tool Life Test: Log
 * T8
 * T1 x 2
 */

select * from Part_v_Tool_Assembly where CNC_Tool_No = 8  

select count(*) from Assembly_Machining_History amh  -- 2474 @ 10:30, 2789 @ 15:30
-- where amh.Assembly_Key = 13  -- T1/ 93
-- where amh.Assembly_Key = 14  -- T21/93
-- where amh.Assembly_Key = 15  -- T22/94
-- where amh.Assembly_Key = 16  -- T23/94
-- where amh.Assembly_Key = 17  -- T72/94
-- where amh.Assembly_Key = 18  
-- and amh.Tool_Key = 19  -- T33/VC33/94
-- where amh.Assembly_Key = 18  
-- and amh.Tool_Key = 18  -- T33/VC34/94
-- where amh.Assembly_Key = 19  -- T30/93
-- where amh.Assembly_Key = 20  -- T4/94
-- where amh.Assembly_Key = 21  -- T15/94
-- where amh.Assembly_Key = 22  -- T7/94
-- where amh.Assembly_Key = 23
-- and amh.Tool_Key = 3  -- T6/VC6/94
-- where amh.Assembly_Key = 23
-- and amh.Tool_Key = 5  -- T6/VC66/94
where amh.Assembly_Key = 24  -- T9/0 ************************* 
where amh.Assembly_Key = 25  -- T8/0 ***************************
-- where amh.Assembly_Key = 26 -- T12/93
--  where amh.Assembly_Key = 27  -- T13/94
where amh.Assembly_Key = 28  -- T14/95

 select * from Tool_Var_Map where Tool_Var =14
tool_var =8 to assy/tool=25/7


set @CNC_Approved_Workcenter_Key = 2;
set @Pallet_No = 1;
set @Tool_Var = 8;
SET @Current_Value = 10;
set @Running_Total = 12;
set @Start_Time = '2020-10-25 09:50:00';
set @End_Time = '2020-10-25 09:50:50';
CALL InsAssemblyMachiningHistory(@CNC_Approved_Workcenter_Key,@Pallet_No,@Tool_Var,@Current_Value,@Running_Total,@Start_Time,@End_Time,@Assembly_Machining_History_Key,@Return_Value);
select @Assembly_Machining_History_Key,@Return_Value;

select * from Assembly_Machining_History where Assembly_Key in (24,25)
select  * from Assembly_Machining_History order by Start_Time desc
-- delete from Assembly_Machining_History where Assembly_Key = 25
-- delete from Assembly_Machining_History where Assembly_Machining_History_Key = 25
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
where amh.Assembly_Key = 24
-- and Tool_Key = 18  
order by Start_Time 
