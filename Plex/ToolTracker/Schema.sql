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
-- truncate table Tool_Var_Map;
CREATE TABLE Tool_Var_Map 
(
	Tool_Var_Map_Key int NOT NULL, -- unique but not the primary key
	Plexus_Customer_No int NOT NULL,
	CNC_Approved_Workcenter_Key int NOT NULL,  -- Must be unique but is not the primary key.
	Tool_Var int NOT NULL,
	Assembly_Key int NOT NULL,
	Tool_Key int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,CNC_Approved_Workcenter_Key,Tool_Var)  -- this must be unique
)
select Assembly_No,Assembly_Key from Part_v_Tool_Assembly where Plexus_Customer_No = 310507 order by Assembly_Key 
insert into Tool_Var_Map (Tool_Var_Map_Key,Plexus_Customer_No,CNC_Approved_Workcenter_Key,Tool_Var,Assembly_Key,Tool_Key)
values
-- Avilla
(1,310507,3,10,1,29),  -- T10,16680
(2,310507,3,11,2,30),  -- T11,12623
-- select awc.*,po.Operation_Key from CNC_Approved_Workcenter awc inner join Part_v_Part_Operation po on awc.Part_Operation_Key=po.Part_Operation_Key
(3,310507,3,1,3,21),  -- VC1,008431,Insert,TCGT 32.52 FL K10, for 85.24MM ROUGH BORE 
(4,310507,3,21,3,34),  -- VC21,16410,Boring Bar,CCC-32505-100, for 85.24MM ROUGH BORE

(5,310507,3,12,4,31),  -- T12,16409
(6,310507,3,2,5,22),  -- T2,007221
(7,310507,3,13,6,32),  -- T13,16407

(8,310507,3,4,7,24),  -- VC4,16406,HH-32503-21-AL, helmet heat insert,drill tip, for 21mm drill
(9,310507,3,44,7,23),  -- VC44,16405,CCC-32503-010/PCD,spotface insert for 21mm drill

(10,310507,3,5,8,25),  -- T5,16461
(11,310507,3,16,9,33),  -- T16,16408
(12,310507,3,7,10,26), -- T7,16110
(13,310507,3,8,11,27), -- T8,16111
(14,310507,3,9,12,28),  -- T9,16130
-- select b.Assembly_Key,t.* from Part_v_Tool_BOM b inner join Part_v_Tool t on b.Tool_Key=t.Tool_Key where Tool_No = '008435'
-- Albion
-- P558 LH Knuckles
 (20,300758,2,1,13,1),  -- T1,009196
 (21,300758,2,21,14,14), -- T21,17022
 (22,300758,2,22,15,15),  -- T22,14710 
 (23,300758,2,23,16,16),  -- T23,0000951
 (24,300758,2,72,17,20),  -- T72,14855
 (25,300758,2,33,18,19),  -- VC33,15843,CCMT 432MT TT7015 INSERT
 (26,300758,2,34,18,18),  -- VC34,010559,CCMT 32.52 -M3 TK1501,different tool lifes. Not an alternate of VC33. tHIS IS VC34
 (27,300758,2,30,19,17),  -- T30,16547
 (28,300758,2,4,20,2),   -- T4,17100
-- 100 bytes
 (29,300758,2,15,21,13),  -- T15,13753
 (30,300758,2,7,22,6),  -- T7,008485
 (31,300758,2,6,23,3),  -- VC6,009240,SHLT110408N-PH1 IN2005,DATUM L ROUGH BORE & C'BORE 
 (32,300758,2,66,23,5),  -- VC66,008318,SHLT140516N-FS IN1030 INSERT,Alternate=15721,DATUM L ROUGH BORE & C'BORE
 (33,300758,2,9,24,7),  -- T9,007864
-- 160 bytes now start over
 (34,300758,2,8,25,7),  -- T8,007864
 (35,300758,2,12,26,8),  -- T12,010338,'CCC-23575 REV A'
 (36,300758,2,13,27,10),  -- T13,0003396
 (37,300758,2,14,28,11)  -- T14,008435
-- 60/100 bytes
select * from Tool_Var_Map order by Tool_Var_Map_Key 


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
	CNC_Tool_No int NOT NULL,  -- NOT IN PLEX, THIS IS THE NUMBER RETURN BY OKUMA VC31.
	Description	varchar (100) NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Assembly_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Assembly';
insert into Part_v_Tool_Assembly (Plexus_Customer_No,Assembly_Key,Assembly_No,CNC_Tool_No,Description)
values
-- Avilla
-- RDX, cnc 103
(310507,1,'T10',10,'86.925MM FINISH BORE'),
(310507,2,'T11',11,'ETCHER'),
(310507,3,'T01',1,'85.24MM ROUGH BORE'),
(310507,4,'T12',12,'86.125MM PRE FINISH BORE'),
(310507,5,'T02',2,'1.25" HELICAL MILL'),
(310507,6,'T13',13,'180MM BACK CUTTER RH PART ONLY'),
(310507,7,'T04',4,'21MM DRILL/SPOTFACE'),
(310507,8,'T05',5,'10MM END MILL'),
(310507,9,'T16',16,'135MM BACK CUTTER RH ONLY'),
(310507,10,'T07',7,'8.2MM DRILL'),
(310507,11,'T08',8,'14.3MM DRILL/CHAMFER'),
(310507,12,'T09',9,'15.5MM DRILL/CHAMFER'),

