-- select * from Assembly_Machining_History_V2
set @CNC_Approved_Workcenter_Key = 2;
set @Tool_Var = 33;
set @Running_Entire_Time = 1;
set @Increment_By_Check = 0;
set @Zero_Detect = 0;


set @Pallet_No = 1;
SET @Current_Value = 14;
set @Running_Total = 14;
set @Start_Time = '2020-12-14 14:50:50';
set @End_Time = '2020-12-14 14:51:50';

/*
set @Pallet_No = 2;
SET @Current_Value = 16;
set @Running_Total = 16;
set @Start_Time = '2020-12-14 14:55:50';  -- 5 min
set @End_Time = '2020-12-14 14:56:50';  

-- Fastest_Cycle_Time test
set @Pallet_No = 1;
SET @Current_Value = 18;
set @Running_Total = 18;
set @Start_Time = '2020-12-14 15:00:50';  -- 5 min
set @End_Time = '2020-12-14 15:01:50';  

set @Pallet_No = 2;
SET @Current_Value = 20;
set @Running_Total = 20;
set @Start_Time = '2020-12-14 15:05:50'; -- 5 min
set @End_Time = '2020-12-14 15:06:50'; 

set @Pallet_No = 1;
SET @Current_Value = 22;
set @Running_Total = 22;
set @Start_Time = '2020-12-14 15:10:50';  -- 5 min
set @End_Time = '2020-12-14 15:11:50';  


-- TEST Counter_Jump, @Number_Pallets_Running_Tool = 2
set @Pallet_No = 2;
SET @Current_Value = 42;
set @Running_Total = 42;
set @Start_Time = '2020-12-14 15:15:50'; -- 5 min
set @End_Time = '2020-12-14 15:16:50'; 


-- Test Unexpected_Counter_Value 
set @Pallet_No = 1;
SET @Current_Value = 46;
set @Running_Total = 46;
set @Start_Time = '2020-12-14 15:20:50'; -- 5 min
set @End_Time = '2020-12-14 15:21:50'; 


-- TEST Unexpected_Counter_Value,Counter_Jump
set @Pallet_No = 2;
SET @Current_Value = 64;
set @Running_Total = 64;
set @Start_Time = '2020-12-14 15:25:50'; -- 5 min
set @End_Time = '2020-12-14 15:26:50'; 


set @Pallet_No = 1;
SET @Current_Value = 66;
set @Running_Total = 66;
set @Start_Time = '2020-12-14 15:30:50'; -- 5 min
set @End_Time = '2020-12-14 15:31:50'; 

-- Test Unexpected_Counter_Value
set @Pallet_No = 2;
SET @Current_Value = 70;
set @Running_Total = 70;
set @Start_Time = '2020-12-14 15:35:50'; -- 5 min
set @End_Time = '2020-12-14 15:36:50'; 

-- Test Looped_Out
set @Pallet_No = 2;
SET @Current_Value = 68;
set @Running_Total = 68;
set @Start_Time = '2020-12-14 15:30:50'; -- 5 min
set @End_Time = '2020-12-14 15:31:50'; 

*/
-- select * from Issue_Type;
-- ADD STARVING,TOOL_CHANGE_TIME
-- FIX BUG ONLY 1 ISSUE SHOULD BE ADDED WHEN THERE IS A COUNTER JUMP THERE IS NOW 1 FOR EACH PALLET.
CALL InsAssemblyMachiningHistory_V2(@CNC_Approved_Workcenter_Key,@Pallet_No,@Tool_Var,@Current_Value,@Running_Total,@Running_Entire_Time,
@Increment_By_Check,@Zero_Detect,@Start_Time,@End_Time,@Assembly_Machining_History_Key,@Return_Value);
select @Assembly_Machining_History_Key,@Return_Value;
select it.Issue_Type,i.* from Issue i inner join Issue_Type it on i.Plexus_Customer_No = it.Plexus_Customer_No and i.Issue_Type_Key = it.Issue_Type_Key;
select * from Assembly_Machining_History_V2; -- where Assembly_Key = 25
select * from CNC_Approved_Workcenter_V2;
-- update CNC_Approved_Workcenter_V2 set Fastest_Cycle_Time = 0 where CNC_Key=3;
-- drop table CNC_Approved_Workcenter_V2
-- truncate table Assembly_Machining_History_V2
-- CREATE TABLE Assembly_Machining_History_12_09 SELECT * FROM Assembly_Machining_History; -- backup 
-- CREATE TABLE CNC_Approved_Workcenter_V2 select * from CNC_Approved_Workcenter; -- backup
-- select * from Assembly_Machining_History_12_09
-- truncate table Issue;
SELECT * FROM Issue;

