CREATE PROCEDURE ProcessCNCData( IN pCNC_Approved_Workcenter_Key INT,
IN pPallet_No INT,
IN pTool_Var INT,
IN pCurrent_Value INT,
IN pRunning_Total INT,
IN pRunning_Entire_Time BIT,
IN pIncrement_By_Check BIT,
IN pZero_Detect BIT,
IN pStart_Time DATETIME,
IN pEnd_Time DATETIME,
out pAssembly_Machining_History_Key INT,
out pReturnValue INT 
) 
BEGIN
-- DROP procedure ProcessCNCData
 SET
@Shift_Start = Shift_Start( STR_TO_DATE('2020-12-14 14:50:50',
'%Y-%m-%d %H:%i:%s') );

-- SET @Shift_Start = Shift_Start(pStart_Time);
-- SET @Shift_Start = Shift_Start（NOW（））;
select
  @Shift_Start;

/* * Retrieve info to be used elsewhere IN the SPROC */
call GetApprovedWorkcenter(
  pCNC_Approved_Workcenter_Key,
  pTool_Var,
  @Plexus_Customer_No,
  @Workcenter_Key,
  @CNC_Key,
  @Pallets_Per_Tool,
  @Part_Key,
  @Part_Operation_Key,
  @Assembly_Key,
  @Tool_Key,
  @Fastest_Cycle_Time
);

SELECT
  @Plexus_Customer_No,
  @Workcenter_Key,
  @CNC_Key,
  @Pallets_Per_Tool,
  @Part_Key,
  @Part_Operation_Key,
  @Assembly_Key,
  @Tool_Key,
  @Fastest_Cycle_Time;

call GetIssueTypeKeys(
  @Plexus_Customer_No,
  @Counter_Rolled_Back_Key,
  @Network_Error_Key,
  @Shift_Tool_Change_Avoidance_Key,
  @Pallet_Looped_Out_Key
);

SELECT
  @Counter_Rolled_Back_Key,
  @Network_Error_Key,
  @Shift_Tool_Change_Avoidance_Key,
  @Pallet_Looped_Out_Key;

/* * It is possible to have only 1 pallet running a tool IN this case @Other_Pallet_No equals 0 */
SET
  @Other_Pallet_No = CASE
    WHEN (1 = @Pallets_Per_Tool) THEN 0
    WHEN (1 = pPallet_No) THEN 2
    ELSE 1
  END;


SELECT
  pPallet_No,
  @Other_Pallet_No;



/* * Collect the data needed to analyze the input. */
SET
  @Record_Count_Same_Pallet = 0,
  @Record_Count_Any_Pallet = 0,
  @Record_Count_Other_Pallet = 0,
  @Record_Count_From_Shift_Start_Limit_5 = 0,
  @Number_Pallets_Running_Tool = 0,
  @Last_Start_Time_Same_Pallet = NULL,
  @Cycle_Time = 0,
  @Last_Value_Same_Pallet = 0;

call GetAMHInfo(
  @Plexus_Customer_No,
  @Workcenter_Key,
  @CNC_Key,
  @Pallets_Per_Tool,
  pPallet_No,
  @Other_Pallet_No,
  @Part_Key,
  @Part_Operation_Key,
  @Assembly_Key,
  @Tool_Key,
  pStart_Time,
  @Record_Count_Same_Pallet,
  @Record_Count_Any_Pallet,
  @Record_Count_Other_Pallet,
  @Record_Count_From_Shift_Start_Limit_5,
  @Number_Pallets_Running_Tool,
  @Last_Start_Time_Same_Pallet,
  @Cycle_Time,
  @Last_Value_Same_Pallet
);

SELECT
	@Record_Count_Same_Pallet,
	@Record_Count_Any_Pallet,
	@Record_Count_Other_Pallet,
	@Record_Count_From_Shift_Start_Limit_5,
	@Number_Pallets_Running_Tool,
	@Last_Start_Time_Same_Pallet,
	@Cycle_Time,
	@Last_Value_Same_Pallet;

SET
	@Pallet_Looped_Out = 0,@Pallet_Looped_Out_Previously_Detected=0;


IF (
  (@Pallets_Per_Tool > 1)
  AND (0 != @Number_Pallets_Running_Tool)
  AND (
    @Pallets_Per_Tool != @Number_Pallets_Running_Tool
  )
) THEN
SET
  @Pallet_Looped_Out = 1;

 /* Did we already know the pallet is looped out. */
call FindIssue(@Plexus_Customer_No,@Workcenter_Key,@CNC_Key,@Pallet_No,@Part_Key,
@Part_Operation_Key,@Assembly_Key,@Tool_Key,@Start_Time,@Pallet_Looped_Out_Key,@Pallet_Looped_Out_Previously_Detected);

end if;

SELECT
  @Pallet_Looped_Out_Previously_Detected;

