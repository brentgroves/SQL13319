select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 66