-- Albion
-- P558 LH Knuckles
(300758,13,'T01',1,'3IN FACE MILL'),
(300758,14,'T21',21,'2.5IN FACE MILL'),
(300758,15,'T22',22,'M6 DRILL'),
(300758,16,'T23',23,'M6 X 1.0 TAP'),
(300758,17,'T72',72,'DRILL FACE HOLES'),
(300758,18,'T33',33,'ROUGH MULTI BORE'),
(300758,19,'T30',30,'FINISH CENTER BORE'),
(300758,20,'T4',4,'FACE & DRILL CALIPER HOLES'),
(300758,21,'T15',15,'1.937 ROUGH DRILL J BORE'),
(300758,22,'T7',7,'DATUM J BACK FACE'),
(300758,23,'T6',6,'DATUM L ROUGH BORE'),
(300758,24,'T9',9,'FINISH DATUM L'),
(300758,25,'T8',8,'FINISH DATUM J'),
(300758,26,'T12',12,'TAPER REAM ONE SIDE'),
(300758,27,'T13',13,'MILL PADS AND STOP'),
(300758,28,'T14',14,'CHAMFER HOLES');
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
(300758,3,'009240',30048,'SHLT110408N-PH1 IN2005',1,0,8.780000), -- VC6
(300758,4,'15721',30048,'SHLT140516N-FS IN2005',1,0,12.570000), -- Shown as an alternate in the Tool List for 008318
(300758,5,'008318',30048,'SHLT140516N-FS IN1030',1,0,10.950000), -- VC66 2nd tool for T06. Shown as replacing 15721 in Plex 
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

select * from Part_v_Tool pvt 

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

