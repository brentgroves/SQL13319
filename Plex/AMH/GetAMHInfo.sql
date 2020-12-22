select * from Issue_Type

set @Plexus_Customer_No = 300758;
set @Workcenter_Key = 61090;
set @CNC_Key = 3;
set @Pallet_No = 1;
set @Other_Pallet_No = 2;
set @Part_Key = 2794706;
set @Part_Operation_Key = 7874404;
set @Assembly_Key = 18;
set @Tool_Key = 19;
set @Start_Time = '2020-12-14 15:25:50'; -- 5 min
set @Pallets_Per_Tool = 2;

call GetAMHInfo(@Plexus_Customer_No,@Workcenter_Key,@CNC_Key,@Pallets_Per_Tool,@Pallet_No,@Other_Pallet_No,@Part_Key,@Part_Operation_Key,@Assembly_Key,@Tool_Key,@Start_Time,
@Record_Count_Same_Pallet,@Record_Count_Any_Pallet,@Record_Count_Other_Pallet,@Record_Count_From_Shift_Start_Limit_5,
@Number_Pallets_Running_Tool,@Last_Start_Time_Same_Pallet,@Cycle_Time,@Last_Value_Same_Pallet);
-- select @Record_Count_Same_Pallet,@Record_Count_Any_Pallet;

/*
 * Information needed to analyze AssemblyMachineHistory records for issue insertions.
 * Needed since the InsAssemblyMachineHistory SPROC would be extremely large unless divided.
 */