DROP PROCEDURE InsAssemblyMachiningHistory_V2;
CREATE PROCEDURE InsAssemblyMachiningHistory_V2
(
	IN pCNC_Approved_Workcenter_Key INT,  
	IN pPallet_No INT,
	IN pTool_Var INT,
	IN pCurrent_Value INT,
	IN pRunning_Total INT,
  	IN pRunning_Entire_Time BIT,
  	IN pIncrement_By_Check BIT,	
  	IN pZero_Detect BIT,
	IN pStart_Time datetime,
	IN pEnd_Time datetime,
	OUT pAssembly_Machining_History_Key INT,
	OUT pReturnValue INT 
)
BEGIN
	
/*
 * Calc Cycle_Time
 */
	-- set @pCNC_Approved_Workcenter_Key = 2;
	-- set @pTool_Var = 339;
	-- set @pStart_Time = '2020-12-14 14:50:50';
	-- set @Plexus_Customer_No=0,@Workcenter_Key=0,@CNC_Key=0,@Part_Key=0,@Part_Operation_Key=0,@Assembly_Key=0,@Tool_Key=0,@Fastest_Cycle_Time=0,
	-- @Last_Start_Time_Same_Pallet=0,@Last_Start_Time_Other_Pallet=0,@Last_Value_Same_Pallet=0,@Estimated_Cycles=0,@Increment_By=0,@Estimated_Increase=0,@Number_Pallets_Running_Tool=1,
	-- @Pallets_Per_Tool=0,@Record_Count_Same_Pallet = 0,@Record_Count_Any_Pallet = 0,@Unexpected_Counter_Value =0,@Counter_Jump=0,@Pallet_Looped_Out=0;

	-- TESTING ONLY
	set @Shift_Start = Shift_Start(STR_TO_DATE('2020-12-14 14:50:50','%Y-%m-%d %H:%i:%s'));
	-- set @Shift_Start = Shift_Start(pStart_Time);
	-- set @Shift_Start = Shift_Start(NOW());
	select @Shift_Start;

	/*
	 * Retrieve info to be used elsewhere in the SPROC
	 */
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
	into @Plexus_Customer_No,@Workcenter_Key,@CNC_Key,@Pallets_Per_Tool,@Part_Key,@Part_Operation_Key,@Assembly_Key,@Tool_Key,@Fastest_Cycle_Time
   	from CNC_Approved_Workcenter_V2 caw 
	inner join Tool_Var_Map tv 
	on caw.Plexus_Customer_No = tv.Plexus_Customer_No
	and caw.CNC_Approved_Workcenter_Key = tv.CNC_Approved_Workcenter_Key  -- 1 to many
	-- where caw.CNC_Approved_Workcenter_Key=@pCNC_Approved_Workcenter_Key
	-- and  tv.Tool_Var = @pTool_Var;
	where caw.CNC_Approved_Workcenter_Key=pCNC_Approved_Workcenter_Key
	and  tv.Tool_Var = pTool_Var;

	-- select @Plexus_Customer_No,@Workcenter_Key,@CNC_Key,@Part_Key,@Part_Operation_Key,@Assembly_Key,@Tool_Key,@Fastest_Cycle_Time;
	
	/*
	 * It is possible to have only 1 pallet running a tool in this case @Other_Pallet_No equals 0
	 */
	set @Other_Pallet_No = case 
		when (1 = @Pallets_Per_Tool) then 0
		when (1 = pPallet_No) then 2
		else 1
	end;

	select pPallet_No,@Other_Pallet_No;

	/*
	 * Collect the data needed to analyze the input.
	 */
	SET @Record_Count_Same_Pallet=0,@Record_Count_Any_Pallet=0,@Record_Count_Other_Pallet=0,
	@Record_Count_From_Shift_Start_Limit_5=0,@Number_Pallets_Running_Tool=0,@Last_Start_Time_Same_Pallet=null,
	@Cycle_Time=0,@Last_Value_Same_Pallet=0,@Increment_By=0;


	call InsAMHInfo(@Plexus_Customer_No,@Workcenter_Key,@CNC_Key,@Pallets_Per_Tool,pPallet_No,@Other_Pallet_No,
	@Part_Key,@Part_Operation_Key,@Assembly_Key,@Tool_Key,pStart_Time,
	@Record_Count_Same_Pallet,@Record_Count_Any_Pallet,@Record_Count_Other_Pallet,@Record_Count_From_Shift_Start_Limit_5,
	@Number_Pallets_Running_Tool,@Last_Start_Time_Same_Pallet,@Cycle_Time,@Last_Value_Same_Pallet);

	select @Record_Count_Same_Pallet,@Record_Count_Any_Pallet,@Record_Count_Other_Pallet,
	@Record_Count_From_Shift_Start_Limit_5,@Number_Pallets_Running_Tool,@Last_Start_Time_Same_Pallet,
	@Cycle_Time,@Last_Value_Same_Pallet;
	

	set @Pallet_Looped_Out = 0;
	if ((@Pallets_Per_Tool>1) and (0 != @Number_Pallets_Running_Tool ) and (@Pallets_Per_Tool != @Number_Pallets_Running_Tool)) then
		set @Pallet_Looped_Out = 1;
		select count(*) into @Already_Added from Issue 
		where Plexus_Customer_No= @Plexus_Customer_No and Workcenter_Key = @Workcenter_Key  and CNC_Key = @CNC_Key and Pallet_No = pPallet_No
		and Part_Key = @Part_Key and Part_Operation_Key = @Part_Operation_Key and Assembly_Key = @Assembly_Key and Tool_Key = @Tool_Key
		and Start_Time > @Shift_Start;
		if(0 = @Already_Added) THEN 
			insert into Issue (Plexus_Customer_No,Issue_Type_Key,Workcenter_Key,CNC_Key,Pallet_No,Part_Key,Part_Operation_Key,Assembly_Key,Tool_Key,Start_Time,Inactive_Pallet)
			values (@Plexus_Customer_No,4,@Workcenter_Key,@CNC_Key,pPallet_No,@Part_Key,@Part_Operation_Key,@Assembly_Key,@Tool_Key,pStart_Time,@Other_Pallet_No);
		end if;
	end if;
	select @Pallet_Looped_Out;

