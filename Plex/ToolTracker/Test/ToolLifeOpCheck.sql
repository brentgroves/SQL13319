select 
-- amh.Plexus_Customer_No,amh.Workcenter_Key,amh.CNC_Key,amh.Part_Key,amh.Part_Operation_Key,
amh.Assembly_Key,amh.Tool_Key,
pta.Assembly_No,pta.Description,
pt.Tool_No,tt.Tool_Type_Code,pt.Description, 
pl.Standard_Tool_Life,amh.Current_Value amhCurrent_Value,cpl.Current_Value cplCurrent_Value,
amh.Running_Total amhRunning_Total, cpl.Running_Total cplRunning_Total,
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
inner join CNC_Tool_Op_Part_Life cpl
on amh.Plexus_Customer_No = pl.PCN 
and pl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key -- 1 to many
inner join Part_v_Tool_Assembly pta 
on amh.Plexus_Customer_No = pta.Plexus_Customer_No 
and amh.Assembly_Key = pta.Assembly_Key
inner join Part_v_Tool pt
on amh.Plexus_Customer_No = pt.Plexus_Customer_No 
and amh.Tool_Key = pt.Tool_Key
inner join Part_v_Tool_Type tt 
on pt.Tool_Type_Key = tt.Tool_Type_Key -- 1 to 1
inner join Tool_Var_Map tvm 
on amh.Plexus_Customer_No = tvm.Plexus_Customer_No 
and amh.Assembly_Key = tvm.Assembly_Key 
and amh.Tool_Key = tvm.Tool_Key 
order by amh.Assembly_Key 
-- where tvm.Tool_Var = 72



