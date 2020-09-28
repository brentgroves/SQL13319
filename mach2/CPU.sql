
/* CPU Report */
select 
r.CNC,r.Part_No,r.Operation_Code,r.Assembly_No,r.Description,r.Tool_Life,
sum(Adj_Price_Per_Tool_Change) Price_Per_Tool_Change,
Format(sum(Adj_Price_Per_Tool_Change),2) Frm_Price_Per_Tool_Change,
Format(sum(Adj_Price_Per_Tool_Change) / r.Tool_Life,5) CPU

-- select r.*
from
(
	SELECT 
	a1.CNC,a1.Part_No,a1.Operation_Code,a1.Assembly_No, a1.Description,a1.Tool_No,
	a1.Tool_Life, -- Tool Life in OTLM.SSB
	a1.QuantityPerCuttingEdge,mQ.MinQuantityPerCuttingEdge,
	mQ.MinQuantityPerCuttingEdge/a1.QuantityPerCuttingEdge Tool_Life_Ratio,
	a1.Price_Per_Tool_Change,
	a1.Price_Per_Tool_Change*(mQ.MinQuantityPerCuttingEdge/a1.QuantityPerCuttingEdge) Adj_Price_Per_Tool_Change
	-- select a1.Tool_Life,a1.Price_Per_Tool_Change*(mQ.MinQuantityPerCuttingEdge/a1.QuantityPerCuttingEdge) Adj_Price_Per_Tool_Change
	from 
	(
	
		select 
		ca.CNC_Part_Operation_Assembly_Key,
		-- c.CNC,p.Part_No,o.Operation_Code,ta.Assembly_No,
		min(tb.QuantityPerCuttingEdge) MinQuantityPerCuttingEdge 
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
		group by ca.CNC_Part_Operation_Assembly_Key,c.CNC,p.Part_No,o.Operation_Code,ta.Assembly_No
	)mQ
	inner join 
	(
		select 
		-- ta.Description, tt.Tool_Type_Code,tg.Tool_Group_Code,t.Description,tb.Quantity_Required,t.NumberOfCuttingEdges
		ca.CNC_Part_Operation_Assembly_Key,
		c.CNC,p.Part_No,o.Operation_Code,ta.Assembly_No, ta.Description,t.Tool_No,tt.Tool_Type_Code,tg.Tool_Group_Code,ca.Tool_Life,
		tb.Quantity_Required,tb.QuantityPerCuttingEdge,t.NumberOfCuttingEdges,t.Price,
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
	)a1
	on mQ.CNC_Part_Operation_Assembly_Key=a1.CNC_Part_Operation_Assembly_Key
)r
group by r.CNC,r.Part_No,r.Operation_Code,r.Assembly_No,r.Description,r.Tool_Life



select
s1.CNC,s1.Part_No,s1.Operation_Code,s1.Description,s1.Tool_No,s1.Tool_Type_Code,s1.Tool_Group_Code,s1.Tool_Life,
sum(Price_Per_Tool_Change) Price_Per_Tool_Change,
sum(Price_Per_Tool_Change) / s1.Tool_Life CPU
from 
(
	select 
	-- ta.Description, tt.Tool_Type_Code,tg.Tool_Group_Code,t.Description,tb.Quantity_Required,t.NumberOfCuttingEdges
	c.CNC,p.Part_No,o.Operation_Code,ta.Description,t.Tool_No,tt.Tool_Type_Code,tg.Tool_Group_Code,ca.Tool_Life,
	tb.Quantity_Required,t.NumberOfCuttingEdges,t.Price,t.price/t.NumberOfCuttingEdges Price_Per_Cutting_Edge,
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