end;

set @Shitft_Tool_Change_Avoidance_Other_Pallet=0;
-- select * from Issue_Type
-- select * from Issue;
select 
count(*)
into @Shitft_Tool_Change_Avoidance_Other_Pallet
from Issue 
where Plexus_Customer_No= @Plexus_Customer_No and Workcenter_Key = @Workcenter_Key  and CNC_Key = @CNC_Key and Pallet_No = @Other_Pallet_No
and Part_Key = @Part_Key and Part_Operation_Key = @Part_Operation_Key and Assembly_Key = @Assembly_Key and Tool_Key = @Tool_Key
Start_Time = @Last_Start_Time_Other_Pallet and Issue_Type_Key = 3;

set @Network_Error_Other_Pallet=0;
select 
count(*)
into @Network_Error_Other_Pallet
from Issue 
where Plexus_Customer_No= @Plexus_Customer_No and Workcenter_Key = @Workcenter_Key  and CNC_Key = @CNC_Key and Pallet_No = @Other_Pallet_No
and Part_Key = @Part_Key and Part_Operation_Key = @Part_Operation_Key and Assembly_Key = @Assembly_Key and Tool_Key = @Tool_Key
Start_Time = @Last_Start_Time_Other_Pallet and Issue_Type_Key = 2;

set @Increment_By = 0;
select 
-- opl.PCN Plexus_Customer_No,cpl.Workcenter_Key,cpl.CNC_Key,opl.Part_Key,cpl.Part_Operation_Key,opl.Assembly_Key,opl.Tool_Key, 
cpl.Increment_By 
into @Increment_By
from Part_v_Tool_Op_Part_Life opl
inner join CNC_Tool_Op_Part_Life cpl
on opl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key -- 1 to many
where opl.PCN= @Plexus_Customer_No and cpl.Workcenter_Key = @Workcenter_Key  and cpl.CNC_Key = @CNC_Key 
and opl.Part_Key = @Part_Key and cpl.Part_Operation_Key = @Part_Operation_Key and opl.Assembly_Key = @Assembly_Key and opl.Tool_Key = @Tool_Key;
	
