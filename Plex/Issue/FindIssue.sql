set @Plexus_Customer_No = 300758;
set @Workcenter_Key = 61090;
set @CNC_Key = 3;
set @Pallet_No = 1;
set @Part_Key = 2794706;
set @Part_Operation_Key = 7874404;
set @Assembly_Key = 18;
set @Tool_Key = 19;
set @Start_Time = '2020-12-14 15:25:50'; -- 5 min

call FindIssue(@Plexus_Customer_No,@Workcenter_Key,@CNC_Key,@Pallet_No,@Part_Key,
@Part_Operation_Key,@Assembly_Key,@Tool_Key,@Start_Time,@Issue_Type_Key,@Found);
select @Found;

-- select @Record_Count_Same_Pallet,@Record_Count_Any_Pallet;
/*
 * Information needed to analyze AssemblyMachineHistory records for issue insertions.
 * Needed since the InsAssemblyMachineHistory SPROC would be extremely large unless divided.
 */
DROP PROCEDURE FindIssue;

CREATE PROCEDURE FindIssue (
	IN pPlexus_Customer_No int,
	IN pWorkcenter_Key int,
	IN pCNC_Key int,
	IN pPallet_No int,
	IN pPart_Key int,
	IN pPart_Operation_Key int,
	IN pAssembly_Key int,
	IN pTool_Key int,
	IN pStart_Time datetime,
	IN pIssue_Type_Key int,
	out pFound BIT
) BEGIN
SELECT
	COUNT(*) INTO pFound
FROM
	Issue
WHERE
	Plexus_Customer_No = pPlexus_Customer_No
	AND Workcenter_Key = pWorkcenter_Key
	AND CNC_Key = pCNC_Key
	AND Pallet_No = pPallet_No
	AND Part_Key = pPart_Key
	AND Part_Operation_Key = pPart_Operation_Key
	AND Assembly_Key = pAssembly_Key
	AND Tool_Key = pTool_Key
	AND Start_Time > pStart_Time
	AND Issue_Type_Key = pIssue_Type_Key;

END