drop procedure GetAMHInfo;
create procedure GetAMHInfo
(
	in pPlexus_Customer_No INT,
	in pWorkcenter_Key INT,
	in pCNC_Key INT,
	in pPallets_Per_Tool int,
	in pPallet_No INT,
	in pOther_Pallet_No INT,
	in pPart_Key INT,
	in pPart_Operation_Key int,
	in pAssembly_Key int,
	in pTool_Key int,
	in pStart_Time datetime,
	OUT pRecord_Count_Same_Pallet INT,
	OUT pRecord_Count_Any_Pallet INT,
	OUT pRecord_Count_Other_Pallet INT,
	out pRecord_Count_From_Shift_Start_Limit_5 int,
	out pNumber_Pallets_Running_Tool int,
	out pLast_Start_Time_Same_Pallet datetime,
	out pCycle_Time int,
	out pLast_Value_Same_Pallet int
)
begin
	-- set @Shift_Start = Shift_Start(STR_TO_DATE('2020-12-14 14:50:50','%Y-%m-%d %H:%i:%s'));
	set @Shift_Start = Shift_Start(pStart_Time);
	-- set @Shift_Start = Shift_Start(NOW());
	-- select @Shift_Start;

	select 
	count(*) 
	into pRecord_Count_Same_Pallet
	from Assembly_Machining_History_V2 
	where Plexus_Customer_No= pPlexus_Customer_No and Workcenter_Key = pWorkcenter_Key  and CNC_Key = pCNC_Key and Pallet_No = pPallet_No
	and Part_Key = pPart_Key and Part_Operation_Key = pPart_Operation_Key and Assembly_Key = pAssembly_Key and Tool_Key = pTool_Key;
	
	-- select pRecord_Count_Same_Pallet;

	select 
	count(*) 
	into pRecord_Count_Any_Pallet
	from Assembly_Machining_History_V2 
	where Plexus_Customer_No= pPlexus_Customer_No and Workcenter_Key = pWorkcenter_Key  and CNC_Key = pCNC_Key 
	and Part_Key = pPart_Key and Part_Operation_Key = pPart_Operation_Key and Assembly_Key = pAssembly_Key and Tool_Key = pTool_Key;
	
	-- select pRecord_Count_Any_Pallet;

	-- select pPallets_Per_Tool,pOther_Pallet_No;
	set pRecord_Count_Other_Pallet = 0;
	if (pPallets_Per_Tool > 1 ) then
		select 
		count(*) 
		into pRecord_Count_Other_Pallet
		from Assembly_Machining_History_V2 
		-- select count(*) into @Prev_Record_Exists from Assembly_Machining_History 
		where Plexus_Customer_No= pPlexus_Customer_No and Workcenter_Key = pWorkcenter_Key  and CNC_Key = pCNC_Key and Pallet_No = pOther_Pallet_No
		and Part_Key = pPart_Key and Part_Operation_Key = pPart_Operation_Key and Assembly_Key = pAssembly_Key and Tool_Key = pTool_Key;
	end if;
	
	-- select pRecord_Count_Other_Pallet;

	set pRecord_Count_From_Shift_Start_Limit_5 = 0;
	/* 
	 * This variable is only used for determining if a pallet has been looped out
	 * so only make this calculation if there is more than 1 Pallets_Per_Tool
	 */
	if (pPallets_Per_Tool > 1) then 
		select count(*)
		into pRecord_Count_From_Shift_Start_Limit_5
		from 
		(
			-- Had to do it this way.  Could not get an accurate count() when using limit clause
			select Pallet_No
			from Assembly_Machining_History_V2 
			where Plexus_Customer_No= pPlexus_Customer_No and Workcenter_Key = pWorkcenter_Key  and CNC_Key = pCNC_Key 
			and Part_Key = pPart_Key and Part_Operation_Key = pPart_Operation_Key and Assembly_Key = pAssembly_Key and Tool_Key = pTool_Key
			and Start_Time >= @Shift_Start
			order by Assembly_Machining_History_Key desc 
			LIMIT 5 OFFSET 0
		)s1;
	end if;
	-- select pRecord_Count_From_Shift_Start_Limit_5;

	set pNumber_Pallets_Running_Tool = 0;

	if ((pPallets_Per_Tool > 1) and (pRecord_Count_From_Shift_Start_Limit_5 =5)) then
		/*
		 * Look at the 5 most recent records in the Assembly_Machining_History table 
		 * from the shift start to make this determination
		 */
		select count(*)
		into pNumber_Pallets_Running_Tool
		from 
		(
			select distinct Pallet_No
			from 
			(
				-- Had to do it this way.  Could not use distinct when using limit clause
				select Pallet_No 
				from Assembly_Machining_History_V2 
				where Plexus_Customer_No= pPlexus_Customer_No and Workcenter_Key = pWorkcenter_Key  and CNC_Key = pCNC_Key 
				and Part_Key = pPart_Key and Part_Operation_Key = pPart_Operation_Key and Assembly_Key = pAssembly_Key and Tool_Key = pTool_Key
				and Start_Time >= @Shift_Start
				order by Assembly_Machining_History_Key desc 
				LIMIT 5 OFFSET 0
			)s1 
		)s2;
	end if;

	-- select pNumber_Pallets_Running_Tool;
	-- select pRecord_Count_Same_Pallet,pStart_Time;
	select 
	case  
		when pRecord_Count_Same_Pallet = 0 then null 
		else max(start_time)  -- This is the Last_Start_Time_Same_Pallet for this Tool and Pallet_No.
	end, 	
	case 
		when pRecord_Count_Same_Pallet = 0 then 0
		else TIMESTAMPDIFF(SECOND,max(start_time),pStart_Time) 
	end
	into pLast_Start_Time_Same_Pallet,pCycle_Time 
	from Assembly_Machining_History_V2 
	where Plexus_Customer_No= pPlexus_Customer_No and Workcenter_Key = pWorkcenter_Key  and CNC_Key = pCNC_Key and Pallet_No = pPallet_No
	and Part_Key = pPart_Key and Part_Operation_Key = pPart_Operation_Key and Assembly_Key = pAssembly_Key and Tool_Key = pTool_Key;

	-- select pLast_Start_Time_Same_Pallet,pCycle_Time;

	set pLast_Value_Same_Pallet = 0;
	if (0 != pRecord_Count_Same_Pallet )  then
		select Current_Value  -- This is the value of the counter for this Tool and Pallet_No.
		into pLast_Value_Same_Pallet
		from Assembly_Machining_History_V2 
		where Plexus_Customer_No= pPlexus_Customer_No and Workcenter_Key = pWorkcenter_Key  and CNC_Key = pCNC_Key and Pallet_No = pPallet_No
		and Part_Key = pPart_Key and Part_Operation_Key = pPart_Operation_Key and Assembly_Key = pAssembly_Key and Tool_Key = pTool_Key
	 	and Start_Time = pLast_Start_Time_Same_Pallet;
	end if;
	-- select pLast_Value_Same_Pallet;

end
