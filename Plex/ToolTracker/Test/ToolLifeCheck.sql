select tvm.Tool_Var, tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
-- where tl.Run_Date > '2020-12-01'
where tvm.Tool_Var = 30

-- delete from Part_v_Tool_Life tl where Tool_Life_Key  = 19
select tl.* 
from Part_v_Tool_Life tl
inner join Tool_Var_Map tvm 
on tl.PCN = tvm.Plexus_Customer_No 
and tl.Assembly_Key = tvm.Assembly_Key 
and tl.Tool_Key = tvm.Tool_Key 
where tvm.Tool_Var = 8

select * 
from Part_v_Tool_Life tl
order by Tool_Life_Key 