IF (0 = @Pallet_Looped_Out_Previously_Detected) THEN
INSERT INTO
  Issue(
    Plexus_Customer_No,
    Issue_Type_Key,
    Workcenter_Key,
    CNC_Key,
    Pallet_No,
    Part_Key,
    Part_Operation_Key,
    Assembly_Key,
    Tool_Key,
    Start_Time,
    Pallet_Looped_Out
  )
VALUES
  (
    @Plexus_Customer_No,
    @Pallet_Looped_Out_Key,
    @Workcenter_Key,
    @CNC_Key,
    pPallet_No,
    @Part_Key,
    @Part_Operation_Key,
    @Assembly_Key,
    @Tool_Key,
    pStart_Time,
    @Other_Pallet_No
  );

END IF;


END
SET
  @shitft_tool_change_avoidance_other_pallet = 0;

-- SELECT  *
FROM
  Issue_Type -- SELECT  *
FROM
  Issue;

SELECT
  COUNT(*) INTO @shitft_tool_change_avoidance_other_pallet
FROM
  issue
WHERE
  plexus_customer_no = @plexus_customer_no
  AND workcenter_key = @workcenter_key
  AND cnc_key = @cnc_key
  AND pallet_no = @other_pallet_no
  AND part_key = @part_key
  AND part_operation_key = @part_operation_key
  AND assembly_key = @assembly_key
  AND tool_key = @tool_key start_time = @last_start_time_other_pallet
  AND issue_type_key = 3;

SET
  @network_error_other_pallet = 0;

SELECT
  COUNT(*) INTO @network_error_other_pallet
FROM
  issue
WHERE
  plexus_customer_no = @plexus_customer_no
  AND workcenter_key = @workcenter_key
  AND cnc_key = @cnc_key
  AND pallet_no = @other_pallet_no
  AND part_key = @part_key
  AND part_operation_key = @part_operation_key
  AND assembly_key = @assembly_key
  AND tool_key = @tool_key start_time = @last_start_time_other_pallet
  AND issue_type_key = 2;

SET
  @increment_by = 0;

SELECT
  -- opl.PCN Plexus_Customer_No cpl.Workcenter_Key cpl.CNC_Key opl.Part_Key cpl.Part_Operation_Key opl.Assembly_Key opl.Tool_Key cpl.increment_by INTO @increment_by
FROM
  part_v_tool_op_part_life opl
  INNER JOIN cnc_tool_op_part_life cpl ON opl.tool_op_part_life_key = cpl.tool_op_part_life_key -- 1 to many
WHERE
  opl.pcn = @plexus_customer_no
  AND cpl.workcenter_key = @workcenter_key
  AND cpl.cnc_key = @cnc_key
  AND opl.part_key = @part_key
  AND cpl.part_operation_key = @part_operation_key
  AND opl.assembly_key = @assembly_key
  AND opl.tool_key = @tool_key;

SELECT
  @increment_by;

make sproc pcn TO RETURN issue TYPE
AND assign TO variable instead OF hard coding
/* * This is meant to identify WHEN there is a network or other failure preventing us
 
 FROM inserting Assembly Machining History records. * It will also detect WHEN the CNC operator or Tool setter are setting counter values ahead possibly to avoid
 HAVING to do a tool * change
 ON there shift. */
SET
  @shift_tool_change_avoidance = 0;

IF (
  (0 = @shift_tool_change_avoidance_other_pallet)
  AND -- DON'T
  INSERT
    IF WE JUST INSERTED ONE ON THE PREVIOUS PALLET (0 != @number_pallets_running_tool)
    AND -- WE NEED @Number_Pallets_Running_Tool IN ORDER TO CALCULATE THE ESTIMATED INCREASE -- BECAUSE WE ARE DOING THE MATH BASED UPON THE CYCLE TIME -- WE MAY NOT CATCH A COUNTER JUMP THAT IS DONE AT THE BEGINNING OF THE SHIFT. (0 != @cycle_time) AND (0 != @fastest_cycle_time) ) THEN
  SET
    @estimated_cycles = @cycle_time / @fastest_cycle_time;

SET
  @estimated_increase = @estimated_cycles * @increment_by * @number_pallets_running_tool;

IF (
  pcurrent_value > (
    @last_value_same_pallet + (5 * @estimated_increase)
  )
) THEN IF (0 = @jump_added) THEN
SET
  @counter_jump = 1;

-- SELECT  *
FROM
  Issue_Type;

INSERT INTO
  ISSUE(
    plexus_customer_no,
    issue_type_key,
    workcenter_key,
    cnc_key,
    pallet_no,
    part_key,
    part_operation_key,
    assembly_key,
    tool_key,
    start_time,
    previous_time,
    cycle_time,
    fastest_cycle_time,
    current_value,
    previous_value
  )
