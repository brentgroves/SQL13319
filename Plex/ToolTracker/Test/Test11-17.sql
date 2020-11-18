-- TestV2
-- 11-17 1st shift

/*
 * Tool Life Test: Log
 */



/*
Assembly_Key|Start_Time         
------------|-------------------
          14|2020-11-16 20:56:47
          18|2020-11-17 09:51:03
          20|2020-11-16 21:52:34
          13|2020-11-17 04:54:13          
*/
select 
amh.Assembly_Key,pta.Assembly_No, Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
inner join Part_v_Tool_Assembly pta 
on amh.Assembly_Key = pta.Assembly_Key 
where amh.Assembly_Key = 18
and Tool_Key = 18  -- VC34  -- 
order by Start_Time 