select @Increment_By;

/*
 * This is meant to identify when there is a network or other failure preventing us from inserting Assembly Machining History records.
 * It will also detect when the CNC operator or Tool setter are setting counter values ahead possibly to avoid having to do a tool 
 * change on there shift.
 */
	set @Shift_Tool_Change_Avoidance=0;

	if((0 = @Shift_Tool_Change_Avoidance_Other_Pallet ) and -- DON'T INSERT IF WE JUST INSERTED ONE ON THE PREVIOUS PALLET
	   (0 != @Number_Pallets_Running_Tool) and -- WE NEED @Number_Pallets_Running_Tool IN ORDER TO CALCULATE THE ESTIMATED INCREASE
	   -- BECAUSE WE ARE DOING THE MATH BASED UPON THE CYCLE TIME
	   -- WE MAY NOT CATCH A COUNTER JUMP THAT IS DONE AT THE BEGINNING OF THE SHIFT.
	   (0 != @Cycle_Time ) and (0 != @Fastest_Cycle_Time )) THEN 
		set @Estimated_Cycles = @Cycle_Time / @Fastest_Cycle_Time;
		set @Estimated_Increase = @Estimated_Cycles * @Increment_By * @Number_Pallets_Running_Tool;
		if(pCurrent_Value > (@Last_Value_Same_Pallet + (5*@Estimated_Increase))) then
			if (0=@Jump_Added) then 
				set @Counter_Jump = 1;
				-- select * from Issue_Type;
				insert into Issue (Plexus_Customer_No,Issue_Type_Key,Workcenter_Key,CNC_Key,Pallet_No,
				Part_Key,Part_Operation_Key,Assembly_Key,Tool_Key,Start_Time,Previous_Time,Cycle_Time,Fastest_Cycle_Time,Current_Value,Previous_Value)
				values (@Plexus_Customer_No,2,@Workcenter_Key,@CNC_Key,pPallet_No,@Part_Key,@Part_Operation_Key,
				@Assembly_Key,@Tool_Key,pStart_Time,@Last_Start_Time_Same_Pallet,@Cycle_Time,@Fastest_Cycle_Time,pCurrent_Value,@Last_Value_Same_Pallet);
			end if;
		end if;
	end if;
	select  @Estimated_Cycles,@Estimated_Increase,@Counter_Jump;
-- START HERE
	/*
	 * Base @Unexpected_Counter_Value on this pallet only?  We are sure this pallet is running
	 * but we are not sure the other pallet is running, and we are not sure the other pallet
	 * is running this tool.
	 */
	set @Unexpected_Counter_Value = 0;
	if ((0 = @Counter_Jump) and (0 != @Last_Value_Other_Pallet)) then