VALUES
  (
    @plexus_customer_no,
    2,
    @workcenter_key,
    @cnc_key,
    ppallet_no,
    @part_key,
    @part_operation_key,
    @assembly_key,
    @tool_key,
    pstart_time,
    @last_start_time_same_pallet,
    @cycle_time,
    @fastest_cycle_time,
    pcurrent_value,
    @last_value_same_pallet
  );

END IF;

END IF;

END IF;

SELECT
  @estimated_cycles,
  @estimated_increase,
  @counter_jump;

-- START HERE /* * Base @Unexpected_Counter_Value
ON this pallet ONLY ? We are sure this pallet IS running * but we are NOT sure the other pallet IS running,
AND we are NOT sure the other pallet * IS running this tool.* /
SET
  @unexpected_counter_value = 0;

IF (
  (0 = @counter_jump)
  AND (0 != @last_value_other_pallet)
) THEN
/* (0 = @Unexpected_Counter_Value_Other_Pallet) AND (0 = @Counter_Jump_Other_Pallet ) AND (0 = @Counter_Jump) AND (0 != @Last_Value_Same_Pallet) AND (0 != @Number_Pallets_Running_Tool)) THEN */
SET
  @unexpected_counter_value = CASE
    WHEN pcurrent_value != (@last_value_other_pallet + @increment_by) THEN 1
    ELSE 0
  END;

IF (1 = @unexpected_counter_value) THEN
INSERT INTO
  ISSUE(
    plexus_customer_no,
    issue_type_key,
    workcenter_key,
    cnc_key,
    pallet_no,
    part_key,
    part_operation_key,
    assembly_key,
    tool_key,
    start_time,
    previous_time,
    cycle_time,
    fastest_cycle_time,
    current_value,
    previous_value
  )
VALUES
  (
    @plexus_customer_no,
    1,
    @workcenter_key,
    @cnc_key,
    ppallet_no,
    @part_key,
    @part_operation_key,
    @assembly_key,
    @tool_key,
    pstart_time,
    @last_start_time_same_pallet,
    @cycle_time,
    @fastest_cycle_time,
    pcurrent_value,
    @last_value_same_pallet
  );

END IF;

END IF;

SELECT
  @unexpected_counter_value;

IF (0 != @cycle_time)
AND (
  (0 = @fastest_cycle_time)
  OR (@cycle_time < @fastest_cycle_time)
) THEN -- SELECT  'Update Fastest_Cycle_Time'; UPDATE cnc_approved_workcenter_v2 caw
SET
  fastest_cycle_time = @cycle_time -- WHERE caw.CNC_Approved_Workcenter_Key=@pCNC_Approved_Workcenter_Key
  -- AND tv.Tool_Var = @pTool_Var;
WHERE
  caw.cnc_approved_workcenter_key = pcnc_approved_workcenter_key;

END IF;

-- This will be inserted WHEN the Tool Assembly time starts
INSERT INTO
  ASSEMBLY_MACHINING_HISTORY_V2(
    plexus_customer_no,
    workcenter_key,
    cnc_key,
    pallet_no,
    part_key,
    part_operation_key,
    assembly_key,
    tool_key,
    current_value,
    running_total,
    running_entire_time,
    increment_by_check,
    zero_detect,
    start_time,
    end_time,
    run_time,
    cycle_time,
    unexpected_counter_value,
    counter_jump,
    pallet_looped_out
  )
  /*
   
   SET @pCNC_Approved_Workcenter_Key = 2;
   SET @pPallet_No = 1;
   SET @pTool_Var = 1;
   SET @pStart_Time = '2020-09-05 09:48:00';
   SET @pEnd_Time = '2020-09-05 09:50:10'; */
SELECT
  @plexus_customer_no,
  @workcenter_key,
  @cnc_key,
  ppallet_no pallet_no,
  @part_key,
  @part_operation_key,
  @assembly_key,
  @tool_key,
  pcurrent_value current_value,
  -- Just changed this 11/14 not tested prunning_total running_total
,
  -- Just changed this 11/14 not tested prunning_entire_time running_entire_time
,
  -- changed this
  ON 12 / 08 pincrement_by_check increment_by_check,
  -- added this
  ON 12 / 08 pzero_detect zero_detect,
  -- added this
  ON 12 / 10 pstart_time start_time,
  pend_time end_time,
  TIMESTAMPDIFF(SECOND, pstart_time, pend_time) run_time,
  @cycle_time cycle_time,
  @unexpected_counter_value unexpected_counter_value,
  @counter_jump counter_jump,
  @pallet_looped_out pallet_looped_out;

SET
  passembly_machining_history_key = (
    SELECT
      assembly_machining_history_key
    FROM
      assembly_machining_history_v2
    WHERE
      assembly_machining_history_key = (
        SELECT
          LAST_INSERT_ID()
      )
  );

SET
  preturnvalue = 0;

END;