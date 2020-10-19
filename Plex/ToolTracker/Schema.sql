-- drop table Plexus_Control_v_Customer_Group_Member
CREATE TABLE Plexus_Control_v_Customer_Group_Member
(
	Plexus_Customer_No int NOT NULL,
	Plexus_Customer_Code varchar(50) NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Subset of Plexus_Control_v_Customer_Group_Member.';
insert into Plexus_Control_v_Customer_Group_Member(Plexus_Customer_No,Plexus_Customer_Code)
values
(300758,'Mobex Global Albion'),
(310507,'Mobex Global Avilla')
select * from Plexus_Control_v_Customer_Group_Member

/*
 * Not in Plex.
 * Tool list to Plex mapping
 */
-- truncate table TL_Plex_PN_Op_Map
-- drop table TL_Plex_PN_Op_Map
CREATE TABLE TL_Plex_PN_Op_Map (
	Plexus_Customer_No int NOT NULL,
	ProcessID int NOT NULL,
	TL_Part_No	varchar (100), 
	Plex_Part_No varchar(100) NOT NULL,
	Revision varchar(8) NOT NULL,
	Operation_Code	varchar (30) NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,ProcessID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tool list to Plex mapping';
insert into TL_Plex_PN_Op_Map (Plexus_Customer_No,ProcessID,TL_Part_No,Plex_Part_No,Revision,Operation_Code)
values 
(300758,61748,'10103355','10103355','A','Machine A - WIP'),
(310507,61442,'51393-TJB-A040-M1','51393TJB A040M1','40-M1-','Final');         
select * from TL_Plex_PN_Op_Map

-- truncate table Common_v_Building
-- drop table Common_v_Building; 
CREATE TABLE Common_v_Building (
  Plexus_Customer_No int NOT NULL,
  Building_Key int NOT NULL,
  Building_Code varchar(50) DEFAULT NULL,
  Name varchar(100) DEFAULT NULL,
  Building_No int NOT NULL,  -- Not in Plex
  PRIMARY KEY (Plexus_Customer_No,Building_Key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Subset of Plex Common_v_Building view.';
insert into Common_v_Building (Plexus_Customer_No,Building_Key,Building_Code,Name,Building_No)
values
-- Albion
(300758,5641,'Mobex Global Plant 8','Mobex Global Albion - Plant 8',8),
(300758,5644,'Mobex Global Plant 6','Mobex Global Albion - Plant 6',6),
-- Avilla
(310507,5680,'Mobex Global Avilla','Mobex Global Avilla - Plant 11',11)
select * from Common_v_Building 

/*
 * Subset of Plex part_v_workcenter view.  Plex has multiple CNC assigned to a workcenter.
 * 
 */
-- drop table Part_v_Workcenter
-- truncate table Part_v_Workcenter
CREATE TABLE Part_v_Workcenter (
	Plexus_Customer_No int NOT NULL,
  	Workcenter_Key int NOT NULL,
  	Building_Key int NOT NULL,  -- This is a null value in Plex for 17 Avilla workcenters so added what it should be
  	Workcenter_Code varchar(50) NOT NULL,  
  	Name varchar (100),
  	PRIMARY KEY (Plexus_Customer_No,Workcenter_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Subset of Plex Part_v_Workcenter view.';
insert into Part_v_Workcenter (Plexus_Customer_No,Workcenter_Key,Building_Key,Workcenter_Code,Name)
values
-- Albion
(300758,61090,5644,'CNC 120 LH 6K Knuckle','P558 LH 6K Knuckle'),
-- Avilla
(310507,61324,5680,'CNC103','Honda RDX RH'), 
(310507,61314,5680,'Honda Civic CNC 359 362','Honda Civic Knuckle LH') 
select * from Part_v_Workcenter 

/*
 * Not in Plex
 * CNC info, don't want to have a varchar primary_key
 */
-- drop table CNC 
CREATE TABLE CNC (
	Plexus_Customer_No int NOT NULL,
	CNC_Key int NOT NULL,
	CNC_TYPE_Key int NOT NULL, -- foreign key
  	Building_Key int NOT NULL, -- foreign key
	CNC_Code varchar(10) NOT NULL,
	Serial_Port bit(1) NOT NULL,
	Networked bit(1) NOT NULL, 
  	PRIMARY KEY (CNC_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC info';
insert into CNC (Plexus_Customer_No,CNC_Key,CNC_Type_Key,Building_Key,CNC_Code,Serial_Port,Networked)
values
-- Albion
(300758,3,1,5644,'120',true,false),
-- Avilla
(310507,1,1,5680,'103',true,false),
(310507,2,2,5680,'362',false,true)
select * from CNC

-- drop table CNC_Type 
CREATE TABLE CNC_Type (
	Plexus_Customer_No int NOT NULL,
	CNC_Type_Key int NOT NULL,
	CNC_Type_Code varchar(50) NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,CNC_Type_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC types such as Makino, Okuma, Welles, etc.';
insert into CNC_Type (Plexus_Customer_No,CNC_Type_key,CNC_Type_Code)
values
(300758,1,'Okuma'),
(300758,2,'Makino'),
(310507,1,'Okuma'),
(310507,2,'Makino')
select * from CNC_Type

/*
 * Subset of Part_v_Approved_Workcenter
 * Note: Part operation to workcenter mapping
 */
-- drop table Part_v_Approved_Workcenter
-- truncate table Part_v_Approved_Workcenter
CREATE TABLE Part_v_Approved_Workcenter (
	Plexus_Customer_No int NOT NULL,
  	Part_Key int NOT NULL,
  	Part_Operation_Key int NOT NULL,
  	Workcenter_Key int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Part_Key,Part_Operation_Key,Workcenter_Key)  -- This combination must be unique
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Subset of Part_v_Approved_Workcenter.';
insert into Part_v_Approved_Workcenter (Plexus_Customer_No,Part_Key,Part_Operation_Key,Workcenter_Key)
values
-- Albion
(300758,2794706,7874404,61090), -- Kunckles 6K LH
-- Avilla
(310507,2809196,7917723,61324)  -- RDX AVILLA
select * from Part_v_Approved_Workcenter

/*
 * Plex extension table.
 * The CNC_Approved_Workcenter is used to get the key values needed to update the 
 * tool life table records.  
 * There can be many part_operation records for a single part,operation ie. rework part_operation,
 * and we need to know which part_operation is running on the CNC when inserting Tool_Life records
 * ApprovedWorkcenter and Tool_Life both contain both 
 * the Part_Key and a Part_Operation_Key.  It seems to me that you would not need the
 * Part_Key if you know the Part_Operation_Key but there may be some reason for having 
 * both readily available; maybe a SPROC that needed the Part_Key and did not link
 * to the Part_Operation table to find it.  Or maybe it is to maintain legacy code
 * that did not use a operation key.  I'm just going to add it to be safe.
 */
-- drop table CNC_Approved_Workcenter
-- truncate table CNC_Approved_Workcenter
CREATE TABLE CNC_Approved_Workcenter (
-- This key is very important because it is contained in the OCOM0.SSB code so we can identify 
-- the Workcenter,CNC,Part,Part_Operation that an incoming datagram pertains to without passing all of the keys individually.
	CNC_Approved_Workcenter_Key int NOT NULL,  -- Must be unique but is not the primary key.
	Plexus_Customer_No int NOT NULL,  -- Since we don't have a unique Approved_Workcenter_Key in Plex and we don't
	-- want to modify any Plex tables we will duplicate the Part_Key,Part_Operation_Key, and Workcenter_Key in both tables.
  	Part_Key int NOT NULL,
  	Part_Operation_Key int NOT NULL,
  	Workcenter_Key int NOT NULL,
	CNC_Key int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Part_Key,Part_Operation_Key,Workcenter_Key,CNC_Key)  -- this must be unique
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Links CNC to a part operation';
insert into CNC_Approved_Workcenter (CNC_Approved_Workcenter_Key,Plexus_Customer_No,Part_Key,Part_Operation_Key,Workcenter_Key,CNC_Key)
values
-- Albion
(2,300758,2794706,7874404,61090,3), -- Kunckles 6K LH
-- Avilla
(3,310507,2809196,7917723,61324,1)  -- RDX AVILLA
select * from CNC_Approved_Workcenter

/*
 * Corresponds to Plex part_v_part
 */
-- drop table Part_Plx
-- truncate table Part_Plx
CREATE TABLE Part_v_Part (
	Plexus_Customer_No int NOT NULL,
	Part_Key int NOT NULL,
	Part_No	varchar (100),
	Revision varchar (8),  -- May not be a good idea to collect revision info.
	Name varchar (100),
	Part_Type varchar (50),
	PRIMARY KEY (Plexus_Customer_No,Part_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_part view';
insert into Part_v_Part (Plexus_Customer_No,Part_Key,Part_No,Revision,Name,Part_Type)
values
-- Albion
(300758,2794706,'10103355','A','P558 6K Knuckle Left Hand','Knuckle'),
-- Avilla
(310507,2809196,'51393TJB A040M1','40-M1-','RDX Right Hand','Bracket'); 
-- select * from Part_v_Part where Part_Key = 2809196

-- drop table Part_v_Operation
-- truncate table Part_v_Operation
CREATE TABLE Part_v_Operation (
	Plexus_Customer_No int NOT NULL,
	Operation_Key	int NOT NULL,
	Operation_Code	varchar (30),
	PRIMARY KEY (Plexus_Customer_No,Operation_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_operation';
insert into Part_v_Operation (Plexus_Customer_No,Operation_Key,Operation_Code)
values
-- Albion
(300758,51168,'Machine A - WIP'),
-- Avilla
(310507,56400,'Final');
select * from Part_v_Operation

/*
 * This table records valid part and operation combinations.
 * There are many part operations in the process routing table.
 */
-- drop table Part_v_Part_Operation
-- truncate table Part_v_Part_Operation
CREATE TABLE Part_v_Part_Operation (
	Plexus_Customer_No int NOT NULL,
	Part_Operation_Key	int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	PRIMARY KEY (Plexus_Customer_No,Part_Operation_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_part_operation';
insert into Part_v_Part_Operation (Plexus_Customer_No,Part_Operation_Key,Part_Key,Operation_Key)
values
-- Albion
(300758,7874404,2794706,51168),  -- LH Knuckles, CNC120, Machine A -WIP,  Operation 10 in Tool List.
-- Avilla
(310507,7917723,2809196,56400);  -- RDX AVILLA
select * from Part_v_Part_Operation

/*
 */
-- drop table Part_v_Tool_Assembly
-- truncate table Part_v_Tool_Assembly
CREATE TABLE Part_v_Tool_Assembly (
	Plexus_Customer_No int NOT NULL,
	Assembly_Key int NOT NULL, 
	Assembly_No	varchar (50) NOT NULL,
	Description	varchar (100) NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Assembly_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Assembly';
insert into Part_v_Tool_Assembly (Plexus_Customer_No,Assembly_Key,Assembly_No,Description)
values
-- Avilla
-- RDX, cnc 103
(310507,1,'T10','86.925MM FINISH BORE'),
(310507,2,'T11','ETCHER'),
(310507,3,'T01','85.24MM ROUGH BORE'),
(310507,4,'T12','86.125MM PRE FINISH BORE'),
(310507,5,'T02','1.25" HELICAL MILL'),
(310507,6,'T13','180MM BACK CUTTER RH PART ONLY'),
(310507,7,'T04','21MM DRILL/SPOTFACE'),
(310507,8,'T05','10MM END MILL'),
(310507,9,'T16','135MM BACK CUTTER RH ONLY'),
(310507,10,'T07','8.2MM DRILL'),
(310507,11,'T08','14.3MM DRILL/CHAMFER'),
(310507,12,'T09','15.5MM DRILL/CHAMFER'),

-- Albion
-- P558 LH Knuckles
(300758,13,'T01','3IN FACE MILL'),
(300758,14,'T21','2.5IN FACE MILL'),
(300758,15,'T22','M6 DRILL'),
(300758,16,'T23','M6 X 1.0 TAP'),
(300758,17,'T72','DRILL FACE HOLES'),
(300758,18,'T33','ROUGH MULTI BORE'),
(300758,19,'T30','FINISH CENTER BORE'),
(300758,20,'T4','FACE & DRILL CALIPER HOLES'),
(300758,21,'T15','1.937 ROUGH DRILL J BORE'),
(300758,22,'T7','DATUM J BACK FACE'),
(300758,23,'T6','DATUM L ROUGH BORE'),
(300758,24,'T9','FINISH DATUM L'),
(300758,25,'T8','FINISH DATUM J'),
(300758,26,'T12','TAPER REAM ONE SIDE'),
(300758,27,'T13','MILL PADS AND STOP'),
(300758,28,'T14','CHAMFER HOLES');
select * from Part_v_Tool_Assembly where Assembly_Key > 12

/*
 * This corresponds to a Plex tool_type table for Albion.
 * We need it so that we can have a good description of the tools in the BOM.
 */
-- drop table Part_v_Tool_Type
-- truncate table Part_v_Tool_Type
CREATE TABLE Part_v_Tool_Type (
	Plexus_Customer_No int NOT NULL,
	Tool_Type_Key int,
	Tool_Type_Code	varchar (20),
  	PRIMARY KEY (Plexus_Customer_No,Tool_Type_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Type';
insert into Part_v_Tool_Type (Plexus_Customer_No,Tool_Type_Key,Tool_Type_Code)
values
-- Albion 
(300758,30016,'Drill'),
(300758,30048,'Insert'),
(300758,30800,'Reamer'), 
(300758,30801,'Tap'),
-- Avilla
(310507,25115,'Insert'),
(310507,25116,'End Mill'),
(310507,25118,'Drill'),
(310507,30740,'Boring Bar'),
(310507,30758,'Disc Mill'),
(310507,30760,'Drill Tip'),
(310507,30762,'Engraving');
select * from Part_v_Tool_Type


/*
 * This corresponds to a Plex Tool_Group table.
 * This table does not currently contain usefull info.
 * It can be used to distinguished between tools that are used on a Mill or Lathe.
 * Should we use it to distinguish between regrind-able and non-regrind-able tools?  NO, use Part_v_Tool.standard_reworks
 */
-- drop table Part_v_Tool_Group
-- truncate table Part_v_Tool_Group
CREATE TABLE Part_v_Tool_Group (
	Plexus_Customer_No int NOT NULL,
	Tool_Group_Key int,
	Description	varchar (50),
	Tool_Group_Code	varchar (5),
  	PRIMARY KEY (Tool_Group_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Group';
insert into Part_v_Tool_Group (Plexus_Customer_No,Tool_Group_Key,Description,Tool_Group_Code)
values
-- Albion
(300758,3570,'Mill','Mill'),
-- Avilla
(310507,3571,'Mill','Mill');
select * from Part_v_Tool_Group 

/*
 * 
 */
-- select * from Part_v_Tool
-- drop table Part_v_Tool
-- truncate table Part_v_Tool
CREATE TABLE Part_v_Tool (
	Plexus_Customer_No int NOT NULL,
	Tool_Key int,
	Tool_No	varchar (50),
	Tool_Type_Key	int,
	-- Tool_Group_Key	int,  -- Not very useful information at this time.  Should we use it to distinguish between regrind-able and non-regrind-able tools
	Description	varchar (50),
	Perishable	bit, -- Maps to Busche Tool List consumable column
	Standard_Reworks int,  -- Expected number of regrinds. Although this number may vary for different part operations. 
	Price	decimal (18,4),
  	PRIMARY KEY (Plexus_Customer_No,Tool_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool';
insert into Part_v_Tool (Plexus_Customer_No,Tool_Key,Tool_No,Tool_Type_Key,Description,Perishable,Standard_Reworks,Price)  
values
-- Avilla
(310507,21,'008431',25115,'TCGT 32.52 FL K10',1,0,6.690000),  -- insert
(310507,22,'007221',25115,'XOEX120408FR-E06 H15',1,0,10.310000),  -- insert
(310507,23,'16405',25115,'CCC-32503-010/PCD',1,0,92.000000),   -- vc44, spot face insert for 21 mm drill
(310507,24,'16406',30760,'HH-32503-21-AL',1,0,79.000000),   -- VC4, Drill tip for 21 mm drill
(310507,25,'16461',25116,'A345M-100-D2-S.0-Z3',1,0,33.700000),  --
(310507,26,'16110',25116,'CCC-30083 REV 1',1,0,101.000000),  --
(310507,27,'16111',25118,'CCC-30082',1,0,163.1600000),  --
(310507,28,'16130',25118,'CCC-30081',1,0,163.1600000),  --
(310507,29,'16680',30740,'CCC-33146',1,0,103.000000),  -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $103.
(310507,30,'12623',30762,'C-1875-2.0-60-.020-G',1,0,14.980000),  --
(310507,31,'16409',30740,'CCC-32506-100',1,0,103.000000),  -- -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $103.
(310507,32,'16407',30758,'CCC-32508-100',1,0,200.000000),   -- -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $200.
(310507,33,'16408',30758,'CCC-32507-100',1,0,1320.000000),  
(310507,34,'16410',30740,'CCC-32505-100',1,0,525.000000),  -- insert
-- Albion
(300758,1,'009196',30048,'ONMU 090520ANTN-M15 MK2050',1,0,14.380000),  -- insert
(300758,2,'17100',30016,'CCC-34231',1,1,276.000000),  -- drill
(300758,3,'009240',30048,'SHLT110408N-PH1 IN2005',1,0,8.780000), -- 
(300758,4,'15721',30048,'SHLT140516N-FS IN2005',1,0,12.570000), -- Shown as an alternate in the Tool List for 008318
(300758,5,'008318',30048,'SHLT140516N-FS IN1030',1,0,10.950000), -- Shown as replacing 15721 in Plex 
(300758,6,'008485',30048,'CDE323L022 IN2530',1,0,9.820000),  -- insert 
(300758,7,'007864',30048,'TCMT 21.51-F1 TP1501',1,0,5.950000),  -- insert 
(300758,8,'010338',30800,'CCC-23575 REV A',1,1,456.00000),  -- Reamer 
(300758,9,'008410',30800,'CCC-21216 REV B',1,1,198.000000),  -- Reamer. -- Alternate in P558 Knuckles LH 
(300758,10,'0003396',30048,'APFT1604PDTL-D15 MP1500 Insert',1,0,9.810000),  -- insert
(300758,11,'008435',30048,'TCMT 110202 LC225T',1,0,10.370000),  -- insert
(300758,12,'009155',30048,'SPLT140512N-PH IN2005',1,0,9.980000),  -- insert  -- Alternate in P558 Knuckles LH
(300758,13,'13753',30048,'WDXT 156012-H ACK300',1,0,6.952000),  -- insert
(300758,14,'17022',30048,'SNMX1407ZNTR-M16 MK2050',1,0,12.510000),  -- insert
(300758,15,'14710',30016,'CCC-27629 REV 0',1,1,93.000000),  -- drill
(300758,16,'0000951',30801,'23910-05',1,0,32.350000),  -- Tap
(300758,17,'16547',30048,'CCMT21.52MK MC5015',1,0,6.640000),  -- insert
(300758,18,'010559',30048,'CCMT 32.52 -M3 TK1501',1,0,6.030000),  -- VC34, CCMT 32.52 -M3 TK1501,COMBO ROUGH BORE-P558
(300758,19,'15843',30048,'CCMT 432MT TT7015 INSERT',1,0,5.650000),  -- VC33,CCMT 432MT TT7015 INSERT,COMBO ROUGH BORE-P558
(300758,20,'14855',30016,'CCC-28434 REV 1',1,1,212.000000);  -- drill



/*
Cliff 008318 replaced 15721. Assembly takes both an inboard and outboard insert.
009240    |                   200|                   
008318    |                   200|                   
15721     |                   200|ALTERNATE INSERT FO
*/

*/
-- drop table Part_v_Tool_Attributes
CREATE TABLE Part_v_Tool_Attributes
( 
	Plexus_Customer_No int NOT NULL,
	Tool_Attributes_Key	int NOT NULL,	
	Tool_Key int NOT NULL,
	Output_Per_Cycle int NOT NULL,  -- This maps to Busche Tool List NumberOfCuttingEdges column	
  	PRIMARY KEY (Plexus_Customer_No,Tool_Attributes_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Attributes';
insert into Part_v_Tool_Attributes (Plexus_Customer_No,Tool_Attributes_Key,Tool_Key,Output_Per_Cycle)
values
-- Avilla
(310507,21,21,3),  -- insert
(310507,22,22,2),  -- insert
(310507,23,23,1),   -- vc44, spot face insert for 21 mm drill
(310507,24,24,1),   -- VC4, Drill tip for 21 mm drill
(310507,25,25,1),  --
(310507,26,26,1),  --
(310507,27,27,1),  --
(310507,28,28,1),  --
(310507,29,29,1),  -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $103.
(310507,30,30,1),  --
(310507,31,31,1),  -- -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $103.
(310507,32,32,1),   -- -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $200.
(310507,33,33,1),  
(310507,34,34,1),  -- insert
-- Albion
(300758,1,1,16),  -- insert
(300758,2,2,1),  -- drill
(300758,3,3,4), -- 
(300758,4,4,4), -- Shown as an alternate in the Tool List for 008318
(300758,5,5,4), -- Shown as replacing 15721 in Plex 
(300758,6,6,2),  -- insert 
(300758,7,7,3),  -- insert 
(300758,8,8,1),  -- Reamer 
(300758,9,9,1),  -- Reamer. -- Alternate in P558 Knuckles LH 
(300758,10,10,2),  -- insert
(300758,11,11,3),  -- insert
(300758,12,12,4),  -- insert  -- Alternate in P558 Knuckles LH
(300758,13,13,4),  -- insert
(300758,14,14,8),  -- insert
(300758,15,15,1),  -- drill
(300758,16,16,1),  -- Tap
(300758,17,17,2),  -- insert
(300758,18,18,2),  -- VC34, CCMT 32.52 -M3 TK1501,COMBO ROUGH BORE-P558
(300758,19,19,2),  -- VC33,CCMT 432MT TT7015 INSERT,COMBO ROUGH BORE-P558
(300758,20,20,1);  -- drill
select * from Part_v_Tool_Attributes
select * from Part_v_Tool
/*
 * This corresponds to a Plex tool_bom table.
 * -- THIS WILL NEED TO BE UPDATED AFTER TOOLING MODULE UPLOAD
 */
-- drop table Part_v_Tool_BOM
-- truncate table Part_v_Tool_BOM
CREATE TABLE Part_v_Tool_BOM (
	Plexus_Customer_No int NOT NULL,
	Tool_BOM_Key int NOT NULL,
	Tool_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Quantity_Required decimal(18,2) NOT NULL,
	Optional bit(1), -- Use this Plex column to indicate if it is an alternate
	-- This may be helpful in determining CPU for the primary tooling set.
  	PRIMARY KEY (Plexus_Customer_No,Tool_BOM_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_BOM';
insert into Part_v_Tool_BOM (Plexus_Customer_No,Tool_BOM_Key,Tool_Key,Assembly_Key,Quantity_Required,Optional) 
values
-- RDX Brackets
(310507,25,29,1,1,0),
(310507,26,30,2,1,0),
(310507,27,21,3,3,0),
(310507,28,34,3,1,0),
(310507,29,31,4,1,0),
(310507,30,22,5,12,0),
(310507,31,32,6,1,0),
(310507,32,23,7,2,0),
(310507,33,24,7,1,0),
(310507,34,25,8,1,0),
(310507,35,33,9,1,0),
(310507,36,26,10,1,0),
(310507,37,27,11,1,0),
(310507,38,28,12,1,0),
-- P558 Knuckles
(300758,1,1,13,9,0),
(300758,2,14,14,6,0),
(300758,3,15,15,1,0),
(300758,4,16,16,1,0),
(300758,5,20,17,1,0),
(300758,6,18,18,1,0), -- VC34
(300758,7,19,18,9,0), -- VC33,CCMT 432MT TT7015 INSERT,INBOARD
(300758,8,17,19,2,0),
(300758,9,2,20,1,0),
(300758,10,12,21,2,1), -- Alternate Tool for T15;
(300758,11,13,21,2,0),
(300758,12,6,22,7,0),
(300758,13,3,23,2,0), -- VC6,009240,SHLT110408N-PH1 IN2005,DATUM L ROUGH BORE & C'BORE
(300758,14,4,23,2,1), -- Alternate Tool for,008318, one of the T6 inserts.  
(300758,15,5,23,2,0), -- VC66,008318,SHLT140516N-FS IN1030 INSERT,DATUM L ROUGH BORE & C'BORE
(300758,16,7,24,1,0),
(300758,17,7,25,1,0),
(300758,18,8,26,1,0),
(300758,19,9,26,1,1),  -- Alternate Tool for T12; 
(300758,20,10,27,2,0),
(300758,21,11,28,2,0)
select * from Part_v_Tool_BOM  order by Plexus_Customer_No,Tool_BOM_Key 

/*
 * NOT IN PLEX
 * This is a list of all of the alternate tooling for a Tool_BOM.
 */
-- drop table Tool_BOM_Alternate
-- truncate table Tool_BOM_Alternate
CREATE TABLE Tool_BOM_Alternate (
	Plexus_Customer_No int NOT NULL,
	Tool_BOM_Alternate_Key int NOT NULL,
	Tool_BOM_Key int NOT NULL,
	Alternate_Tool_Key int NOT NULL, -- NOT IN PLEX.  Maybe this should be Alternate_Tool_BOM_Key
  	PRIMARY KEY (Plexus_Customer_No,Tool_BOM_Alternate_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Primary to Alternate tool_key mapping for Tool_BOM';
insert into Tool_BOM_Alternate (Plexus_Customer_No,Tool_BOM_Alternate_Key,Tool_BOM_Key,Alternate_Tool_Key) 
values
(300758,1,11,12), -- Alternate Tool for T15;
(300758,2,15,4), -- Alternate Tool for,008318, one of T6 inserts
(300758,3,18,9) -- Alternate Tool for T12;  -- This is regrind-able
select * from Tool_BOM_Alternate
/*
 * This table is used to identify what tool assemblies are using alternate tools.
 * Since regrind-able tools are scanned into plex before being put into a CNC it
 * is not necessary to add an alternate in use records since that information will already be available.
 * This will be created by the tool setter when they put the tool assembly in the CNC by using a Mach2 or Moto screen.
 * Upon the next tool change this record will used to create the Tool_Life record.
 * It will then be deleted.
 */
-- drop table Tool_BOM_Alternate_In_Use
-- truncate table Tool_BOM_Alternate_In_Use
CREATE TABLE Tool_BOM_Alternate_In_Use (
	Plexus_Customer_No int,
	Primary_Tool_Key int NOT NULL,  
	Alternate_Tool_Key int NOT NULL,  
	CNC_Key int NOT NULL, -- Where is it being used 							
	Part_Key int NOT NULL,							
	Part_Operation_Key int NOT NULL,							
	Assembly_Key int NOT NULL,  
	Quantity_In_Use int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Primary_Tool_Key,Alternate_Tool_Key,CNC_Key,Part_Key,Part_Operation_Key,Assembly_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Indicates if an Alternate is currently being used';
insert into Tool_BOM_Alternate_In_Use (Plexus_Customer_No,Primary_Tool_Key,Alternate_Tool_Key,CNC_Key,Part_Key,Part_Operation_Key,Assembly_Key,Quantity_In_Use) 
values
(300758,13,12,3,2794706,7874404,21,1) -- Alternate Tool for T15 is in use;
select * from Tool_BOM_Alternate_In_Use
-- select * from CNC_Approved_Workcenter 
-- select * from CNC 
/*
 * One tool assembly can be used for many part operations.
 */
-- drop table Part_v_Tool_Assembly_Part
-- truncate table Part_v_Tool_Assembly_Part
-- NEEDS UPDATED AFTER PLEX TOOLING MODULE UPLOAD
-- ARE WE USING THIS?
CREATE TABLE Part_v_Tool_Assembly_Part (
	Plexus_Customer_No int NOT NULL,
	Tool_Assembly_Part_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Tool_Assembly_Part_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Assembly_Part';
insert into Part_v_Tool_Assembly_Part (Plexus_Customer_No,Tool_Assembly_Part_Key,Assembly_Key,Part_Key,Operation_Key)
values
-- Avilla
(310507,1,1,2809196,56400),
(310507,2,2,2809196,56400),
(310507,3,3,2809196,56400),
(310507,4,4,2809196,56400),
(310507,5,5,2809196,56400),
(310507,6,6,2809196,56400),
(310507,7,7,2809196,56400),
(310507,8,8,2809196,56400),
(310507,9,9,2809196,56400),
(310507,10,10,2809196,56400),
(310507,11,11,2809196,56400),
(310507,12,12,2809196,56400),
-- select * from Part_v_Tool_Assembly_Part 
-- Albion
(300758,13,13,2794706,51168),
(300758,14,14,2794706,51168),
(300758,15,15,2794706,51168),
(300758,16,16,2794706,51168),
(300758,17,17,2794706,51168),
(300758,18,18,2794706,51168),
(300758,19,19,2794706,51168),
(300758,20,20,2794706,51168),
(300758,21,21,2794706,51168),
(300758,22,22,2794706,51168),
(300758,23,23,2794706,51168),
(300758,24,24,2794706,51168),
(300758,25,25,2794706,51168),
(300758,26,26,2794706,51168),
(300758,27,27,2794706,51168),
(300758,28,28,2794706,51168)
select * from Part_v_Tool_Assembly_Part


/*
 * Records in this table contain the expected tool life values for standard and reworked parts for a
 * given part operation and assembly.
 * We may not need the Rework_Tool_Life field and we will initially set it equal to the standard_tool_life.
 * We may find out that the rework tool life depends on the number of regrinds or it the same no matter how
 * many times a regrind is done.  
 */
-- drop table Part_v_Tool_Op_Part_Life 
-- truncate table Part_v_Tool_Op_Part_Life
CREATE TABLE Part_v_Tool_Op_Part_Life
(
	Tool_Op_Part_Life_Key int NOT NULL,	-- This is unique but is not the primary key
	PCN	int NOT NULL,
	Tool_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL, -- Tool_Life uses Part_Operation_Key but Tool_Op_Part_Life uses only the Operation_Key in Plex.
	Standard_Tool_Life	int NOT NULL,  -- Tool list value; Average tool_life for non-regrindable tools or regrind-able tools that are new.
	-- Rework_Tool_Life int NOT NULL,  -- Plex table did not have this column.  This column is of no value since it does not contain a regrind count.
	-- to capture the info we need there needs to be a separate table that contains Tool_Life and Regrind count columns.  The Tool_Life table
	-- has these columns so we can write a sproc that has a key of CNC_Key,Part_Key,Operation_Key,Assembly_Key,Tool_Key,Regrind_Count and calculates
	-- the Tool_Life for this key without an actual table.  Although for reporting purposes a sproc can be called periodically to insert this 
	-- information into a table,CNC_Tool_Op_Part_Life
	Assembly_Key int NOT NULL,
  	PRIMARY KEY (PCN,Tool_Key,Part_Key,Operation_Key,Assembly_Key)  -- This combination must be unique
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Plex table';
insert into Part_v_Tool_Op_Part_Life (Tool_Op_Part_Life_Key,PCN,Tool_Key,Part_Key,Operation_Key,Standard_Tool_Life,Assembly_Key)
values
-- Albion
-- P558 LH Knuckles, CNC120
(20,300758,1,2794706,51168,200,13),  -- vc1
(21,300758,14,2794706,51168,200,14),  -- vc21
(22,300758,15,2794706,51168,2500,15),  -- vc22
(23,300758,16,2794706,51168,3000,16),  -- vc23
(24,300758,20,2794706,51168,1800,17),  -- vc72
(25,300758,19,2794706,51168,200,18),  -- VC33,CCMT 432MT TT7015 INSERT,COMBO ROUGH BORE-P558
(26,300758,18,2794706,51168,1000,18),  -- VC34, CCMT 32.52 -M3 TK1501,COMBO ROUGH BORE-P558
(27,300758,17,2794706,51168,350,19),  -- vc30
(28,300758,2,2794706,51168,3000,20),  -- vc4
(29,300758,12,2794706,51168,300,21),  -- vc15  Alternate tool
(30,300758,13,2794706,51168,300,21),  -- vc15
(31,300758,6,2794706,51168,2500,22),  -- vc7
(32,300758,3,2794706,51168,200,23),  -- VC6,SHLT110408N-PH1 IN2005 INSERT,DATUM L ROUGH BORE & C'BORE
(33,300758,4,2794706,51168,200,23),  -- Alternate, Don't know if it is an alternate for vc6 or vc66.
(34,300758,5,2794706,51168,200,23),  -- VC66,SHLT140516N-FS IN1030 INSERT,DATUM L ROUGH BORE & C'BORE
(35,300758,7,2794706,51168,3000,24),  -- vc9
(36,300758,7,2794706,51168,3000,25),  -- vc8
(37,300758,8,2794706,51168,18000,26),  -- vc12
(38,300758,9,2794706,51168,18000,26),  -- vc12 Alternate tool
(39,300758,10,2794706,51168,800,27),  -- vc13
(40,300758,11,2794706,51168,5000,28),  -- vc14
-- select * from Part_v_Tool_Assembly -- 16
-- 21
-- Avilla
-- RDX, CNC 103
(1,310507,29,2809196,56400,40000,1),
(2,310507,30,2809196,56400,5000,2),
(3,310507,21,2809196,56400,5000,3), -- VC1,Insert,TCGT 32.52 FL K10, for 85.24MM ROUGH BORE 
(4,310507,34,2809196,56400,40000,3), -- VC21, Boring Bar,CCC-32505-100, for 85.24MM ROUGH BORE
(5,310507,31,2809196,56400,40000,4),
(6,310507,22,2809196,56400,5000,5),
(7,310507,32,2809196,56400,40000,6),
(8,310507,23,2809196,56400,5000,7),  --  VC44,CCC-32503-010/PCD spotface insert for 21mm drill.
(9,310507,24,2809196,56400,5000,7),  -- VC4,HH-32503-21-AL drill tip for 21mm drill
(10,310507,25,2809196,56400,10000,8),
(11,310507,33,2809196,56400,40000,9),
(12,310507,26,2809196,56400,10000,10),
(13,310507,27,2809196,56400,10000,11),
(14,310507,28,2809196,56400,10000,12)
select * from Part_v_Tool_Op_Part_Life



/*
 * This table contains the average standard tool life for all of the tools including the alternates for a specific CNC.
 * We will know these values once we start collecting data.  Just as with the Tool_Op_Part_Life
 * The current value column will contain the running total not the common variable value.
 */
-- NOT A PLEX TABLE
-- drop table CNC_Tool_Op_Part_Life
-- truncate table CNC_Tool_Op_Part_Life
CREATE TABLE CNC_Tool_Op_Part_Life
(
	CNC_Tool_Op_Part_Life_Key int NOT NULL,	-- This for easy access to a record and must be unique but is not the primary key
	-- PCN	int NOT NULL,  -- Tool_Op_Part_Life contains the PCN.
	Tool_Op_Part_Life_Key int NOT NULL,	-- foriegn key,  This record contains the PCN
	CNC_Key int NOT NULL, -- foriegn key,
	Increment_By int NOT NULL,   -- How much to increment the tool counter every cycle
	Standard_Tool_Life int NOT NULL,  -- Initially this is the same for all CNC from the Tool List QuantityPerCuttingEdge, but we may want to change this value per CNC.  
  	Current_Value int NOT NULL, -- The current value column will contain the running total not the common variable value. 
  	Last_Update datetime NOT NULL,
  	PRIMARY KEY (Tool_Op_Part_Life_Key,CNC_Key)  -- This has to be unique
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='PlexX table';
set @Last_Update = '2020-08-15 00:00:00';
insert into CNC_Tool_Op_Part_Life (CNC_Tool_Op_Part_Life_Key,Tool_Op_Part_Life_Key,CNC_Key,Increment_By,Standard_Tool_Life,Current_Value,Last_Update)
values
-- Albion
-- P558 LH Knuckles, CNC120
(20,20,3,2,200,-1,@Last_Update),  -- vc1
(21,21,3,2,200,-1,@Last_Update),  -- vc21
(22,22,3,2,2500,-1,@Last_Update),  -- vc22
(23,23,3,2,3000,-1,@Last_Update),  -- vc23
(24,24,3,2,1800,-1,@Last_Update),  -- vc72
(25,25,3,2,200,-1,@Last_Update),  -- VC33,CCMT 432MT TT7015 INSERT,COMBO ROUGH BORE-P558
(26,26,3,2,1000,-1,@Last_Update),  -- VC34, CCMT 32.52 -M3 TK1501,COMBO ROUGH BORE-P558
(27,27,3,2,350,-1,@Last_Update),  -- vc30
(28,28,3,2,3000,-1,@Last_Update),  -- vc4
(29,29,3,2,300,-1,@Last_Update),  -- vc15  Alternate tool
(30,30,3,2,300,-1,@Last_Update),  -- vc15
(31,31,3,2,2500,-1,@Last_Update),  -- vc7
(32,32,3,2,200,-1,@Last_Update),  -- VC6,SHLT110408N-PH1 IN2005 INSERT,DATUM L ROUGH BORE & C'BORE
(33,33,3,2,200,-1,@Last_Update),  -- Alternate, Don't know if it is an alternate for vc6 or vc66.
(34,34,3,2,200,-1,@Last_Update),  -- VC66,SHLT140516N-FS IN1030 INSERT,DATUM L ROUGH BORE & C'BORE
(35,35,3,2,3000,-1,@Last_Update),  -- vc9
(36,36,3,2,3000,-1,@Last_Update),  -- vc8
(37,37,3,2,18000,-1,@Last_Update),  -- vc12
(38,38,3,2,18000,-1,@Last_Update),  -- vc12 Alternate tool
(39,39,3,2,800,-1,@Last_Update),  -- vc13
(40,40,3,2,5000,-1,@Last_Update),  -- vc14
-- Avilla
-- RDX, CNC 103
(1,1,1,2,40000,-1,@Last_Update),
(2,2,1,2,5000,-1,@Last_Update),
(3,3,1,2,5000,-1,@Last_Update),  -- VC1,Insert,TCGT 32.52 FL K10, for 85.24MM ROUGH BORE 
(4,4,1,2,40000,-1,@Last_Update), --  VC21, Boring Bar,CCC-32505-100, for 85.24MM ROUGH BORE
(5,5,1,2,40000,-1,@Last_Update),
(6,6,1,2,5000,-1,@Last_Update),
(7,7,1,2,40000,-1,@Last_Update),
(8,8,1,2,5000,-1,@Last_Update),  --  VC44,CCC-32503-010/PCD spotface insert for 21mm drill.
(9,9,1,2,5000,-1,@Last_Update),  -- VC4,HH-32503-21-AL drill tip for 21mm drill
(10,10,1,2,10000,-1,@Last_Update),
(11,11,1,2,40000,-1,@Last_Update),
(12,12,1,2,10000,-1,@Last_Update),
(13,13,1,2,10000,-1,@Last_Update),
(14,14,1,2,10000,-1,@Last_Update)

select * from CNC_Tool_Op_Part_Life  -- 35 = 32 primary tools plus 3 alts

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
 * Keep track of specific info on each regrind-able tool.
 * Ben will update the regrind count and expected tool life through a Plex,moto, or mach2 screen.  
 */
-- drop table Part_v_Tool_Inventory
-- truncate table Part_v_Tool_Inventory
CREATE TABLE Part_v_Tool_Inventory
( 
	Plexus_Customer_No int,
	Tool_Serial_Key	int,
	Tool_Serial_No	varchar (50),
	Tool_Key int,  -- 1 tool_key to many tool_serial_key
	Regrind_Count int, -- NOT A PLEX COLUMN. How many times it has been reground. Might be able to use a column in Tool_Inventory_Attributes 
	Rework_Tool_Life int, -- NOT A PLEX COLUMN. Initially this is set to the Standard_Tool_Life, but then it is maintained by Ben Maynus.
  	PRIMARY KEY (Plexus_Customer_No,Tool_Serial_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Subset of plex part_v_tool_inventory view';
insert into Part_v_Tool_Inventory (Plexus_Customer_No,Tool_Serial_Key,Tool_Serial_No,Tool_Key,Regrind_Count,Rework_Tool_Life)
values
-- Albion P558 Knuckles
-- Part_v_Tool.Standard_Reworks
(300758,1,'17100-001',2,0,3000),  -- drill
(300758,2,'010338-001',8,0,18000),  -- Reamer 
(300758,3,'008410-001',9,0,18000),  -- Reamer. -- Alternate in P558 Knuckles LH 
(300758,4,'14710-001',15,0,2500),  -- drill
(300758,5,'14855-001',20,0,1800);  -- drill
select * from Part_v_Tool_Inventory
select * from Part_v_Tool_Op_Part_Life where Tool_Key = 20


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
	CNC_Key int NOT NULL, 							
	Part_Key int NOT NULL,							
	Part_Operation_Key int NOT NULL,							
	Assembly_Key int NOT NULL,  
  	PRIMARY KEY (Plexus_Customer_No,Tool_Serial_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Maps a regrind-able tool to a CNC assembly';
insert into Tool_Inventory_In_Use (Plexus_Customer_No,Tool_Serial_Key,Primary_Tool_Key,Tool_Key,CNC_Key,Part_Key,Part_Operation_Key,Assembly_Key)
values
-- Albion
-- P558 LH Knuckles, CNC120
(300758,1,2,2,3,2794706,7874404,20),-- T04
(300758,3,8,9,3,2794706,7874404,26),-- This is an alternate tool for T12
(300758,4,15,15,3,2794706,7874404,15), -- T22
(300758,5,20,20,3,2794706,7874404,17) -- T72
select * from Tool_Inventory_In_Use 

/*
 * subset of Plex Tool_Life table
 * This is a tool life history table
 */
-- drop table Part_v_Tool_Life
-- truncate table Part_v_Tool_Life
CREATE TABLE Part_v_Tool_Life 
(
	PCN int NOT NULL,
	Tool_Life_Key int NOT NULL,
	Tool_Key int NOT NULL,	
	Tool_Serial_Key int,  -- Optional, ADDED: Plex Part_v_Tool_Inventory column.
	Workcenter_Key	int NOT NULL,  -- This will allow us to group all CNC in a work area.  Technically not needed but it is a Plex column.
	CNC_Key int NOT NULL, -- needed because our Workcenters have multiple CNC. NOT A PLEX COLUMN.							
	Part_Key int NOT NULL,							
	Part_Operation_Key int NOT NULL,							
	Assembly_Key int NOT NULL,  -- NOT A PLEX COLUMN
	Run_Date datetime NOT NULL,	-- Start date. Record created at time of tool change of previous tool set.				
	Run_Quantity int NOT NULL,	-- Actual tool life for tool set if this is .					
	Regrind_Count int,	-- The number of times the tool has been reground.  NOT A PLEX COLUMN.
  	PRIMARY KEY (PCN,Tool_Life_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Subset of plex part_v_tool_life table';
select * from Part_v_Tool_Life 


-- truncate table Tool_Assembly_Change_History
set @CNC_Approved_Workcenter_Key = 2;
set @Set_No = 1;
set @Block_No = 1;
set @Run_Date = '2020-09-05 09:50:00';
set @Run_Quantity = 100;
CALL InsToolLifeHistory(@CNC_Approved_Workcenter_Key,@Set_No,@Block_No,@Run_Date,@Run_Quantity,@Tool_Life_Key,@Return_Value);
SELECT @Tool_Life_Key,@Return_Value;

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
  	IN pRun_Date,
	IN pRun_Quantity INT,
  	OUT pTool_Life_Key INT,
	OUT pReturnValue INT 
)
BEGIN

set @CNC_Approved_Workcenter_Key = 2;
set @Set_No = 1;
set @Block_No = 1;
set @Run_Date = '2020-09-05 09:50:00';
set @Run_Quantity = 100;

-- START HERE
-- VERIFY WE CAN GET ENOUGH INFO TO UPDATE THE Tool_Life record including the serial_key for regrinds and the alternate tool key for alts.
-- VERIFY WE CAN GET ENOUGH INFO TO UPDATE THE CNC_Tool_Op_Part_Life record with the current running total and last update columns.
-- Insert a Tool_Life record with these values
select 
caw.Plexus_Customer_No,
caw.Workcenter_Key,
caw.CNC_Key,
caw.Part_Key,
caw.Part_Operation_Key, 
bl.Assembly_Key, 
-- ti.Tool_Serial_Key, 
bl.Tool_Key primary_tool_key,
iu.Alternate_Tool_Key,
riu.Tool_Serial_Key,
ti.Regrind_Count
-- select * from CNC_Approved_Workcenter
-- select * from Datagram_Set_Block
-- select bl.*
from CNC_Approved_Workcenter caw -- list all of the CNC / part_operation possibilites
inner join Datagram_Set_Block bl -- All of the primary tooling for each assembly for each part_operation
-- using the CNC_Approved_Workcenter_Key and the set and block number passed by the CNC
-- we can get the tool_key,assembly_key, and part operation.
on caw.Plexus_Customer_No=bl.Plexus_Customer_No
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
and bl.Tool_Key = iu.Primary_Tool_Key -- For now the Datagram_Set_Block always contains the primay tool key.
and bl.CNC_Key = iu.CNC_Key
and bl.Part_Key = iu.Part_Key -- Don't know if both the Part and Part_Operation keys will ever be necessary but Plex uses them both
and bl.Part_Operation_Key = iu.Part_Operation_Key
and bl.Assembly_Key = iu.Assembly_Key  -- 32 recs
-- select * from Tool_Op_Part_Life_CNC_Set_Block
-- select * from Tool_BOM_Alternate_In_Use
left outer join Tool_Inventory_In_Use riu 
on bl.Plexus_Customer_No=riu.Plexus_Customer_No
and bl.Tool_Key = riu.Primary_Tool_Key 
and bl.CNC_Key = riu.CNC_Key
and bl.Part_Key = riu.Part_Key -- Don't know if both the Part and Part_Operation keys will ever be necessary but Plex uses them both
and bl.Part_Operation_Key = riu.Part_Operation_Key
and bl.Assembly_Key = riu.Assembly_Key
left outer join Part_v_Tool_Inventory ti 
on riu.Tool_Serial_Key = ti.Tool_Serial_Key -- 1 to 1
-- order by caw.CNC_Key,bl.Assembly_Key,bl.Tool_Key 

where caw.CNC_Approved_Workcenter_Key = @CNC_Approved_Workcenter_Key
and bl.Set_No = @Set_No 
and bl.Block_No = @Block_No


set @CNC_Approved_Workcenter_Key = 2;
set @Set_No = 1;
set @Block_No = 1;
set @Run_Date = '2020-09-05 09:50:00';
set @Run_Quantity = 100;

select cpl.Current_Value,cpl.Last_Update  -- UPDATE THESE VALUES
from CNC_Approved_Workcenter caw -- list all of the CNC / part_operation possibilites
inner join Datagram_Set_Block bl -- All of the primary tooling for each assembly for each part_operation
-- there are 32 primary tools currently 
-- using the CNC_Approved_Workcenter_Key and the set and block number passed by the CNC
-- we can get the tool_key,assembly_key, and part operation.
on caw.Plexus_Customer_No=bl.Plexus_Customer_No
and caw.CNC_Key = bl.CNC_Key 
and caw.Part_Key = caw.Part_Key -- Don't know if both of these keys will ever be necessary but Plex uses them both
and caw.Part_Operation_Key = bl.Part_Operation_Key -- 1 to many  --32 recs
inner join Part_v_Tool_Op_Part_Life opl  
on bl.Plexus_Customer_No = opl.PCN 
and bl.Tool_Key = opl.Tool_Key 
and bl.Part_Key = opl.Part_Key 
and bl.Operation_Key = opl.Operation_Key -- 
and bl.Assembly_Key = opl.Assembly_Key -- 1 to 1, 32 recs
inner join CNC_Tool_Op_Part_Life cpl 
on opl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key  -- 1 to 1, 32 recs
where caw.CNC_Approved_Workcenter_Key = @CNC_Approved_Workcenter_Key
and bl.Set_No = @Set_No 
and bl.Block_No = @Block_No


select * from CNC_Tool_Op_Part_Life
select * from Part_v_Tool_Op_Part_Life  -- There are currently 35 tools total of which 32 are primary tools and 3 are alts.
/*
select 
c.CNC_Key,l.Part_Key,l.Operation_Key,l.Assembly_Key 
-- a.CNC_Key,a.Part_Key,a.Operation_Key,a.Assembly_Key
from Part_v_Tool_Op_Part_Life l
inner join  Tool_Op_Part_Life_CNC c
on l.Tool_Op_Part_Life_Key = c.Tool_Op_Part_Life_Key  -- 1 to many

select * from Tool_Op_Part_Life_CNC_Set_Block bl
*/
/*
	select a.CNC_Key,a.Part_Key,a.Operation_Key,a.Assembly_Key,@Actual_Tool_Life,@Trans_Date
	from 
   	CNC_Part_Operation p
	inner join CNC_Part_Operation_Set_Block b 
	on p.CNC_Key = b.CNC_Key
	and p.Part_Key = b.Part_Key
	and p.Operation_Key = b.Operation_Key  -- 1 to many
	inner join CNC_Part_Operation_Assembly a
	on b.CNC_Key = a.CNC_Key
	and b.Part_Key = a.Part_Key 
	and b.Operation_Key = a.Operation_Key 
	and b.Assembly_Key = a.Assembly_Key 
	where p.CNC_Part_Operation_Key=@pCNC_Part_Operation_Key 
    and b.Set_No = @pSet_No and b.Block_No = @pBlock_No;
*/
INSERT INTO Tool_Assembly_Change_History
(CNC_Key,Part_Key,Operation_Key,Assembly_Key,Actual_Tool_Assembly_Life,Trans_Date)
	select a.CNC_Key,a.Part_Key,a.Operation_Key,a.Assembly_Key,pActual_Tool_Assembly_Life,pTrans_Date
	from 
   	CNC_Part_Operation p
	inner join CNC_Part_Operation_Set_Block b 
	on p.CNC_Key = b.CNC_Key
	and p.Part_Key = b.Part_Key
	and p.Operation_Key = b.Operation_Key  -- 1 to many
	inner join CNC_Part_Operation_Assembly a
	on b.CNC_Key = a.CNC_Key
	and b.Part_Key = a.Part_Key 
	and b.Operation_Key = a.Operation_Key 
	and b.Assembly_Key = a.Assembly_Key 
	where p.CNC_Part_Operation_Key=pCNC_Part_Operation_Key 
    and b.Set_No = pSet_No and b.Block_No = pBlock_No;


-- VALUES(pCNC_Key,pPart_Key,pOperation_Key,pAssembly_Key,pActual_Tool_Life,pTrans_Date);
-- VALUES(@CNC_Key,@Part_Key,@Operation_Key,Assembly_Key,@Actual_Tool_Life,@Trans_Date);

-- Display the last inserted row.
set pTool_Assembly_Change_History_Key = (select Tool_Assembly_Change_History_Key from Tool_Assembly_Change_History where Tool_Assembly_Change_History_Key =(SELECT LAST_INSERT_ID()));
-- select pTool_Assembly_Change_History_Key;
-- SET @total_tax = (SELECT SUM(tax) FROM taxable_transactions);
set pReturnValue = 0;
END;


select * from Tool_Assembly_Change_History where assembly_key = 10;

set @CNC_Part_Operation_Key = 1;
set @Set_No = 1;
set @Block_No = 10;
set @Actual_Tool_Life = 2;
set @Trans_Date = '2020-08-18 00:00:01';
-- select * from Tool_Assembly_Change_History
CALL Tool_Assembly_Change_History(@CNC_Part_Operation_Key,@Set_No,@Block_No,@Actual_Tool_Life,@Trans_Date,@Return_Value);
	 -- UpdateCNCPartOperationAssemblyCurrentValue(?,?,?,?,?,@ReturnValue); select @ReturnValue as pReturnValue
SELECT @Return_Value;


select * from Tool_Assembly_Change_History where assembly_key = 10;

*/
/*
 * History of CNC cycle times times
 */
-- drop table Cycle_Time_History 
-- truncate table Cycle_Time_History
CREATE TABLE Cycle_Time_History (
	Cycle_Time_History_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
  	Cycle_Time int NOT NULL, -- In seconds
  	Trans_Date datetime NOT NULL,
  	PRIMARY KEY (Cycle_Time_History_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='History of CNC cycle times';


/*
 * History of assembly cutting times
 */
-- drop table Cutting_Time_History 
-- truncate table Cutting_Time_History
CREATE TABLE Cutting_Time_History (
	Cutting_Time_History_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
  	Cutting_Time int NOT NULL, -- In seconds
  	Trans_Date datetime NOT NULL,
  	PRIMARY KEY (Cutting_Time_History_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='History of assembly cutting times';