/*	
	   (0 = @Unexpected_Counter_Value_Other_Pallet) and 
	   (0 = @Counter_Jump_Other_Pallet ) and 
	   (0 = @Counter_Jump) and
	   (0 != @Last_Value_Same_Pallet) and (0 != @Number_Pallets_Running_Tool)) then 
*/	   
		set @Unexpected_Counter_Value = case 
			when pCurrent_Value != (@Last_Value_Other_Pallet + @Increment_By) then 1 
			else 0
		end;
		if(1 = @Unexpected_Counter_Value) then
			insert into Issue (Plexus_Customer_No,Issue_Type_Key,Workcenter_Key,CNC_Key,Pallet_No,
			Part_Key,Part_Operation_Key,Assembly_Key,Tool_Key,Start_Time,Previous_Time,Cycle_Time,Fastest_Cycle_Time,Current_Value,Previous_Value)
			values (@Plexus_Customer_No,1,@Workcenter_Key,@CNC_Key,pPallet_No,@Part_Key,@Part_Operation_Key,
			@Assembly_Key,@Tool_Key,pStart_Time,@Last_Start_Time_Same_Pallet,@Cycle_Time,@Fastest_Cycle_Time,pCurrent_Value,@Last_Value_Same_Pallet);
		end if;
	end if;

	select @Unexpected_Counter_Value;

	if (0 != @Cycle_Time ) and ((0 = @Fastest_Cycle_Time ) or (@Cycle_Time<@Fastest_Cycle_Time)) then
	--    SELECT 'Update Fastest_Cycle_Time';
	   	update CNC_Approved_Workcenter_V2 caw 
	   	set Fastest_Cycle_Time = @Cycle_Time
		-- where caw.CNC_Approved_Workcenter_Key=@pCNC_Approved_Workcenter_Key
		-- and  tv.Tool_Var = @pTool_Var;
		where caw.CNC_Approved_Workcenter_Key=pCNC_Approved_Workcenter_Key;
	end if;

  	-- This will be inserted when the Tool Assembly time starts
	insert into Assembly_Machining_History_V2 (Plexus_Customer_No,Workcenter_Key,CNC_Key,Pallet_No,Part_Key,Part_Operation_Key,Assembly_Key,Tool_Key,Current_Value,
	Running_Total,Running_Entire_Time,Increment_By_Check,Zero_Detect,Start_Time,End_Time,Run_Time,Cycle_Time,
	Unexpected_Counter_Value,Counter_Jump,Pallet_Looped_Out)
	
/*
	set @pCNC_Approved_Workcenter_Key = 2;
	set @pPallet_No = 1;
	set @pTool_Var = 1;
	set @pStart_Time = '2020-09-05 09:48:00';
	set @pEnd_Time = '2020-09-05 09:50:10';
*/
	select 
	@Plexus_Customer_No,
	@Workcenter_Key,
	@CNC_Key,
	pPallet_No Pallet_No,
	@Part_Key,@Part_Operation_Key,@Assembly_Key,@Tool_Key,
	pCurrent_Value Current_Value,  -- Just changed this 11/14 not tested
	pRunning_Total Running_Total, -- Just changed this 11/14 not tested
	pRunning_Entire_Time Running_Entire_Time, -- changed this on 12/08
	pIncrement_By_Check Increment_By_Check, -- added this on 12/08
	pZero_Detect Zero_Detect, -- added this on 12/10
	pStart_Time Start_Time,
	pEnd_Time End_Time,
	TIMESTAMPDIFF(SECOND, pStart_Time, pEnd_Time) Run_Time,
	@Cycle_Time Cycle_Time,
	@Unexpected_Counter_Value Unexpected_Counter_Value,
	@Counter_Jump Counter_Jump,
	@Pallet_Looped_Out Pallet_Looped_Out;
	
	set pAssembly_Machining_History_Key = (select Assembly_Machining_History_Key from Assembly_Machining_History_V2 where Assembly_Machining_History_Key =(SELECT LAST_INSERT_ID()));
   	set pReturnValue = 0;
END;
