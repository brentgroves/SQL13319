use Plex;
select * from Issue_Type;
set @Plexus_Customer_No = 300758;

call GetIssueTypeKeys(@Plexus_Customer_No,@Counter_Rolled_Back,@Network_Error,@Shift_Tool_Change_Avoidance,@Pallet_Looped_Out);
select @Plexus_Customer_No,@Counter_Rolled_Back,@Network_Error,@Shift_Tool_Change_Avoidance,@Pallet_Looped_Out;

-- select @Record_Count_Same_Pallet,@Record_Count_Any_Pallet;

/*
 * Information needed to analyze AssemblyMachineHistory records for issue insertions.
 * Needed since the InsAssemblyMachineHistory SPROC would be extremely large unless divided.
 */
drop procedure GetIssueTypeKeys;
create procedure GetIssueTypeKeys
(
	in pPlexus_Customer_No INT,
	out pCounter_Rolled_Back INT,
	out pNetwork_Error INT,
	out pShift_Tool_Change_Avoidance int,
	out pPallet_Looped_Out int
)
begin

select Issue_Type_Key 
into pCounter_Rolled_Back 
from Issue_Type
where Plexus_Customer_No = pPlexus_Customer_No
and Issue_Type = 'Counter Rolled Back';

select Issue_Type_Key 
into pNetwork_Error 
from Issue_Type
where Plexus_Customer_No = pPlexus_Customer_No
and Issue_Type = 'Network Error';

select Issue_Type_Key 
into pShift_Tool_Change_Avoidance
from Issue_Type
where Plexus_Customer_No = pPlexus_Customer_No
and Issue_Type = 'Shift Tool Change Avoidance';

select Issue_Type_Key 
into pPallet_Looped_Out
from Issue_Type
where Plexus_Customer_No = pPlexus_Customer_No
and Issue_Type = 'Pallet Looped Out';

end

select * from Issue_Type