-- drop table Tool_BOM_Alternate_In_Use_V2
-- truncate table Tool_BOM_Alternate_In_Use_V2
CREATE TABLE Tool_BOM_Alternate_In_Use_V2 (
	Tool_BOM_Alternate_In_Use_Key int AUTO_INCREMENT ,  -- UNIQUE KEY BUT NOT THE PRIMARY 
	Plexus_Customer_No int NOT NULL, 
	CNC_Approved_Workcenter_Key int NOT NULL,  
	Assembly_Key int NOT NULL,  
	Primary_Tool_Key int NOT NULL,  
	Alternate_Tool_Key int NOT NULL, 
	Quantity_In_Use int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,CNC_Approved_Workcenter_Key,Assembly_Key,Primary_Tool_Key),
  	KEY (Tool_BOM_Alternate_In_Use_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Indicates if an Alternate is currently being used';
insert into Tool_BOM_Alternate_In_Use_V2 (Plexus_Customer_No,CNC_Approved_Workcenter_Key,Assembly_Key,Primary_Tool_Key,Alternate_Tool_Key,Quantity_In_Use) 
values
-- (300758,2,21,13,12,1) -- Alternate Tool for T15 is in use;
select * from Tool_BOM_Alternate_In_Use_V2
-- select * from CNC_Approved_Workcenter 
-- select * from CNC 


/*
 * One tool assembly can be used for many part operations.
 */
-- drop table Part_v_Tool_Assembly_Part
-- truncate table Part_v_Tool_Assembly_Part
-- NEEDS UPDATED AFTER PLEX TOOLING MODULE UPLOAD
CREATE TABLE Part_v_Tool_Assembly_Part (
	Plexus_Customer_No int NOT NULL,
	Tool_Assembly_Part_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Part_Key int NOT NULL,
	Part_Operation_Key int NOT NULL, -- NOT A Plex column.  This is part of the standard information we collect for all Times and Tool Lifes.
	Operation_Key int NOT NULL,
  	Machining_Time int NOT NULL, -- NOT A Plex Column. In seconds. How long to finish the the Assemply operation
  	PRIMARY KEY (Plexus_Customer_No,Tool_Assembly_Part_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Assembly_Part';
insert into Part_v_Tool_Assembly_Part (Plexus_Customer_No,Tool_Assembly_Part_Key,Assembly_Key,Part_Key,Part_Operation_Key,Operation_Key,Machining_Time)
values
-- Avilla
(310507,1,1,2809196,7917723,56400,-1),
(310507,2,2,2809196,7917723,56400,-1),
(310507,3,3,2809196,7917723,56400,-1),
(310507,4,4,2809196,7917723,56400,-1),
(310507,5,5,2809196,7917723,56400,-1),
(310507,6,6,2809196,7917723,56400,-1),
(310507,7,7,2809196,7917723,56400,-1),
(310507,8,8,2809196,7917723,56400,-1),
(310507,9,9,2809196,7917723,56400,-1),
(310507,10,10,2809196,7917723,56400,-1),
(310507,11,11,2809196,7917723,56400,-1),
(310507,12,12,2809196,7917723,56400,-1),
-- select * from Part_v_Tool_Assembly_Part 
-- Albion
(300758,13,13,2794706,7874404,51168,-1),
(300758,14,14,2794706,7874404,51168,-1),
(300758,15,15,2794706,7874404,51168,-1),
(300758,16,16,2794706,7874404,51168,-1),
(300758,17,17,2794706,7874404,51168,-1),
(300758,18,18,2794706,7874404,51168,-1),
(300758,19,19,2794706,7874404,51168,-1),
(300758,20,20,2794706,7874404,51168,-1),
(300758,21,21,2794706,7874404,51168,-1),
(300758,22,22,2794706,7874404,51168,-1),
(300758,23,23,2794706,7874404,51168,-1),
(300758,24,24,2794706,7874404,51168,-1),
(300758,25,25,2794706,7874404,51168,-1),
(300758,26,26,2794706,7874404,51168,-1),
(300758,27,27,2794706,7874404,51168,-1),
(300758,28,28,2794706,7874404,51168,-1)
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
	Workcenter_Key int,  
	Part_Operation_Key int NOT NULL, 
	CNC_Key int NOT NULL, -- foriegn key,
	Increment_By int NOT NULL,   -- How much to increment the tool counter every cycle
	Standard_Tool_Life int NOT NULL,  -- Initially this is the same for all CNC from the Tool List QuantityPerCuttingEdge, but we may want to change this value per CNC.  
  	Current_Value int NOT NULL, -- The common variable value for tool change alerts.
  	Running_Total int NOT NULL,  -- The running total to see how many parts have been machined.
  	Last_Update datetime NOT NULL,
  	PRIMARY KEY (Tool_Op_Part_Life_Key,Workcenter_key,Part_Operation_Key,CNC_Key)  -- This has to be unique
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='PlexX table';
set @Last_Update = '2020-08-15 00:00:00';
insert into CNC_Tool_Op_Part_Life (CNC_Tool_Op_Part_Life_Key,Tool_Op_Part_Life_Key,Workcenter_Key,Part_Operation_Key,CNC_Key,
Increment_By,Standard_Tool_Life,Current_Value,Running_Total,Last_Update)
values
-- select * from Part_v_Approved_Workcenter
-- select * from Part_v_Part_Operation
-- select * from Part_v_Tool_Op_Part_Life 
-- Albion
-- P558 LH Knuckles, CNC120
(20,20,61090,7874404,3,2,200,-1,-1,@Last_Update),  -- vc1
(21,21,61090,7874404,3,2,200,-1,-1,@Last_Update),  -- vc21
(22,22,61090,7874404,3,2,2500,-1,-1,@Last_Update),  -- vc22
(23,23,61090,7874404,3,2,3000,-1,-1,@Last_Update),  -- vc23
(24,24,61090,7874404,3,2,1800,-1,-1,@Last_Update),  -- vc72
(25,25,61090,7874404,3,2,200,-1,-1,@Last_Update),  -- VC33,CCMT 432MT TT7015 INSERT,COMBO ROUGH BORE-P558
(26,26,61090,7874404,3,2,1000,-1,-1,@Last_Update),  -- VC34, CCMT 32.52 -M3 TK1501,COMBO ROUGH BORE-P558
(27,27,61090,7874404,3,2,350,-1,-1,@Last_Update),  -- vc30
(28,28,61090,7874404,3,2,3000,-1,-1,@Last_Update),  -- vc4
(29,29,61090,7874404,3,2,300,-1,-1,@Last_Update),  -- vc15  Alternate tool
(30,30,61090,7874404,3,2,300,-1,-1,@Last_Update),  -- vc15
(31,31,61090,7874404,3,2,2500,-1,-1,@Last_Update),  -- vc7
(32,32,61090,7874404,3,2,200,-1,-1,@Last_Update),  -- VC6,SHLT110408N-PH1 IN2005 INSERT,DATUM L ROUGH BORE & C'BORE
(33,33,61090,7874404,3,2,200,-1,-1,@Last_Update),  -- Alternate, Don't know if it is an alternate for vc6 or vc66.
(34,34,61090,7874404,3,2,200,-1,-1,@Last_Update),  -- VC66,SHLT140516N-FS IN1030 INSERT,DATUM L ROUGH BORE & C'BORE
(35,35,61090,7874404,3,2,3000,-1,-1,@Last_Update),  -- vc9
(36,36,61090,7874404,3,2,3000,-1,-1,@Last_Update),  -- vc8
(37,37,61090,7874404,3,2,18000,-1,-1,@Last_Update),  -- vc12
(38,38,61090,7874404,3,2,18000,-1,-1,@Last_Update),  -- vc12 Alternate tool
(39,39,61090,7874404,3,2,800,-1,-1,@Last_Update),  -- vc13
(40,40,61090,7874404,3,2,5000,-1,-1,@Last_Update),  -- vc14
-- Avilla
-- RDX, CNC 103
-- select * from Part_v_Approved_Workcenter
-- select * from Part_v_Part_Operation

(1,1,61324,7917723,1,2,40000,-1,-1,@Last_Update),
(2,2,61324,7917723,1,2,5000,-1,-1,@Last_Update),
(3,3,61324,7917723,1,2,5000,-1,-1,@Last_Update),  -- VC1,Insert,TCGT 32.52 FL K10, for 85.24MM ROUGH BORE 
(4,4,61324,7917723,1,2,40000,-1,-1,@Last_Update), --  VC21, Boring Bar,CCC-32505-100, for 85.24MM ROUGH BORE
(5,5,61324,7917723,1,2,40000,-1,-1,@Last_Update),
(6,6,61324,7917723,1,2,5000,-1,-1,@Last_Update),
(7,7,61324,7917723,1,2,40000,-1,-1,@Last_Update),
(8,8,61324,7917723,1,2,5000,-1,-1,@Last_Update),  --  VC44,CCC-32503-010/PCD spotface insert for 21mm drill.
(9,9,61324,7917723,1,2,5000,-1,-1,@Last_Update),  -- VC4,HH-32503-21-AL drill tip for 21mm drill
(10,10,61324,7917723,1,2,10000,-1,-1,@Last_Update),
(11,11,61324,7917723,1,2,40000,-1,-1,@Last_Update),
(12,12,61324,7917723,1,2,10000,-1,-1,@Last_Update),
(13,13,61324,7917723,1,2,10000,-1,-1,@Last_Update),
(14,14,61324,7917723,1,2,10000,-1,-1,@Last_Update)

select * from CNC_Tool_Op_Part_Life where CNC_Key = 3-- 35 = 32 primary tools plus 3 alts
select * from CNC

	set @pCNC_Approved_Workcenter_Key = 2;
	-- set @pTool_Var = 1;  -- Assembly_Key = 13, tool_Key = 1
	-- set @pTool_Var = 12; -- REWORK Primary_tool_key 8,Alternate_Tool_Key = 9
	-- set @pTool_Var = 22; -- REWORK tool_key 15
	set @pTool_Var = 15; -- alt in use  Alternate_Tool_Key=12,Primary_Tool_key 13
	set @pCurrent_Value = 11;
	set @pRunning_Total = 22;
	set @pLast_Update = '2020-11-11 11:11:11';
	set @pCNC_Approved_Workcenter_Key = 2;
call UpdateCNCToolOpPartLifeV2(@pCNC_Approved_Workcenter_Key,@pTool_Var,@pCurrent_Value,@pRunning_Total,@pLast_Update,@pReturnValue);
select @pReturnValue;
select pl.Assembly_Key,pl.Tool_Key,cpl.*
from  Part_v_Tool_Op_Part_Life pl
inner join CNC_Tool_Op_Part_Life cpl
on pl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key -- 1 to 1
-- where pl.Tool_Key = 1  -- @pTool_Var = 1
-- where pl.Tool_Key = 9  -- @pTool_Var = 12
-- where pl.Tool_Key = 15  -- @pTool_Var = 22
 where pl.Tool_Key = 12  -- @pTool_Var = 15


-- truncate table Assembly_Machining_History
select * from Assembly_Machining_History amh 


-- drop procedure UpdateCNCToolOpPartLifeV2;
CREATE PROCEDURE UpdateCNCToolOpPartLifeV2(
	IN pCNC_Approved_Workcenter_Key INT,  
	IN pTool_Var INT,
	IN pCurrent_Value INT,
	IN pRunning_Total INT,
	IN pLast_Update datetime,
	OUT pReturnValue INT 
)
BEGIN
	DECLARE Plexus_Customer_No INT DEFAULT 0;
	DECLARE Workcenter_Key int DEFAULT 0;
	DECLARE CNC_Key int DEFAULT 0;
	DECLARE Part_Operation_Key int DEFAULT 0;
	DECLARE Tool_Key int DEFAULT 0;
	DECLARE Primary_Tool_Key int DEFAULT 0;
	DECLARE Alternate_Tool_Key int DEFAULT 0;
	DECLARE Regrind_Tool_Key int DEFAULT 0;
	DECLARE Assembly_Key int DEFAULT 0;
	-- set @pCNC_Approved_Workcenter_Key = 2;
	-- set @pTool_Var = 1;  -- Assembly_Key = 13
	-- set @pTool_Var = 12; -- REWORK Primary_tool_key 8,Alternate_Tool_Key = 9
	-- set @pTool_Var = 22; -- REWORK tool_key 15
	-- set @pTool_Var = 15; -- alt in use  Alternate_Tool_Key=12,Primary_Tool_key 13
	-- set @pCurrent_Value = 12;
	-- set @pRunning_Total = 24;
	-- set @pLast_Update = '2020-08-28 10:15:49';
	-- set @pCNC_Approved_Workcenter_Key = 2;
	-- select * from Tool_Var_Map tv 
	-- select * from Part_v_Tool_BOM
    -- select * from Tool_Inventory_In_Use_V2 
    -- select * from Tool_BOM_Alternate_In_Use_V2
	select caw.Plexus_Customer_No,caw.Workcenter_Key,caw.CNC_Key,caw.Part_Operation_Key,tv.Assembly_Key,tv.Tool_Key,aiu.Alternate_Tool_Key,tiu.In_Use_Tool_Key 
	into Plexus_Customer_No,Workcenter_Key,CNC_Key,Part_Operation_Key,Assembly_Key,Primary_Tool_Key,Alternate_Tool_Key,Regrind_Tool_Key
	from CNC_Approved_Workcenter caw 
	inner join Tool_Var_Map tv 
	on caw.Plexus_Customer_No = tv.Plexus_Customer_No  -- 
	and caw.CNC_Approved_Workcenter_Key = tv.CNC_Approved_Workcenter_Key  -- 1 to many
	left outer join Tool_BOM_Alternate_In_Use_V2 aiu 
	on caw.Plexus_Customer_No = aiu.Plexus_Customer_No 
	and caw.CNC_Approved_Workcenter_Key = aiu.CNC_Approved_Workcenter_Key 
	and tv.Assembly_Key = aiu.Assembly_Key 
	and tv.Tool_Key = aiu.Primary_Tool_Key -- 1 to 1/0
	left outer join Tool_Inventory_In_Use_V2 tiu 
	on caw.Plexus_Customer_No = tiu.Plexus_Customer_No 
	and caw.CNC_Approved_Workcenter_Key = tiu.CNC_Approved_Workcenter_Key 
	and tv.Assembly_Key = tiu.Assembly_Key 
	and tv.Tool_Key = tiu.Primary_Tool_Key -- 1 to 1/0
	-- where caw.CNC_Approved_Workcenter_Key=@pCNC_Approved_Workcenter_Key 
    -- and tv.Tool_Var = @pTool_Var;
	where caw.CNC_Approved_Workcenter_Key=pCNC_Approved_Workcenter_Key 
    and tv.Tool_Var = pTool_Var;

	SET Tool_Key = CASE
    WHEN Alternate_Tool_Key IS NOT NULL THEN Alternate_Tool_Key
    WHEN Regrind_Tool_Key IS NOT NULL THEN Regrind_Tool_Key
    ELSE Primary_Tool_Key
    END;	
   
	-- select Plexus_Customer_No,Workcenter_Key,CNC_Key,Part_Operation_Key,Assembly_Key,Primary_Tool_Key,Alternate_Tool_Key,Regrind_Tool_Key;
    UPDATE 
    -- select  cpl.*
      	-- set cpl.Current_Value = @pCurrent_Value,
  	-- cpl.Last_Update = @pLast_Update
	-- where caw.CNC_Approved_Workcenter_Key=@pCNC_Approved_Workcenter_Key 
    -- and bl.Set_No = @pSet_No and bl.Block_No = @pBlock_No;
    Part_v_Tool_Op_Part_Life pl
	inner join CNC_Tool_Op_Part_Life cpl
	on pl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key -- 1 to 1
  	-- set cpl.Current_Value = @pCurrent_Value,
  	set cpl.Current_Value = pCurrent_Value,
  	-- cpl.Running_Total = @pRunning_Total,
  	-- cpl.Last_Update = @pLast_Update
  	cpl.Running_Total = pRunning_Total,
  	cpl.Last_Update = pLast_Update
	where pl.PCN = Plexus_Customer_No
	and cpl.Workcenter_Key = Workcenter_Key
	and cpl.CNC_Key = CNC_Key
	and cpl.Part_Operation_Key =  Part_Operation_Key
	and pl.Assembly_Key = Assembly_Key
	and pl.Tool_Key = Tool_Key; 


    set pReturnValue = 0;

end;   
   
	
/*
 * Keep track of specific info on each regrind-able tool.
 * Ben will update the regrind count and expected tool life through a Plex,moto, or mach2 screen.  
 */
-- drop table Part_v_Tool_Inventory
-- truncate table Part_v_Tool_Inventory
CREATE TABLE Part_v_Tool_Inventory
( 
	Plexus_Customer_No int NOT NULL,
	Tool_Serial_Key	int NOT NULL,
	Tool_Serial_No	varchar (50) NOT NULL,
	Tool_Key int NOT NULL,  -- 1 tool_key to many tool_serial_key
	Regrind_Count int NOT NULL, -- NOT A PLEX COLUMN. How many times it has been reground. Might be able to use a column in Tool_Inventory_Attributes 
	Recommended_Tool_Life int NOT NULL, -- NOT A PLEX COLUMN. Initially this is set to the Standard_Tool_Life, but then it is maintained by Ben Maynus.
  	PRIMARY KEY (Plexus_Customer_No,Tool_Serial_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Subset of plex part_v_tool_inventory view';
insert into Part_v_Tool_Inventory (Plexus_Customer_No,Tool_Serial_Key,Tool_Serial_No,Tool_Key,Regrind_Count,Recommended_Tool_Life )
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
-- drop table Tool_Inventory_In_Use_V2
CREATE TABLE Tool_Inventory_In_Use_V2 
(
	Plexus_Customer_No int NOT NULL,
	Tool_Serial_Key int NOT NULL,  -- THIS IS A UNIQUE KEY, BUT NOT THE PRIMARY KEY
	CNC_Approved_Workcenter_Key int NOT NULL,
	Assembly_Key int NOT NULL,  
	Primary_Tool_Key int NOT NULL,
	In_Use_Tool_Key int NOT NULL,  -- This could be an alternate tool.
  	PRIMARY KEY (Plexus_Customer_No,CNC_Approved_Workcenter_Key,Assembly_Key,Primary_Tool_Key),  -- Only 1 tool_key for each CNC_Approved_Work_Center,Assembly_Key,Primary_Tool_Key combo
  	KEY (Tool_Serial_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Maps a regrind-able tool to a CNC assembly';
insert into Tool_Inventory_In_Use_V2 (Plexus_Customer_No,Tool_Serial_Key,CNC_Approved_Workcenter_Key,Assembly_Key,Primary_Tool_Key,In_Use_Tool_Key)
values
-- Albion
-- P558 LH Knuckles, CNC120
(300758,1,2,20,2,2),-- T04
(300758,3,2,26,8,8),-- This is an alternate tool for T12,Tool_Assembly_Key = 26
-- (300758,3,2,26,8,9),-- This is an alternate tool for T12,Tool_Assembly_Key = 26
-- select * from Tool_BOM_Alternate
-- select * from Part_v_Tool_BOM
(300758,4,2,15,15,15), -- T22
(300758,5,2,17,20,20) -- T72
select * from Tool_Inventory_In_Use_V2 


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
-- Part_v_Tool_Life;
	set @pCNC_Approved_Workcenter_Key = 2;
	-- set @pTool_Var = 1;  -- Assembly_Key = 13, tool_Key = 1
	-- set @pTool_Var = 12; -- REWORK Primary_tool_key 8,Alternate_Tool_Key = 9
	-- set @pTool_Var = 22; -- REWORK tool_key 15
	 set @pTool_Var = 15; -- alt in use  Alternate_Tool_Key=12,Primary_Tool_key 13
	set @pRun_Quantity = 100;
	set @pRun_Date = '2020-09-05 09:50:00';
call InsToolLifeHistoryV2(@pCNC_Approved_Workcenter_Key,@pTool_Var,@pRun_Quantity,@pRun_Date,@pTool_Life_Key,@pReturnValue ); 
select 	@pTool_Life_Key,@pReturnValue;
-- truncate table Part_v_Tool_Life
select * from Part_v_Tool_Life
-- truncate table Assembly_Machining_History
select Pallet_No,Assembly_Key,Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh 
order by Assembly_Machining_History_Key desc
-- CREATE TABLE Part_v_Tool_Live_11_11 AS select * from Part_v_Tool_Life;
-- select * from Part_v_Tool_Live_11_11

select pl.Assembly_Key,pl.Tool_Key,cpl.Current_Value,cpl.Running_Total, cpl.*
from  Part_v_Tool_Op_Part_Life pl
inner join CNC_Tool_Op_Part_Life cpl
on pl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key -- 1 to 1
 where pl.Tool_Key = 1  -- @pTool_Var = 1
-- where pl.Tool_Key = 8  -- @pTool_Var = 12
-- where pl.Tool_Key = 15  -- @pTool_Var = 22
-- where pl.Tool_Key = 13  -- @pTool_Var = 15


-- truncate table Assembly_Machining_History
select * from Assembly_Machining_History amh 


/*
 * The only information we get from the CNC is a CNC_Approved_Workcenter_Key,Tool_Var,
 * so we have to use this info to link to get enough info to insert records into the Part_v_Tool_Life table
 * and to update the current_value and Last_Update column of Tool_Op_Part_Life_CNC.
 * The tool setter will have updated PlexX with the CNC,part,operation,assembly_no, and serial number of the
 * currently running tool for regrind-able tools.
 *
 */
	-- drop procedure InsToolLifeHistoryV2;
 CREATE PROCEDURE InsToolLifeHistoryV2
 ( 
 	IN pCNC_Approved_Workcenter_Key INT,
	IN pTool_Var INT,
	IN pRun_Quantity INT,
	IN pRun_Date datetime,
	OUT pTool_Life_Key INT,
	OUT pReturnValue INT 
) 
BEGIN 

/*
	set @pCNC_Approved_Workcenter_Key = 2;
	-- set @pTool_Var = 1;
	set @pTool_Var = 12; -- REWORK
	-- set @pTool_Var = 22; -- REWORK
	-- set @pTool_Var = 15; -- alt in use
	set @pRun_Date = '2020-09-05 09:50:00';
	set @pRun_Quantity = 100;
*/
	insert into Part_v_Tool_Life (PCN,Tool_Key,Tool_Serial_Key,Workcenter_Key,CNC_Key,Part_Key,Part_Operation_Key,Assembly_Key,Regrind_Count,Run_Quantity,Run_Date)
	select 
	caw.Plexus_Customer_No PCN,
	case 
	when riu.In_Use_Tool_Key is not NULL then riu.In_Use_Tool_Key 
	when iu.Alternate_Tool_Key is not NULL then iu.Alternate_Tool_Key 
	else tv.Tool_Key
	end Tool_Key,
	riu.Tool_Serial_Key,
	-- riu.Tool_Key,
	-- riu.Tool_Serial_Key,
	caw.Workcenter_Key,
	caw.CNC_Key,
	caw.Part_Key,
	caw.Part_Operation_Key, 
	tv.Assembly_Key, 
	ti.Regrind_Count,
	pRun_Quantity,
	pRun_Date
	-- pRun_Quantity,
	-- pRun_Date
	-- ti.Tool_Serial_Key, 
	-- bl.Tool_Key primary_tool_key,
	-- iu.Alternate_Tool_Key,
	-- riu.Primary_Tool_Key,
	-- select * from CNC_Approved_Workcenter
	-- select * from Tool_Var_Map tv 
	-- select * from Tool_BOM_Alternate_In_Use_V2 
	-- select * from Tool_Inventory_In_Use_V2
	-- select * from Part_v_Tool_Inventory
	--   PRIMARY KEY (`Plexus_Customer_No`,`CNC_Approved_Workcenter_Key`,`Primary_Tool_Key`,`Assembly_Key`)

	-- select *
	from CNC_Approved_Workcenter caw 
	inner join Tool_Var_Map tv 
	on caw.Plexus_Customer_No = tv.Plexus_Customer_No  -- 
	and caw.CNC_Approved_Workcenter_Key = tv.CNC_Approved_Workcenter_Key  -- 1 to many
	left outer join Tool_BOM_Alternate_In_Use_V2 iu -- An alt that is currently in the CNC
	on caw.Plexus_Customer_No=iu.Plexus_Customer_No
	and caw.CNC_Approved_Workcenter_Key = iu.CNC_Approved_Workcenter_Key 
	and tv.Tool_Key = iu.Primary_Tool_Key 
	and tv.Assembly_Key = iu.Assembly_Key  -- 1 to 1/0
	left outer join Tool_Inventory_In_Use_V2 riu -- regrind in use
	on caw.Plexus_Customer_No=riu.Plexus_Customer_No
	and caw.CNC_Approved_Workcenter_Key = riu.CNC_Approved_Workcenter_Key 
	and tv.Assembly_Key = riu.Assembly_Key  -- 1 to 1/0
	and tv.Tool_Key = riu.Primary_Tool_Key 
	left outer join Part_v_Tool_Inventory ti 
	on riu.Plexus_Customer_No=ti.Plexus_Customer_No
	and riu.Tool_Serial_Key = ti.Tool_Serial_Key -- 1 to 1
	-- where caw.CNC_Approved_Workcenter_Key=@pCNC_Approved_Workcenter_Key 
	-- and  tv.Tool_Var = @pTool_Var
	where caw.CNC_Approved_Workcenter_Key=pCNC_Approved_Workcenter_Key 
	and  tv.Tool_Var = pTool_Var;

	-- Display the last inserted row.
	set pTool_Life_Key = (select Tool_Life_Key from Part_v_Tool_Life where Tool_Life_Key =(SELECT LAST_INSERT_ID()));
	set pReturnValue = 0;
END;

select * from Part_v_Tool_Op_Part_Life;
select * from CNC_Tool_Op_Part_Life  -- 35 = 32 primary tools plus 3 alts
select * from CNC_Approved_Workcenter caw 
select * from Part_v_Operation pvo 
select Assembly_No,Description from Part_v_Tool_Assembly where Plexus_Customer_No = 300758 

set @CNC_Approved_Workcenter_Key = 2;
set @Set_No = 1;
set @Block_No = 1;
set @Current_Value = 19346;
set @Running_Total = 19400;
set @Last_Update = '2020-10-15 10:15:49';
-- CNC_Part_Operation_Key=1,Set_No=1,Block_No=1,Current_Value=18136,Last_Update=2020-08-25 10:38:27
-- "CNC_Part_Operation_Key":1,"Set_No":1,"Block_No":7,"Current_Value":29392,"Trans_Date":"2020-08-25 10:17:55"
-- select a.* from CNC_Part_Operation_Assembly a
CALL UpdateCNCToolOpPartLife(@CNC_Approved_Workcenter_Key,@Set_No,@Block_No,@Current_Value,@Running_Total,@Last_Update,@Return_Value);
	 -- UpdateCNCPartOperationAssemblyCurrentValue(?,?,?,?,?,@ReturnValue); select @ReturnValue as pReturnValue
SELECT @Return_Value;
select * from CNC_Tool_Op_Part_Life cpl where CNC_Key = 3 
select * from Part_v_Tool_Life pvtl 
select * from Part_v_Tool_Op_Part_Life cpl


*/

   
/*
 * History of assembly cutting times
 * This is meant to log individual assembly cutting times.
 */
-- drop table Assembly_Machining_History 
-- truncate table Assembly_Machining_History
CREATE TABLE Assembly_Machining_History (
	Assembly_Machining_History_Key int NOT NULL AUTO_INCREMENT,
	Plexus_Customer_No int,
	Workcenter_Key	int NOT NULL,  
	CNC_Key int NOT NULL,
	Pallet_No int NOT NULL,
	Part_Key int NOT NULL,
	Part_Operation_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Tool_Key int NOT NULL,
	Current_Value int NOT NULL,
	Running_Total int NOT NULL,
  	Start_Time datetime NOT NULL,  
  	End_Time datetime NOT NULL,  
  	Run_Time int NOT NULL, -- In seconds. 
  	PRIMARY KEY (Assembly_Machining_History_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='History of assembly Machining times';

-- select * from Assembly_Machining_History
set @CNC_Approved_Workcenter_Key = 2;
set @Pallet_No = 1;
set @Tool_Var = 1;
SET @Current_Value = 10;
set @Running_Total = 12;
set @Start_Time = '2020-10-25 09:50:00';
set @End_Time = '2020-10-25 09:50:50';
CALL InsAssemblyMachiningHistory(@CNC_Approved_Workcenter_Key,@Pallet_No,@Tool_Var,@Current_Value,@Running_Total,@Start_Time,@End_Time,@Assembly_Machining_History_Key,@Return_Value);
select @Assembly_Machining_History_Key,@Return_Value;
select * from Assembly_Machining_History

DROP PROCEDURE InsAssemblyMachiningHistory;
CREATE PROCEDURE InsAssemblyMachiningHistory
(
	IN pCNC_Approved_Workcenter_Key INT,  
	IN pPallet_No INT,
	IN pTool_Var INT,
	IN pCurrent_Value INT,
	IN pRunning_Total INT,
	IN pStart_Time datetime,
	IN pEnd_Time datetime,
	OUT pAssembly_Machining_History_Key INT,
	OUT pReturnValue INT 
)
BEGIN
  	-- This will be inserted when the Tool Assembly time starts
	insert into Assembly_Machining_History (Plexus_Customer_No,Workcenter_Key,CNC_Key,Pallet_No,Part_Key,Part_Operation_Key,Assembly_Key,Tool_Key,Current_Value,Running_Total,Start_Time,End_Time,Run_Time)
	
/*
	set @pCNC_Approved_Workcenter_Key = 2;
	set @pPallet_No = 1;
	set @pTool_Var = 1;
	set @pStart_Time = '2020-09-05 09:48:00';
	set @pEnd_Time = '2020-09-05 09:50:10';
*/
	select 
	caw.Plexus_Customer_No,
	caw.Workcenter_Key,
	caw.CNC_Key,
	pPallet_No Pallet_No,
	-- @pPallet_No,
	caw.Part_Key,
	caw.Part_Operation_Key,
	tv.Assembly_Key,
	tv.Tool_Key,
	pCurrent_Value Current_Value,  -- Just changed this 11/14 not tested
	pRunning_Total Running_Total, -- Just changed this 11/14 not tested
	pStart_Time Start_Time,
	pEnd_Time End_Time,
	TIMESTAMPDIFF(SECOND, pStart_Time, pEnd_Time) Run_Time 
	--  @pStart_Time Start_Time,
	-- @pEnd_Time End_Time,
	-- TIMESTAMPDIFF(SECOND, @pStart_Time, @pEnd_Time) Run_Time 
   	from CNC_Approved_Workcenter caw 
	inner join Tool_Var_Map tv 
	on caw.Plexus_Customer_No = tv.Plexus_Customer_No
	and caw.CNC_Approved_Workcenter_Key = tv.CNC_Approved_Workcenter_Key  -- 1 to many
	-- where caw.CNC_Approved_Workcenter_Key=@pCNC_Approved_Workcenter_Key 
	-- and  tv.Tool_Var = @pTool_Var
	where caw.CNC_Approved_Workcenter_Key=pCNC_Approved_Workcenter_Key 
	and  tv.Tool_Var = pTool_Var;
   
	set pAssembly_Machining_History_Key = (select Assembly_Machining_History_Key from Assembly_Machining_History where Assembly_Machining_History_Key =(SELECT LAST_INSERT_ID()));
   	set pReturnValue = 0;
END;

select count(*) from Assembly_Machining_History  -- 984
select 
Assembly_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
-- where Assembly_Key = 14
-- where Assembly_Key = 18 -- tool_life yes
order by Current_Value 

/* Test MachingHistory */
(300758,1,1,13,9,0),
(300758,2,14,14,6,0),  
Started 11/13 10:05 at 102
End at 11:14 02:11 with 200
Start: 11:14 02:24 with 2
Continue: 11:14 08:27 with 42
select pl.Assembly_Key,pl.Tool_Key, cpl.Current_Value,cpl.Running_Total,cpl.Last_Update from  Part_v_Tool_Op_Part_Life pl
inner join CNC_Tool_Op_Part_Life cpl 
on pl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key -- 1 to many 
where pl.Tool_Key = 14
(300758,3,15,15,1,0),
(300758,4,16,16,1,0),
(300758,5,20,17,1,0),
(300758,6,18,18,1,0), -- VC34
(300758,7,19,18,9,0), -- VC33,CCMT 432MT TT7015 INSERT,INBOARD
select 
Assembly_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
where Assembly_Key = 18 -- 
order by Start_Time 
Start: 11/13 10:10, Current_Value = 156 End: 11/13 12:34 Running_Total=172
Start: 11/13 12:46,2 End: 11/14 08:18 124 Running_Total=124
(300758,8,17,19,2,0),
(300758,9,2,20,1,0),
(300758,10,12,21,2,1), -- Alternate Tool for T15;
(300758,11,13,21,2,0),
select 
Assembly_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
where Assembly_Key = 21 -- 
order by Start_Time 
start_time: 11/13 10:13 Current_Value = 236 
End_Time: 11/13 20:18 Running_Total = 300 
Start_Time: 11/13 20:40 Current_Value = 2

select * from Part_v_Tool_Life pvtl where Tool_Key = 19

(300758,12,6,22,7,0),
select 
Assembly_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
where Assembly_Key = 23 -- 
order by Start_Time -- TL=226
Start_Time: 11/13 10:14  Current_Value = 184
11/13 11:58 Counter set back to 170 from 196
End_Time 11/13 17:03 Running_Total = 226
Start_Time: 11/13 17:17 Current_Value = 2
11/14 09:04 Current_Value 102



(300758,13,3,23,2,0), -- VC6,009240,SHLT110408N-PH1 IN2005,DATUM L ROUGH BORE & C'BORE
(300758,14,4,23,2,1), -- Alternate Tool for,008318, one of the T6 inserts.  
(300758,15,5,23,2,0), -- VC66,008318,SHLT140516N-FS IN1030 INSERT,DATUM L ROUGH BORE & C'BORE
(300758,16,7,24,1,0),
(300758,17,7,25,1,0),
(300758,18,8,26,1,0),
(300758,19,9,26,1,1),  -- Alternate Tool for T12; 
(300758,20,10,27,2,0),
select 
Assembly_Key,Current_Value,Running_Total,
Start_Time,End_Time,Run_Time 
from Assembly_Machining_History amh
where Assembly_Key = 27 -- 
order by Start_Time 
Start_Time: 11/13 10:17 Current_Value = 726
End_Time 11:13 21:44 Running_Total = 800


(300758,21,11,28,2,0)
	
	set @CNC_Approved_Workcenter_Key = 2;
set @Tool_Var = 1;

CALL GetCounterIncrement(@CNC_Approved_Workcenter_Key,@Tool_Var,@IncrementBy,@Return_Value);

SELECT @IncrementBy,@Return_Value;

/*
 * So that we don't have to maintain a configuration file for UDP13319 we have
 * stored assembly counter increment values in a table. 
 */
-- DROP PROCEDURE GetCounterIncrement;

CREATE PROCEDURE GetCounterIncrement(
	pCNC_Approved_Workcenter_Key INT,
	pTool_Var INT,
	OUT pIncrementBy INT,
	OUT pReturnValue INT 
)
BEGIN
	
	
	-- set @pCNC_Approved_Workcenter_Key = 2;
	-- set @pTool_Var = 1;
		
	select 
	-- tv.Plexus_Customer_No,tv.CNC_Approved_Workcenter_Key,
	tv.Tool_Key into @Tool_Key 
	from CNC_Approved_Workcenter caw 
	inner join Tool_Var_Map tv
	on caw.Plexus_Customer_No = tv.Plexus_Customer_No 
	-- where tv.CNC_Approved_Workcenter_Key = @pCNC_Approved_Workcenter_Key  -- this is unique for all PCN
	-- and tv.Tool_Var = @pTool_Var;
	-- select @Tool_Key;
	where tv.CNC_Approved_Workcenter_Key = pCNC_Approved_Workcenter_Key
	and tv.Tool_Var = pTool_Var; 

	select 
	-- pl.Increment_By into @pIncrementBy
	 pl.Increment_By into pIncrementBy
	-- set @pCNC_Approved_Workcenter_Key = 2;
	-- select count(*)
	from CNC_Approved_Workcenter caw 
	-- select * from CNC_Tool_Op_Part_Life opl
	inner join 
	(
		select opl.PCN Plexus_Customer_No,
		cpl.Workcenter_Key,
		cpl.CNC_Key,
		opl.Part_Key,
		cpl.Part_Operation_Key, 
		opl.Tool_Key, 
		cpl.Increment_By 
		from Part_v_Tool_Op_Part_Life opl
		inner join CNC_Tool_Op_Part_Life cpl
		on opl.Tool_Op_Part_Life_Key = cpl.Tool_Op_Part_Life_Key -- 1 to many
		-- where cpl.CNC_Key = 3 -- 21
	) pl
	on caw.Plexus_Customer_No = pl.Plexus_Customer_No
	and caw.Workcenter_Key = pl.Workcenter_Key
	and caw.CNC_Key = pl.CNC_Key
	and caw.Part_Key = pl.Part_Key
	and caw.Part_Operation_Key = pl.Part_Operation_Key  -- 1 to 1 -- 21
	-- where caw.CNC_Approved_Workcenter_Key=@pCNC_Approved_Workcenter_Key 
	-- and pl.Tool_Key = @Tool_Key;
	where caw.CNC_Approved_Workcenter_Key=pCNC_Approved_Workcenter_Key 
	and pl.Tool_Key = @Tool_Key;
	-- select @pIncrementBy;
	
   	-- SELECT ROW_COUNT(); -- 0
   	-- set pRecordCount = FOUND_ROWS();
   	set pReturnValue = 0;
end;



/*
	set @pCNC_Approved_Workcenter_Key = 2;
	set @pPallet_No = 1;
	set @pTool_Var = 1;
	set @pStart_Time = '2020-09-05 09:48:00';
	set @pEnd_Time = '2020-09-05 09:50:10';
*/
/*
	select 
	caw.Plexus_Customer_No,
	caw.Workcenter_Key,
	caw.CNC_Key,
	pPallet_No Pallet_No,
	-- @pPallet_No,
	caw.Part_Key,
	caw.Part_Operation_Key,
	tv.Assembly_Key,
	pStart_Time Start_Time,
	pEnd_Time End_Time,
	TIMESTAMPDIFF(SECOND, pStart_Time, pEnd_Time) Run_Time 
	--  @pStart_Time Start_Time,
	-- @pEnd_Time End_Time,
	-- TIMESTAMPDIFF(SECOND, @pStart_Time, @pEnd_Time) Run_Time 
   	from CNC_Approved_Workcenter caw 
	inner join Tool_Var_Map tv 
	on caw.Plexus_Customer_No = tv.Plexus_Customer_No
	and caw.CNC_Approved_Workcenter_Key = tv.CNC_Approved_Workcenter_Key  -- 1 to many
	-- where caw.CNC_Approved_Workcenter_Key=@pCNC_Approved_Workcenter_Key 
	-- and  tv.Tool_Var = @pTool_Var
	where caw.CNC_Approved_Workcenter_Key=pCNC_Approved_Workcenter_Key 
	and  tv.Tool_Var = pTool_Var;
   
	set pAssembly_Machining_History_Key = (select Assembly_Machining_History_Key from Assembly_Machining_History where Assembly_Machining_History_Key =(SELECT LAST_INSERT_ID()));
   	set pReturnValue = 0;
*/
