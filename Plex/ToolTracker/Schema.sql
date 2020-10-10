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
	CNC_Key int NOT NULL,
	CNC_TYPE_Key int NOT NULL, -- foreign key
  	Building_Key int NOT NULL, -- foreign key
	CNC_Code varchar(10) NOT NULL,
	Serial_Port bit(1) NOT NULL,
	Networked bit(1) NOT NULL, 
  	PRIMARY KEY (CNC_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC info';
insert into CNC (CNC_Key,CNC_Type_Key,Building_Key,CNC_Code,Serial_Port,Networked)
values
-- Albion
(3,1,5644,'120',true,false),
-- Avilla
(1,1,5680,'103',true,false),
(2,2,5680,'362',false,true)
select * from CNC

-- drop table CNC_Type 
CREATE TABLE CNC_Type (
	CNC_Type_Key int NOT NULL,
	CNC_Type_Code varchar(50) NOT NULL,
  	PRIMARY KEY (CNC_Type_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC types such as Makino, Okuma, Welles, etc.';
insert into CNC_Type (CNC_Type_key,CNC_Type_Code)
values
(1,'Okuma'),
(2,'Makino')
select * from CNC_Type

/*
 * Subset of Part_v_Approved_Workcenter
 */
-- drop table Part_v_Approved_Workcenter
-- truncate table Part_v_Approved_Workcenter
CREATE TABLE Part_v_Approved_Workcenter (
	Plexus_Customer_No int NOT NULL,
  	Part_Key int NOT NULL,
  	Operation_Key int NOT NULL,
  	Workcenter_Key int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Part_Key,Operation_Key,Workcenter_Key)  -- Does not have an Approved_Workcenter_Key.
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Subset of Part_v_Approved_Workcenter.';
insert into Part_v_Approved_Workcenter (Plexus_Customer_No,Part_Key,Operation_Key,Workcenter_Key)
values
-- Albion
(300758,2794706,51168,61090), -- Kunckles 6K LH
-- Avilla
(310507,2809196,56400,61324)  -- RDX AVILLA
select * from Part_v_Approved_Workcenter

/*
 * Plex extension table.
 * In Plex many CNC can be assigned to 1 work center, but there is not a 1 to many table for this.
 */
-- drop table CNC_Approved_Workcenter
-- truncate table CNC_Approved_Workcenter
CREATE TABLE CNC_Approved_Workcenter (
	Plexus_Customer_No int NOT NULL,
  	Part_Key int NOT NULL,
  	Operation_Key int NOT NULL,
  	Workcenter_Key int NOT NULL,
	CNC_Key int NOT NULL,  
  	PRIMARY KEY (Plexus_Customer_No,Part_Key,Operation_Key,Workcenter_Key,CNC_Key)  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Link CNC to a workcenter';
insert into CNC_Approved_Workcenter (Plexus_Customer_No,Part_Key,Operation_Key,Workcenter_Key,CNC_Key)
values
-- Albion
(300758,2794706,51168,61090,3), -- Kunckles 6K LH
-- Avilla
(310507,2809196,56400,61324,1)  -- RDX AVILLA
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
select * from Operation_V2

/*
 */
-- drop table Plex_v_Part_Operation
-- truncate table Plex_v_Part_Operation
CREATE TABLE Plex_v_Part_Operation (
	Plexus_Customer_No int NOT NULL,
	Part_Operation_Key	int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	PRIMARY KEY (Plexus_Customer_No,Part_Operation_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_part_operation';
insert into Plex_v_Part_Operation (Plexus_Customer_No,Part_Operation_Key,Part_Key,Operation_Key)
values
-- Albion
(300758,7874404,2794706,51168),  -- LH Knuckles, CNC120, Machine A -WIP,  Operation 10 in Tool List.
-- Avilla
(310507,7917723,2809196,56400);  -- RDX AVILLA
select * from Plex_v_Part_Operation

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
(300758,30048,'Insert'),
(300758,30016,'Drill'),
(300758,30800,'Reamer'), 
(300758,30801,'Tap'),
-- Avilla
(310507,25115,'Insert'),
(310507,25118,'Drill'),
(310507,30760,'Drill Tip'),
(310507,25116,'End Mill'),
(310507,30740,'Boring Bar'),
(310507,30758,'Disc Mill'),
(310507,30762,'Engraving');
select * from Part_v_Tool_Type


/*
 * This corresponds to a Plex Tool_Group table.
 * Albion’s ExportMasterToolList Tool_Group looks like a tool_type where as Alabama and now Edon are set to Mill.
 * ADDED MILL TOOL GROUP LOOKUP TOOL_GROUP_KEY LATER AND CHANGE FROM 1
 */
-- drop table Tool_Group
-- truncate table Tool_Group
CREATE TABLE Tool_Group (
	Plexus_Customer_No int NOT NULL,
	Tool_Group_Key int,
	Tool_Group_Code	varchar (20),
  	PRIMARY KEY (Tool_Group_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Group';
insert into Tool_Group (Tool_Group_Key,Tool_Group_Code)
values

(1,'Mill')
select * from Tool_Group 


-- drop table Part_v_Tool
-- truncate table Part_v_Tool
CREATE TABLE Part_v_Tool (
	Plexus_Customer_No int NOT NULL,
	Tool_Key int,
	Tool_No	varchar (50),
	Tool_Type_Key	int,
	Tool_Group_Key	int,  -- Regrindable here
	Description	varchar (50),
	Perishable	bit, -- Maps to Busche Tool List consumable column
	Price	decimal (18,4),
  	PRIMARY KEY (Plexus_Customer_No,Tool_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool';
insert into Part_v_Tool (Plexus_Customer_No,Tool_Key,Tool_No,Tool_Type_Key,Description,Perishable,Price)  
values
-- Avilla
(310507,21,'008431',25115,'TCGT 32.52 FL K10',1,6.690000),  -- insert
(310507,22,'007221',25115,'XOEX120408FR-E06 H15',1,10.310000),  -- insert
(310507,23,'16405',25115,'CCC-32503-010/PCD',1,92.000000),   -- vc44, spot face insert for 21 mm drill
(310507,24,'16406',30760,'HH-32503-21-AL',1,79.000000),   -- VC4, Drill tip for 21 mm drill
(310507,25,'16461',25116,'A345M-100-D2-S.0-Z3',1,33.700000),  --
(310507,26,'16110',25116,'CCC-30083 REV 1',1,101.000000),  --
(310507,27,'16111',25118,'CCC-30082',1,163.1600000),  --
(310507,28,'16130',25118,'CCC-30081',1,163.1600000),  --
(310507,29,'16680',30740,'CCC-33146',1,103.000000),  -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $103.
(310507,30,'12623',30762,'C-1875-2.0-60-.020-G',1,14.980000),  --
(310507,31,'16409',30740,'CCC-32506-100',1,103.000000),  -- -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $103.
(310507,32,'16407',30758,'CCC-32508-100',1,200.000000),   -- -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $200.
(310507,33,'16408',30758,'CCC-32507-100',1,1320.000000),  
(310507,34,'16410',30740,'CCC-32505-100',1,525.000000),  -- insert
-- Albion
(300758,1,'009196',30048,1,'ONMU 090520ANTN-M15 MK2050',1,14.380000),  -- insert
(300758,2,'17100',30016,1,'CCC-34231',1,276.000000),  -- drill
(300758,3,'009240',30048,1,'SHLT110408N-PH1 IN2005',1,8.780000), -- 
(300758,4,'15721',30048,1,'SHLT140516N-FS IN2005',1,12.570000), -- Shown as an alternate in the Tool List for 008318
(300758,5,'008318',30048,1,'SHLT140516N-FS IN1030',1,10.950000), -- Shown as replacing 15721 in Plex 
(300758,6,'008485',30048,1,'CDE323L022 IN2530',1,9.820000),  -- insert 
(300758,7,'007864',30048,1,'TCMT 21.51-F1 TP1501',1,5.950000),  -- insert 
(300758,8,'010338',30800,1,'CCC-23575 REV A',1,456.00000),  -- Reamer 
(300758,9,'008410',30800,1,'CCC-21216 REV B',1,198.000000),  -- Reamer. -- Alternate in P558 Knuckles LH 
(300758,10,'0003396',30048,1,'APFT1604PDTL-D15 MP1500 Insert',1,9.810000),  -- insert
(300758,11,'008435',30048,1,'TCMT 110202 LC225T',1,10.370000),  -- insert
(300758,12,'009155',30048,1,'SPLT140512N-PH IN2005',1,9.980000),  -- insert  -- Alternate in P558 Knuckles LH
(300758,13,'13753',30048,1,'WDXT 156012-H ACK300',1,6.952000),  -- insert
(300758,14,'17022',30048,1,'SNMX1407ZNTR-M16 MK2050',1,12.510000),  -- insert
(300758,15,'14710',30016,1,'CCC-27629 REV 0',1,93.000000),  -- drill
(300758,16,'0000951',30801,1,'23910-05',1,32.350000),  -- Tap
(300758,17,'16547',30048,1,'CCMT21.52MK MC5015',1,6.640000),  -- insert
(300758,18,'010559',30048,1,'CCMT 32.52 -M3 TK1501',1,6.030000),  -- VC34, CCMT 32.52 -M3 TK1501,COMBO ROUGH BORE-P558
(300758,19,'15843',30048,1,'CCMT 432MT TT7015 INSERT',1,5.650000),  -- VC33,CCMT 432MT TT7015 INSERT,COMBO ROUGH BORE-P558
(300758,20,'14855',30016,1,'CCC-28434 REV 1',1,212.000000);  -- drill

/*
Cliff 008318 replaced 15721. Assembly takes both an inboard and outboard insert.
009240    |                   200|                   
008318    |                   200|                   
15721     |                   200|ALTERNATE INSERT FO
*/

/*
 * This information may be stored in Tool_Attribute and Tool_Attribute_Value
 * but this value column is a varchar so it is not Ideal
 * 
 */
/*  TRY TO USE TOOL_ATTRIBUTES instead
-- drop table Tool_X
-- truncate table Tool_X
CREATE TABLE Tool_X (
	Plexus_Customer_No int NOT NULL,
	Tool_X_Key int,
	NumberOfCuttingEdges int, -- Comes from Busche Tool List
  	PRIMARY KEY (Plexus_Customer_No,Tool_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool';
insert into Tool_Plx (Plexus_Customer_No,Tool_Key,Tool_No,Tool_Type_Key,Tool_Group_Key,Description,Consumable,NumberOfCuttingEdges,Price)  
-- Avilla
*/
CREATE TABLE Tool_Attributes_Plx
( 
	Tool_Attributes_Key	int NOT NULL,	
	Tool_Key int NOT NULL,
	Output_Per_Cycle int NOT NULL,  -- This maps to Busche Tool List NumberOfCuttingEdges column	
  	PRIMARY KEY (Plexus_Customer_No,Tool_Attributes_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Attributes';
insert into Tool_Attributes_Plx (Plexus_Customer_No,Tool_Key,Tool_No,Tool_Type_Key,Tool_Group_Key,Description,Consumable,NumberOfCuttingEdges,Price)  

/*
 * This corresponds to a Plex tool_bom table.
 * -- THIS WILL NEED TO BE UPDATED AFTER TOOLING MODULE UPLOAD
 */
-- drop table Tool_BOM_Plx
-- truncate table Tool_BOM_Plx
CREATE TABLE Tool_BOM_Plx (
	Plexus_Customer_No int,
	Tool_BOM_Key int,
	Tool_Key int,
	Assembly_Key int NOT NULL, 
	Quantity_Required decimal (18,2),
	Optional bit(1), -- Use this Plex column to indicate if it is an alternate
  	PRIMARY KEY (Plexus_Customer_No,Tool_BOM_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_BOM';
insert into Tool_BOM_Plx (Plexus_Customer_No,Tool_BOM_Key,Tool_Key,Assembly_Key,Quantity_Required,Alternate) 
-- RDX Brackets
-- values (310507,25,29,1,1,0)
-- values (310507,26,30,2,1,0)
-- values (310507,27,21,3,3,0)
-- values (310507,28,31,4,1,0)
-- values (310507,29,22,5,12,0)
-- values (310507,30,32,6,1,0)
-- values (310507,31,23,7,2,0)
-- values (310507,32,24,7,1,0)
-- values (310507,33,25,8,1,0)
-- values (310507,34,33,9,1,0)
-- values (310507,35,26,10,1,0)
-- values (310507,36,27,11,1,0)
-- values (310507,37,28,12,1,0)

-- P558 Knuckles
-- values (300758,1,1,13,9,0)
-- values (300758,2,2,20,1,0)
-- values (300758,3,3,23,2,0)
-- values (300758,4,4,23,2,1) -- Alternate Tool; 
-- values (300758,5,5,23,2,0)  
-- values (300758,6,6,22,7,0)
-- values (300758,7,7,24,1,0)
-- values (300758,8,7,25,1,0)
-- values (300758,9,8,26,1,0)
-- values (300758,10,9,26,1,1)  -- Alternate Tool; 
-- values (300758,11,10,27,2,0)
-- values (300758,12,11,28,2,0)
-- values (300758,13,12,21,2,1) -- Alternate Tool;
-- values (300758,14,13,21,2,0)
-- values (300758,15,14,14,6,0)
-- values (300758,16,15,15,1,0)
-- values (300758,17,16,16,1,0)
-- values (300758,18,17,19,1,0)
-- values (300758,19,18,18,1,0)
-- values (300758,20,19,18,9,0)
-- values (300758,21,20,17,1,0)
select * from Tool_BOM_Plx  order by Plexus_Customer_No,Assembly_Key 


-- drop table Tool_Assembly_Part_Plx
-- truncate table Tool_Assembly_Part_Plx
-- NEEDS UPDATED AFTER PLEX TOOLING MODULE UPLOAD
CREATE TABLE Tool_Assembly_Part_Plx (
	Plexus_Customer_No int NOT NULL,
	Tool_Assembly_Part_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Tool_Assembly_Part_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Assembly_Part';
insert into Tool_Assembly_Part_Plx (Plexus_Customer_No,Tool_Assembly_Part_Key,Assembly_Key,Part_Key,Operation_Key)
-- Avilla
-- values (310507,1,1,2809196,56400)
-- values (310507,2,2,2809196,56400)
-- values (310507,3,3,2809196,56400)
-- values (310507,4,4,2809196,56400)
-- values (310507,5,5,2809196,56400)
-- values (310507,6,6,2809196,56400)
-- values (310507,7,7,2809196,56400)
-- values (310507,8,8,2809196,56400)
-- values (310507,9,9,2809196,56400)
-- values (310507,10,10,2809196,56400)
-- values (310507,11,11,2809196,56400)
-- values (310507,12,12,2809196,56400)
-- select * from Tool_Assembly_Part_Plx 
-- Albion
-- values (300758,13,13,2794706,51168)
-- values (300758,14,14,2794706,51168)
-- values (300758,15,15,2794706,51168)
-- values (300758,16,16,2794706,51168)
-- values (300758,17,17,2794706,51168)
-- values (300758,18,18,2794706,51168)
-- values (300758,19,19,2794706,51168)
-- values (300758,20,20,2794706,51168)
-- values (300758,21,21,2794706,51168)
-- values (300758,22,22,2794706,51168)
-- values (300758,23,23,2794706,51168)
-- values (300758,24,24,2794706,51168)
-- values (300758,25,25,2794706,51168)
-- values (300758,26,26,2794706,51168)
-- values (300758,27,27,2794706,51168)
-- values (300758,28,28,2794706,51168)
select * from Tool_Assembly_Part_Plx

-- drop table Tool_Op_Part_Life_Plx 
-- truncate table Tool_Op_Part_Life_Plx
CREATE TABLE Tool_Op_Part_Life_Plx
(
	PCN	int NOT NULL,
	Tool_Op_Part_Life_Key int NOT NULL,	
	Tool_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Standard_Tool_Life	int NOT NULL,  -- Tool list value
	Assembly_Key int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Tool_Op_Part_Life_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Plex table';

-- drop table Tool_Op_Part_Life_X 
-- truncate table Tool_Op_Part_Life_X
CREATE TABLE Tool_Op_Part_Life_X
(
	PCN	int NOT NULL,
	Tool_Op_Part_Life_X_Key int NOT NULL,	
	Rework_Tool_Life int NOT NULL,  -- Plex table did not have this column
  	PRIMARY KEY (Plexus_Customer_No,Tool_Op_Part_Life_X_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='PlexX table';

CREATE TABLE Tool_Op_Part_Life_CNC_X
(
	PCN	int NOT NULL,
	Tool_Op_Part_Life_CNC_X_Key int NOT NULL,	
	Increment_By int NOT NULL,   -- How much to increment the tool counter every cycle
	Standard_Tool_Life int NOT NULL,  -- Initially this is the same for all CNC from the Tool List QuantityPerCuttingEdge, but we may want to change this value per CNC.  
	Rework_Tool_Life int NOT NULL,  -- Initially this is the same for all CNC from the Tool List QuantityPerCuttingEdge, but we may want to change this value per CNC.  
  	Current_Value int NOT NULL,
  	Last_Update datetime NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Tool_Op_Part_Life_CNC_X_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='PlexX table';


set @Last_Update = '2020-08-15 00:00:00';
insert into Tool_Op_Part_Life_CNC_X (Plexus_Customer_No,CNC_Part_Operation_Assembly_Tool_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key,Tool_Key,Increment_By,Tool_Life,Current_Value,Last_Update)
-- Albion
-- P558 LH Knuckles, CNC120
-- values (300758,20,3,2794706,51168,13,1,2,200,-1,@Last_Update )  -- vc1
-- values (300758,21,3,2794706,51168,14,14,2,200,-1,@Last_Update )  -- vc21
-- values (300758,22,3,2794706,51168,15,15,2,2500,-1,@Last_Update )  -- vc22
-- values (300758,23,3,2794706,51168,16,16,2,3000,-1,@Last_Update )  -- vc23
-- values (300758,24,3,2794706,51168,17,20,2,1800,-1,@Last_Update )  -- vc72
-- values (300758,25,3,2794706,51168,18,19,2,200,-1,@Last_Update )  -- VC33,CCMT 432MT TT7015 INSERT,COMBO ROUGH BORE-P558
-- values (300758,26,3,2794706,51168,18,18,2,1000,-1,@Last_Update )  -- VC34, CCMT 32.52 -M3 TK1501,COMBO ROUGH BORE-P558
-- values (300758,27,3,2794706,51168,19,17,2,350,-1,@Last_Update )  -- vc30
-- values (300758,28,3,2794706,51168,20,2,2,3000,-1,@Last_Update )  -- vc4
-- values (300758,29,3,2794706,51168,21,13,2,300,-1,@Last_Update )  -- vc15
-- values (300758,30,3,2794706,51168,22,6,2,2500,-1,@Last_Update )  -- vc7
-- values (300758,31,3,2794706,51168,23,3,2,200,-1,@Last_Update )  -- VC6,SHLT110408N-PH1 IN2005 INSERT,DATUM L ROUGH BORE & C'BORE
-- values (300758,32,3,2794706,51168,23,5,2,200,-1,@Last_Update )  -- VC66,SHLT140516N-FS IN1030 INSERT,DATUM L ROUGH BORE & C'BORE
-- values (300758,33,3,2794706,51168,24,7,2,3000,-1,@Last_Update )  -- vc9
-- values (300758,34,3,2794706,51168,25,7,2,3000,-1,@Last_Update )  -- vc8
-- values (300758,35,3,2794706,51168,26,8,2,18000,-1,@Last_Update )  -- vc12
-- values (300758,36,3,2794706,51168,27,10,2,800,-1,@Last_Update )  -- vc13
-- values (300758,37,3,2794706,51168,28,11,2,5000,-1,@Last_Update )  -- vc14
-- Avilla
-- RDX, CNC 103
set @Last_Update = '2020-08-15 00:00:00';
insert into Tool_Op_Part_Life_CNC_X (Plexus_Customer_No,CNC_Part_Operation_Assembly_Tool_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key,Tool_Key,Increment_By,Tool_Life,Current_Value,Last_Update)
-- values (310507,1,1,2809196,56400,1,29,2,40000,-1,@Last_Update)
-- values (310507,2,1,2809196,56400,2,30,2,5000,-1,@Last_Update)
-- values (310507,3,1,2809196,56400,3,21,2,5000,-1,@Last_Update)
-- values (310507,4,1,2809196,56400,4,31,2,40000,-1,@Last_Update)
-- values (310507,5,1,2809196,56400,5,22,2,5000,-1,@Last_Update)
-- values (310507,6,1,2809196,56400,6,32,2,40000,-1,@Last_Update)
-- values (310507,7,1,2809196,56400,7,23,2,5000,-1,@Last_Update)  -- VC44,CCC-32503-010/PCD spotface insert for 21mm drill
-- values (310507,8,1,2809196,56400,7,24,2,5000,-1,@Last_Update)  -- VC4,HH-32503-21-AL drill tip for 21mm drill
-- values (310507,9,1,2809196,56400,8,25,2,10000,-1,@Last_Update)
-- values (310507,10,1,2809196,56400,9,33,2,40000,-1,@Last_Update)
-- values (310507,11,1,2809196,56400,10,26,2,10000,-1,@Last_Update)
-- values (310507,12,1,2809196,56400,11,27,2,10000,-1,@Last_Update)
-- values (310507,13,1,2809196,56400,12,28,2,10000,-1,@Last_Update)
select * from CNC_Part_Operation_Assembly_Tool_V2

/*
 * UDP Datagrams sent from Moxa units.
 * Common variablies used as assembly counters are identified by an CNC_Part_Operation_Key, Set_No, and Block_No 
 * when sent to the UDP server.  This table links the assembly counter value to a Tool_Assembly_Part record.
 */
-- UPDATE ASSEMBLY KEY AFTER TOOLING UPLOAD
-- drop table CNC_Part_Operation_Set_Block_V2 
CREATE TABLE Tool_Op_Part_Life_CNC_Set_Block_X (
	Plexus_Customer_No int,
	CNC_Part_Operation_Set_Block_Key int NOT NULL,   -- each CNC_Part_Operation_Key, Set_No, Block_No combination maps to 1 CNC, Part, Part_Operation, Assembly_Key pair.
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Part_Operation_Key int NOT NULL, -- I had the operation_key here but this will give access to more information as well as the operation_key.
	Set_No int NOT NULL,  -- Can't avoid this Set_No because of the way the Moxa receives messages from the Okuma's serial port.
	Block_No int NOT NULL,  -- This is just an index to identify which 10-byte block in a datagram set. 
	Assembly_Key int NOT NULL, -- foreign key
	Tool_Key int NOT NULL, -- foreign key  -- V2 ADDITION used to take into consideration Tool assemblies with multiple cutting tools.
  	PRIMARY KEY (Plexus_Customer_No,CNC_Part_Operation_Set_Block_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='UDP Datagrams sent from Moxa units';
-- select * from CNC_Part_Operation_Set_Block_V2  order by CNC_Key,Set_No,Block_No
-- insert into Tool_BOM (Tool_BOM_Key,Tool_Key,Assembly_Key,Quantity_Required,QuantityPerCuttingEdge)  
-- values (5,5,23,2,200)  -- Alternate Tool; Obsolete in Plex so delete it; If there are more of these tools they could be used.
-- delete from Tool_BOM where Tool_BOM_Key = 5;

-- values (21,20,17,1,1800)
-- truncate table CNC_Part_Operation_Set_Block_V2
insert into Tool_Op_Part_Life_CNC_Set_Block_X (Plexus_Customer_No,CNC_Part_Operation_Set_Block_Key,CNC_Key,Part_Key,Operation_Key,Set_No,Block_No,Assembly_Key,Tool_Key)
 -- Avilla
-- values (310507,1,1,2809196,56400,1,1,1,29)
-- values (310507,2,1,2809196,56400,1,2,2,30)
-- values (310507,3,1,2809196,56400,1,3,3,21)  -- Insert,TCGT 32.52 FL K10, for 85.24MM ROUGH BORE 
-- values (310507,4,1,2809196,56400,1,4,3,34)  -- Boring Bar,CCC-32505-100, for 85.24MM ROUGH BORE
-- values (310507,5,1,2809196,56400,1,5,4,31)
-- values (310507,6,1,2809196,56400,1,6,5,22)
-- values (310507,7,1,2809196,56400,1,7,6,32)
-- values (310507,8,1,2809196,56400,1,8,7,23)  -- VC44, spotface insert for 21mm drill
-- values (310507,9,1,2809196,56400,1,9,7,24)  -- VC4, drill tip for 21mm drill
-- values (310507,10,1,2809196,56400,2,1,8,25)
-- values (310507,11,1,2809196,56400,2,2,9,33)
-- values (310507,12,1,2809196,56400,2,3,10,26)
-- values (310507,13,1,2809196,56400,2,4,11,27)
-- values (310507,14,1,2809196,56400,2,5,12,28)
-- delete from CNC_Part_Operation_Set_Block_V2 where CNC_Part_Operation_Set_Block_Key < 15
-- Albion
-- delete from CNC_Part_Operation_Set_Block_V2 where Plexus_Customer_No = 300758
-- P558 LH Knuckles
-- values (300758,20,3,2794706,51168,1,1,13,1)
-- values (300758,21,3,2794706,51168,1,2,14,14)
-- values (300758,22,3,2794706,51168,1,3,15,15)
-- values (300758,23,3,2794706,51168,1,4,16,16)
-- values (300758,24,3,2794706,51168,1,5,17,20)
-- values (300758,25,3,2794706,51168,1,6,18,19) -- VC33
-- values (300758,26,3,2794706,51168,1,7,18,18) -- different tool lifes. Not an alternate of VC33. tHIS IS VC34
-- values (300758,27,3,2794706,51168,1,8,19,17)
-- values (300758,28,3,2794706,51168,1,9,20,2)
-- 100 bytes
-- values (300758,29,3,2794706,51168,2,1,21,13)
-- values (300758,30,3,2794706,51168,2,2,22,6)
-- values (300758,31,3,2794706,51168,2,3,23,3)  
-- values (300758,32,3,2794706,51168,2,4,23,5) -- 2 cutters but the same tool life; send the same common variable twice.
-- values (300758,33,3,2794706,51168,2,5,24,7)
-- 160 bytes now start over
-- values (300758,34,3,2794706,51168,3,1,25,7)
-- values (300758,35,3,2794706,51168,3,2,26,8)
-- values (300758,36,3,2794706,51168,3,3,27,10)
-- values (300758,37,3,2794706,51168,3,4,28,11)
-- 60/100 bytes

-- delete from CNC_Part_Operation_Set_Block_V2 where CNC_Part_Operation_Set_Block_Key = 32 

-- DELETED VALUES
-- values (22,3,2794706,51168,2,1,21,12)  -- THIS IS AN ALTERNATE SO DELETE IT
-- values (30,3,2794706,51168,3,4,26,9) -- THIS IS AN ALTERNATE SO DELETE IT

select * from Tool_Op_Part_Life_CNC_Set_Block_X

/*
 * subset of Plex Tool_Life table
 * This is a tool life history table
 */
/*
CREATE TABLE Tool_Life 
(
	PCN int,
	Tool_Life_Key	int,
	Timeblock_Key	int,  -- Will give us start and end dates for the tool. 							
	Tool_Key	int,							
	CNC_Key int, -- needed because our Workcenters have multiple CNC. NOT A PLEX COLUMN.							
	Workcenter_Key	int,  -- This will allow us to group all CNC in a work area.  Technically not needed but it is a Plex column.
	Part_Key	int,							
	Part_Operation_Key	int,	-- I had the operation_key here but this will give access to more information as well as the operation_key.						
	Run_Date	datetime,	-- Start date. Record created at time of tool change of previous tool set.				
	Run_Quantity	int,	-- Actual tool life for tool set if this is .					
	Regrind_Count int	-- The number of regrinds currently on the Tool Assembly.  NOT A PLEX COLUMN.
)
-- This is tool life history


CREATE TABLE Time_Block
(
	Plexus_Customer_No int,
	Timeblock_Key	int,
	Start_Date	datetime,
	End_Date	datetime -- Not in the original table.

)
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

