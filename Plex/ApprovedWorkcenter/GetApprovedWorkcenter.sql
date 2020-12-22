set @CNC_Approved_Workcenter_Key=2;
set @Tool_Var = 33;
call GetApprovedWorkcenter(@CNC_Approved_Workcenter_Key,@Tool_Var,
@Plexus_Customer_No,@Workcenter_Key,@CNC_Key,@Pallets_Per_Tool,
@Part_Key,@Part_Operation_Key,@Assembly_Key,@Tool_Key,@Fastest_Cycle_Time);    
select @Plexus_Customer_No,@Workcenter_Key,@CNC_Key,@Pallets_Per_Tool,
@Part_Key,@Part_Operation_Key,@Assembly_Key,@Tool_Key,@Fastest_Cycle_Time;

select * from Tool_Var_Map

drop procedure GetApprovedWorkcenter
create procedure GetApprovedWorkcenter
(
	in pCNC_Approved_Workcenter_Key INT,
	in pTool_Var INT,
	OUT pPlexus_Customer_No INT,
	OUT pWorkcenter_Key INT,
	OUT pCNC_Key INT,
	out pPallets_Per_Tool int,
	out pPart_Key int,
	out pPart_Operation_Key int,
	out pAssembly_Key int,
	out pTool_Key int,
	out pFastest_Cycle_Time int
)
begin
	select
    -- caw.CNC_Approved_Workcenter_Key
   	caw.Plexus_Customer_No,
	caw.Workcenter_Key,
	caw.CNC_Key,
	caw.Pallets_Per_Tool,
	caw.Part_Key,
	caw.Part_Operation_Key,
	tv.Assembly_Key,
	tv.Tool_Key,
	caw.Fastest_Cycle_Time
	into pPlexus_Customer_No,pWorkcenter_Key,pCNC_Key,pPallets_Per_Tool,pPart_Key,pPart_Operation_Key,
	pAssembly_Key,pTool_Key,pFastest_Cycle_Time
   	from CNC_Approved_Workcenter_V2 caw 
	inner join Tool_Var_Map tv 
	on caw.Plexus_Customer_No = tv.Plexus_Customer_No
	and caw.CNC_Approved_Workcenter_Key = tv.CNC_Approved_Workcenter_Key  -- 1 to many
	-- where caw.CNC_Approved_Workcenter_Key=@pCNC_Approved_Workcenter_Key
	-- and  tv.Tool_Var = @pTool_Var;
	where caw.CNC_Approved_Workcenter_Key=pCNC_Approved_Workcenter_Key
	and  tv.Tool_Var = pTool_Var;
end