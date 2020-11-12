-- drop table Tool_BOM_Alternate_In_Use
-- truncate table Tool_BOM_Alternate_In_Use
CREATE TABLE Tool_BOM_Alternate_In_Use (
	Plexus_Customer_No int,
	Primary_Tool_Key int NOT NULL,  
	Alternate_Tool_Key int NOT NULL, 
	Workcenter_Key int NOT NULL, 
	CNC_Key int NOT NULL, -- Where is it being used 							
	Part_Key int NOT NULL,							
	Part_Operation_Key int NOT NULL,							
	Assembly_Key int NOT NULL,  
	Quantity_In_Use int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Primary_Tool_Key,Workcenter_Key,CNC_Key,Part_Key,Part_Operation_Key,Assembly_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Indicates if an Alternate is currently being used';
insert into Tool_BOM_Alternate_In_Use (Plexus_Customer_No,Primary_Tool_Key,Alternate_Tool_Key,Workcenter_Key,CNC_Key,Part_Key,Part_Operation_Key,Assembly_Key,Quantity_In_Use) 
values
(300758,13,12,61090,3,2794706,7874404,21,1) -- Alternate Tool for T15 is in use;
select * from Tool_BOM_Alternate_In_Use
-- select * from CNC_Approved_Workcenter 
-- select * from CNC 

/*
 * UDP Datagrams sent from Moxa units.
 * Common variables used as counters are identified by an CNC_Approved_Workcenter_Key, Set_No, and Block_No 
 * when sent to the UDP server.  This table helps gather the info needed to fill out the Tool_Life record and
 * to update the Tool_Op_Part_Life_CNC record with the running total.
 */
-- UPDATE ASSEMBLY KEY AFTER TOOLING UPLOAD
-- drop table Datagram_Set_Block
-- truncate table Datagram_Set_Block 
CREATE TABLE Datagram_Set_Block (
	Datagram_Set_Block_Key int NOT NULL, -- Not the primary key but is used for easy access to individual records.
	Plexus_Customer_No int,
	Workcenter_Key int,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL, -- Since plex tool_life table uses part_operation_key i will also.  there could be multiple part_operation_keys for a part_key,operation_key pair. i.e rework operations
	Part_Operation_Key int NOT NULL, -- Since plex tool_life table uses part_operation_key i will also.  there could be multiple part_operation_keys for a part_key,operation_key pair.
	Operation_Key int NOT NULL,  -- The Part_Operation_Key is needed for the Tool_Life record but Operation_Key is needed for the CNC_Tool_Op_Part_Life record update so make them both easily accessible to the SPROCs.
	Set_No int NOT NULL,  -- Can't avoid this Set_No because of the way the Moxa receives messages from the Okuma's serial port.
	Block_No int NOT NULL,  -- This is just an index to identify which 10-byte block in a datagram set. 
	-- We could just output the Assembly_Key and the Tool_Key and not bother with the Set_No and Block_No. But this way seems easier to 
	-- follow in OCOM0.SSB and plus we could do some mapping at the database level which would give us more flexibility if changes need to be made.
	Assembly_Key int NOT NULL, -- foreign key
	Tool_Key int NOT NULL, -- foreign key  -- This is the primary tool key if there are alternates.
	-- We could update the Tool_Key directly when a tool setter informs the program an alternate is in use.
	-- but we are currently inserting a record into an Alternate_In_Use table instead.  Don't know which way is better.
	-- but it seems better to be able rely on this being the primary_Key for validating the CNC_Approved_Workcenter mapping.
  	PRIMARY KEY (Plexus_Customer_No,Workcenter_Key,CNC_Key,Part_Key,Part_Operation_Key,Operation_Key,Set_No,Block_No)  -- This must be a unique combination.
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='UDP Datagrams sent from Moxa units';
insert into Datagram_Set_Block (Datagram_Set_Block_Key,Plexus_Customer_No,Workcenter_Key,CNC_Key,Part_Key,Part_Operation_Key,Operation_Key,Set_No,Block_No,Assembly_Key,Tool_Key)
values
-- select * from Part_v_Operation
-- Avilla
(1,310507,61324,1,2809196,7917723,56400,1,1,1,29),  -- T10,16680
(2,310507,61324,1,2809196,7917723,56400,1,2,2,30),  -- T11,12623
-- select awc.*,po.Operation_Key from CNC_Approved_Workcenter awc inner join Part_v_Part_Operation po on awc.Part_Operation_Key=po.Part_Operation_Key
(3,310507,61324,1,2809196,7917723,56400,1,3,3,21),  -- VC1,008431,Insert,TCGT 32.52 FL K10, for 85.24MM ROUGH BORE 
(4,310507,61324,1,2809196,7917723,56400,1,4,3,34),  -- VC21,16410,Boring Bar,CCC-32505-100, for 85.24MM ROUGH BORE

(5,310507,61324,1,2809196,7917723,56400,1,5,4,31),  -- T12,16409
(6,310507,61324,1,2809196,7917723,56400,1,6,5,22),  -- T2,007221
(7,310507,61324,1,2809196,7917723,56400,1,7,6,32),  -- T13,16407

(8,310507,61324,1,2809196,7917723,56400,1,8,7,24),  -- VC4,16406,HH-32503-21-AL, helmet heat insert,drill tip, for 21mm drill
(9,310507,61324,1,2809196,7917723,56400,1,9,7,23),  -- VC44,16405,CCC-32503-010/PCD,spotface insert for 21mm drill

(10,310507,61324,1,2809196,7917723,56400,2,1,8,25),  -- T5,16461
(11,310507,61324,1,2809196,7917723,56400,2,2,9,33),  -- T16,16408
(12,310507,61324,1,2809196,7917723,56400,2,3,10,26), -- T7,16110
(13,310507,61324,1,2809196,7917723,56400,2,4,11,27), -- T8,16111
(14,310507,61324,1,2809196,7917723,56400,2,5,12,28),  -- T9,16130
-- select b.Assembly_Key,t.* from Part_v_Tool_BOM b inner join Part_v_Tool t on b.Tool_Key=t.Tool_Key where Tool_No = '008435'
-- Albion
-- P558 LH Knuckles
 (20,300758,61090,3,2794706,7874404,51168,1,1,13,1),  -- T1,009196
 (21,300758,61090,3,2794706,7874404,51168,1,2,14,14), -- T21,17022
 (22,300758,61090,3,2794706,7874404,51168,1,3,15,15),  -- T22,14710 
 (23,300758,61090,3,2794706,7874404,51168,1,4,16,16),  -- T23,0000951
 (24,300758,61090,3,2794706,7874404,51168,1,5,17,20),  -- T72,14855
 (25,300758,61090,3,2794706,7874404,51168,1,6,18,19),  -- VC33,15843,CCMT 432MT TT7015 INSERT
 (26,300758,61090,3,2794706,7874404,51168,1,7,18,18),  -- VC34,010559,CCMT 32.52 -M3 TK1501,different tool lifes. Not an alternate of VC33. tHIS IS VC34
 (27,300758,61090,3,2794706,7874404,51168,1,8,19,17),  -- T30,16547
 (28,300758,61090,3,2794706,7874404,51168,1,9,20,2),   -- T4,17100
-- 100 bytes
 (29,300758,61090,3,2794706,7874404,51168,2,1,21,13),  -- T15,13753
 (30,300758,61090,3,2794706,7874404,51168,2,2,22,6),  -- T7,008485
 (31,300758,61090,3,2794706,7874404,51168,2,3,23,3),  -- VC6,009240,SHLT110408N-PH1 IN2005,DATUM L ROUGH BORE & C'BORE 
 (32,300758,61090,3,2794706,7874404,51168,2,4,23,5),  -- VC66,008318,SHLT140516N-FS IN1030 INSERT,Alternate=15721,DATUM L ROUGH BORE & C'BORE
 (33,300758,61090,3,2794706,7874404,51168,2,5,24,7),  -- T9,007864
-- 160 bytes now start over
 (34,300758,61090,3,2794706,7874404,51168,3,1,25,7),  -- T8,007864
 (35,300758,61090,3,2794706,7874404,51168,3,2,26,8),  -- T12,010338,'CCC-23575 REV A'
 (36,300758,61090,3,2794706,7874404,51168,3,3,27,10),  -- T13,0003396
 (37,300758,61090,3,2794706,7874404,51168,3,4,28,11)  -- T14,008435
-- 60/100 bytes
select * from Datagram_Set_Block  -- 32 records


/*
 * Not a Plex table.
 * Assign a regrind-able tool to a CNC. When a tool setter loads a regrind-able tool into a CNC
 * he accesses a Mach2 or Moto screen to map the tool to a CNC.
 * Since the program will know the tool_key being used by the assembly it will not be necessary
 * to add an alternate in use record for regrind-able tools.
 */
-- drop table Tool_Inventory_In_Use
CREATE TABLE Tool_Inventory_In_Use 
(
	Plexus_Customer_No int,
	Tool_Serial_Key int,
	Primary_Tool_Key int,
	Tool_Key int,
	Workcenter_Key	int NOT NULL,  
	CNC_Key int NOT NULL, 							
	Part_Key int NOT NULL,							
	Part_Operation_Key int NOT NULL,							
	Assembly_Key int NOT NULL,  
  	PRIMARY KEY (Plexus_Customer_No,Tool_Serial_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Maps a regrind-able tool to a CNC assembly';
insert into Tool_Inventory_In_Use (Plexus_Customer_No,Tool_Serial_Key,Primary_Tool_Key,Tool_Key,Workcenter_Key,CNC_Key,Part_Key,Part_Operation_Key,Assembly_Key)
values
-- Albion
-- P558 LH Knuckles, CNC120
(300758,1,2,2,61090,3,2794706,7874404,20),-- T04
(300758,3,8,9,61090,3,2794706,7874404,26),-- This is an alternate tool for T12
(300758,4,15,15,61090,3,2794706,7874404,15), -- T22
(300758,5,20,20,61090,3,2794706,7874404,17) -- T72
select * from Tool_Inventory_In_Use 

/*
 * subset of Plex Tool_Life table
 * This is a tool life history table
 */
-- drop table Part_v_Tool_Life
-- truncate table Part_v_Tool_Life
CREATE TABLE Part_v_Tool_Life 
(
	Tool_Life_Key int NOT NULL AUTO_INCREMENT,  -- not a PLEX COLUMN
	PCN int NOT NULL,
	Tool_Key int NOT NULL,	
	Tool_Serial_Key int,  -- Optional, ADDED: Plex Part_v_Tool_Inventory column.
	Workcenter_Key	int NOT NULL,  -- This will allow us to group all CNC in a work area.  Technically not needed but it is a Plex column.
	CNC_Key int NOT NULL, -- needed because our Workcenters have multiple CNC. NOT A PLEX COLUMN.							
	Part_Key int NOT NULL,							
	Part_Operation_Key int NOT NULL,							
	Assembly_Key int NOT NULL,  -- NOT A PLEX COLUMN
	Regrind_Count int,	-- The number of times the tool has been reground.  NOT A PLEX COLUMN.
	Run_Quantity int NOT NULL,	-- Actual tool life for tool set if this is .					
	Run_Date datetime NOT NULL,	-- Start date. Record created at time of tool change of previous tool set.				
  	PRIMARY KEY (Tool_Life_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Subset of plex part_v_tool_life table';
select * from Part_v_Tool_Life 


-- truncate table Tool_Assembly_Change_History
set @CNC_Approved_Workcenter_Key = 3;
set @Set_No = 1;
set @Block_No = 1;
set @Run_Quantity = 100;
set @Run_Date = '2020-09-05 09:50:00';
set @Tool_No = 1;

CALL InsToolLifeHistory(@CNC_Approved_Workcenter_Key,@Set_No,@Block_No,@Run_Quantity,@Run_Date,@Tool_Life_Key,@Return_Value);
SELECT @Tool_Life_Key,@Return_Value;
select * from Part_v_Tool_Life
select * from CNC_Tool_Op_Part_Life
select * from CNC_Approved_Workcenter
/*
 * The only information we get from the CNC is a CNC_Approved_Workcenter_Key,Set_No, and Block_No,
 * so we have to use this info to link to get enough info to insert records into the Part_v_Tool_Life table
 * and to update the current_value and Last_Update column of Tool_Op_Part_Life_CNC.
 * The tool setter will have updated PlexX with the CNC,part,operation,assembly_no, and serial number of the
 * currently running tool.
 *
 */
-- drop procedure InsToolLifeHistory;
CREATE PROCEDURE InsToolLifeHistory(
	IN pCNC_Approved_Workcenter_Key INT,  
	IN pSet_No INT,
	IN pBlock_No INT,
	IN pRun_Quantity INT,
  	IN pRun_Date datetime,
  	OUT pTool_Life_Key INT,
	OUT pReturnValue INT 
)
BEGIN
/*
set @CNC_Approved_Workcenter_Key = 2;
set @Set_No = 1;
set @Block_No = 1;
set @Run_Date = '2020-09-05 09:50:00';
set @Run_Quantity = 100;
*/
-- START HERE
-- VERIFY WE CAN GET ENOUGH INFO TO UPDATE THE Tool_Life record including the serial_key for regrinds and the alternate tool key for alts.
-- VERIFY WE CAN GET ENOUGH INFO TO UPDATE THE CNC_Tool_Op_Part_Life record with the current running total and last update columns.
-- Insert a Tool_Life record with these values
insert into Part_v_Tool_Life (PCN,Tool_Key,Tool_Serial_Key,Workcenter_Key,CNC_Key,Part_Key,Part_Operation_Key,Assembly_Key,Regrind_Count,Run_Quantity,Run_Date)
select 
caw.Plexus_Customer_No PCN,
-- bl.Tool_Key bl_Tool_Key,
case 
when riu.Tool_Key is not NULL then riu.Tool_Key 
when iu.Alternate_Tool_Key is not NULL then iu.Alternate_Tool_Key 
else bl.Tool_Key
end Tool_Key,

-- riu.Tool_Key,
riu.Tool_Serial_Key,
caw.Workcenter_Key,
caw.CNC_Key,
caw.Part_Key,
caw.Part_Operation_Key, 
bl.Assembly_Key, 
ti.Regrind_Count,
pRun_Quantity,
pRun_Date
-- ti.Tool_Serial_Key, 
-- bl.Tool_Key primary_tool_key,
-- iu.Alternate_Tool_Key,
-- riu.Primary_Tool_Key,
-- select * from CNC_Approved_Workcenter
-- select * from Datagram_Set_Block
-- select bl.*
from CNC_Approved_Workcenter caw -- list all of the CNC / part_operation possibilites
inner join Datagram_Set_Block bl -- All of the primary tooling for each assembly for each part_operation
-- using the CNC_Approved_Workcenter_Key and the set and block number passed by the CNC
-- we can get the tool_key,assembly_key, and part operation.
on caw.Plexus_Customer_No=bl.Plexus_Customer_No
and caw.Workcenter_Key = bl.Workcenter_Key 
and caw.CNC_Key = bl.CNC_Key 
and caw.Part_Key = caw.Part_Key -- Don't know if both of these keys will ever be necessary but Plex uses them both
and caw.Part_Operation_Key = bl.Part_Operation_Key -- 1 to many  --32 recs
/*
inner join Part_v_Tool_BOM tb -- Get the primary tools only
on bl.Plexus_Customer_No = tb.Plexus_Customer_No
and bl.Assembly_Key = tb.Assembly_Key
and bl.Tool_Key = tb.Tool_Key  -- 1 to 1, This will give us the link to the alt table then the alt_in_use table.
*/ 
left outer join Tool_BOM_Alternate_In_Use iu -- An alt that is currently in the CNC
on bl.Plexus_Customer_No=iu.Plexus_Customer_No
and bl.Tool_Key = iu.Primary_Tool_Key -- The Datagram_Set_Block always contains the primay tool key.
and bl.Workcenter_Key = iu.Workcenter_Key
and bl.CNC_Key = iu.CNC_Key
and bl.Part_Key = iu.Part_Key -- Don't know if both the Part and Part_Operation keys will ever be necessary but Plex uses them both
and bl.Part_Operation_Key = iu.Part_Operation_Key
and bl.Assembly_Key = iu.Assembly_Key  -- 32 recs
-- select * from Tool_Op_Part_Life_CNC_Set_Block
-- select * from Tool_BOM_Alternate_In_Use
left outer join Tool_Inventory_In_Use riu 
on bl.Plexus_Customer_No=riu.Plexus_Customer_No
and bl.Tool_Key = riu.Primary_Tool_Key 
and bl.Workcenter_Key = riu.Workcenter_Key 
and bl.CNC_Key = riu.CNC_Key
and bl.Part_Key = riu.Part_Key -- Don't know if both the Part and Part_Operation keys will ever be necessary but Plex uses them both
and bl.Part_Operation_Key = riu.Part_Operation_Key
and bl.Assembly_Key = riu.Assembly_Key
left outer join Part_v_Tool_Inventory ti 
on riu.Tool_Serial_Key = ti.Tool_Serial_Key -- 1 to 1
-- order by caw.CNC_Key,bl.Assembly_Key,bl.Tool_Key 
where caw.CNC_Approved_Workcenter_Key = pCNC_Approved_Workcenter_Key
and bl.Set_No = pSet_No 
and bl.Block_No = pBlock_No;

-- Display the last inserted row.
set pTool_Life_Key = (select Tool_Life_Key from Part_v_Tool_Life where Tool_Life_Key =(SELECT LAST_INSERT_ID()));
-- select pTool_Assembly_Change_History_Key;
-- SET @total_tax = (SELECT SUM(tax) FROM taxable_transactions);
set pReturnValue = 0;
END;

set @CNC_Approved_Workcenter_Key = 3;
set @Set_No = 1;
set @Block_No = 1;
set @Run_Quantity = 100;
set @Run_Date = '2020-09-05 09:50:00';
set @Tool_No = 1;

CALL InsToolLifeHistory(@CNC_Approved_Workcenter_Key,@Set_No,@Block_No,@Run_Quantity,@Run_Date,@Tool_Life_Key,@Return_Value);
SELECT @Tool_Life_Key,@Return_Value;



