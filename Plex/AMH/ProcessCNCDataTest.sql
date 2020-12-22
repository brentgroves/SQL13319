

-- select * from Assembly_Machining_History_V2
 SET
@CNC_Approved_Workcenter_Key = 2;

SET
    @Tool_Var = 33;

SET
    @Running_Entire_Time = 1;

SET
    @Increment_By_Check = 0;

SET
    @Zero_Detect = 0;

SET
    @Pallet_No = 1;

SET
    @Current_Value = 14;

SET
    @Running_Total = 14;

SET
    @Start_Time = '2020-12-14 14:50:50';

SET
    @End_Time = '2020-12-14 14:51:50';

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
 CALL ProcessCNCData( 
 @CNC_Approved_Workcenter_Key,
@Pallet_No,
@Tool_Var,
@Current_Value,
@Running_Total,
@Running_Entire_Time,
@Increment_By_Check,
@Zero_Detect,
@Start_Time,
@End_Time,
@Assembly_Machining_History_Key,
@Return_Value );