

select
s1.CNC,s1.Part_No,s1.Operation_Code,s1.Description,s1.Tool_No,s1.Tool_Type_Code,s1.Tool_Group_Code,s1.Tool_Life,
sum(Price_Per_Tool_Change) Price_Per_Tool_Change,
sum(Price_Per_Tool_Change) / s1.Tool_Life CPU
from 
(
	select 
	-- ta.Description, tt.Tool_Type_Code,tg.Tool_Group_Code,t.Description,tb.Quantity_Required,t.NumberOfCuttingEdges
	c.CNC,p.Part_No,o.Operation_Code,ta.Description,t.Tool_No,tt.Tool_Type_Code,tg.Tool_Group_Code,ca.Tool_Life,tb.Quantity_Required,t.NumberOfCuttingEdges,t.Price,
	t.price/t.NumberOfCuttingEdges Price_Per_Cutting_Edge,
	tb.Quantity_Required*(t.price/t.NumberOfCuttingEdges) Price_Per_Tool_Change
	from CNC_Part_Operation_Assembly ca 
	inner join CNC c 
	on ca.CNC_Key=c.CNC_Key -- 1 to 1
	inner join Part p 
	on ca.Part_Key = p.Part_Key 
	inner join Operation o 
	on ca.Operation_Key = o.Operation_Key 
	inner join Tool_Assembly ta 
	on ca.Assembly_Key=ta.Assembly_Key   -- 1 to 1
	inner join Tool_BOM tb 
	on ca.Assembly_Key = tb.Assembly_Key  -- 1 to many
	inner join Tool t 
	on tb.Tool_Key=t.Tool_Key -- 1 to many
	inner join Tool_Type tt 
	on t.Tool_Type_Key=tt.Tool_Type_Key  -- 1 to 1
	inner join Tool_Group tg 
	on t.Tool_Group_Key=tg.Tool_Group_key  -- 1 to 1
)s1
group by s1.CNC,s1.Part_No,s1.Operation_Code,s1.Description,s1.Tool_No,s1.Tool_Type_Code,s1.Tool_Group_Code,s1.Tool_Life