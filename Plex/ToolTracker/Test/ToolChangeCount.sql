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


