create table PCN 
(
	PCN int,
	City varchar(25),
	State varchar(25),
 	PRIMARY KEY (PCN)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='PCN info';
insert into PCN(PCN,City,State)
-- values(300758,'Albion','Indiana')
-- values(310507,'Avilla','Indiana')
/*
 * Subset of Plex part_v_workcenter view.  Plex has multiple CNC assigned to a workcenter.
 * 
 */


/*
 	building_key	building_code	name
1	4543	Southfield	Mobex Global Southfield
2	5665	Tech Center	Tech Center
3	4261	Main	Main
4	4261	Mobex Global Fruitport	Mobex Global Fruitport
5	4261	Mobex Global Franklin	Mobex Global Franklin
6	4261	Main	Main
7	4261	Main	Main
8	5229	Mobex Global HQ and Technical Center	Mobex Global HQ and Technical Center
9	4261	Main	Main
10	5301	Mobex Global Hartselle	Mobex Global Hartselle
11	5533	American Axle	Grede Holdings, LLC
12	5534	Mobex Global Fruitport	Mobex Global Fruitport
13	5535	Waupaca	Hitachi Metals
14	5536	Kobe	KAAP
15	5504	Mobex Global Plant 5	Mobex Global Albion - Plant 5
16	5641	Mobex Global Plant 8	Mobex Global Albion - Plant 8
17	5642	Mobex Global Plant 3	Mobex Global Albion - Plant 3
18	5643	Mobex Global Plant 2	Mobex Global Albion - Plant 2
19	5644	Mobex Global Plant 6	Mobex Global Albion - Plant 6
20	5645	Mobex Global Plant 7	Mobex Global Kendallville - Plant 7
21	5646	Mobex Global Plant 9	Mobex Global Albion - Plant 9
22	5647	Mobex Global Plant 11	Mobex Global Avilla - Plant 11
23	5648	Mobex Global Warehouse	Mobex Global Albion - Warehouse
24	5649	Mobex Global Workholding	Mobex Global Workholding
25	5650	Mobex Global Central Stores	Mobex Global Albion - Central Stores
26	5651	Mobex Global Distribution Center	Mobex Global Albion - Distribution Center
27	5652	Mobex Global Metrology Lab	Mobex Global Albion - Metrology Laboratory
28	5660	Mobex Global Pole Barn	Mobex Global Albion - Pole Barn
29	5696	Mobex Global Edon	Mobex Global Edon
30	5609	Mobex Global Edon	Mobex Global Edon
31	5668	Edon Plant 2	Edon Plant 2
32	5680	Mobex Global Avilla	Mobex Global Avilla - Plant 11
33	5865	BPG Workholding	BPG Workholding
*/

-- truncate table Building_V2
-- drop table Building_V2; 
CREATE TABLE Building_V2 (
  Plexus_Customer_No int NOT NULL,
  Building_Key int NOT NULL,
  Building_Code varchar(50) DEFAULT NULL,
  Name varchar(100) DEFAULT NULL,
  Building_No int NOT NULL,
  PRIMARY KEY (Plexus_Customer_No,Building_Key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Subset of Plex part_v_building view.';

insert into Building_V2 (Plexus_Customer_No,Building_Key,Building_Code,Name,Building_No)
-- Albion 
-- values(300758,5641,'Mobex Global Plant 8','Mobex Global Albion - Plant 8',8)
-- values(300758,5644,'Mobex Global Plant 6','Mobex Global Albion - Plant 6',6)
-- Avilla
-- values(310507,5680,'Mobex Global Avilla','Mobex Global Avilla - Plant 11',11)
-- select * from Building_V2 b2 

-- drop table Workcenter_V2
-- truncate table Workcenter_V2
CREATE TABLE Workcenter_V2 (
	Plexus_Customer_No int NOT NULL,
  	Workcenter_Key int NOT NULL,
  	Building_Key int NOT NULL,  -- This is a null value in Plex for 17 Avilla workcenters so added what it should be
  	Workcenter_Code varchar(50) NOT NULL,  
  	Name varchar (100),
  	PRIMARY KEY (Plexus_Customer_No,Workcenter_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Subset of Plex part_v_workcenter view.';
insert into Workcenter_V2 (Plexus_Customer_No,Workcenter_Key,Building_Key,Workcenter_Code,Name)
-- Albion
-- values(300758,61090,5644,'CNC 120 LH 6K Knuckle','P558 LH 6K Knuckle')
-- Avilla
-- values (310507,61324,5680,'CNC103','Honda RDX RH') 
-- values (310507,61314,5680,'Honda Civic CNC 359 362','Honda Civic Knuckle LH') 

select * from Workcenter_V2 tt 
/*
 * CNC info, don't want to have a varchar primary_key
 */
-- drop table CNC_V2 
CREATE TABLE CNC_V2 (
	Plexus_Customer_No int NOT NULL,
	CNC_Key int NOT NULL,
	CNC varchar(10) NOT NULL,
	CNC_TYPE_Key int NOT NULL, -- foreign key
	Serial_Port boolean NOT NULL,
	Networked boolean NOT NULL, 
  	PRIMARY KEY (Plexus_Customer_No,CNC_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC info';
insert into CNC_V2 (Plexus_Customer_No,CNC_Key,CNC,CNC_Type_Key,Serial_Port,Networked)
-- Albion
-- values(300758,3,'120',1,true,false)
-- Avilla
-- values (310507,1,'103',1,true,false)
-- values (310507,2,'362',2,false,true)
select * from CNC_V2

-- drop table CNC_Type_V2 
CREATE TABLE CNC_Type_V2 (
	Plexus_Customer_No int NOT NULL,
	CNC_Type_Key int NOT NULL,
	CNC_Type varchar(50) NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,CNC_Type_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC types such as Makino, Okuma, Welles, etc.';
insert into CNC_Type_V2 (Plexus_Customer_No,CNC_Type_key,CNC_Type)
-- Albion
-- values (300758,1,'Okuma')
-- values (300758,2,'Makino')
-- Avilla
-- values (310507,1,'Okuma')
-- values (310507,2,'Makino')

select * from CNC_Type_V2

/*
 * Many CNC can be assigned to 1 work center
 */
-- drop table CNC_Workcenter_V2
-- truncate table CNC_Workcenter_V2
CREATE TABLE CNC_Workcenter_V2 (
	Plexus_Customer_No int NOT NULL,
	CNC_Workcenter_Key int NOT NULL,
	CNC_Key int NOT NULL,  -- foreign key
  	Workcenter_Key int NOT NULL, -- foreign key
  	PRIMARY KEY (Plexus_Customer_No,CNC_Workcenter_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Link CNC to a workcenter';
insert into CNC_Workcenter_V2 (Plexus_Customer_No,CNC_Workcenter_Key,CNC_Key,Workcenter_Key)
-- Albion
-- values(300758,3,3,61090)
-- Avilla
-- values (310507,1,1,61324) 
-- values (310507,2,2,61314) 
select * from CNC_Workcenter_V2

-- truncate table TL_Plex_PN_Op_Map_V2
-- drop table TL_Plex_PN_Op_Map_V2
CREATE TABLE TL_Plex_PN_Op_Map_V2 (
	Plexus_Customer_No int NOT NULL,
	ProcessID int NOT NULL,
	TL_Part_No	varchar (100), 
	Plex_Part_No varchar(100) NOT NULL,
	Revision varchar(8) NOT NULL,
	Operation_Code	varchar (30) NOT NULL
);
insert into TL_Plex_PN_Op_Map_V2 (Plexus_Customer_No,ProcessID,TL_Part_No,Plex_Part_No,Revision,Operation_Code)
-- Albion
-- values (300758,61748,'10103355','10103355','A','Machine A - WIP');
    
-- Avilla
-- values(310507,61442,'51393-TJB-A040-M1','51393TJB A040M1','40-M1-','Final');         

select * from TL_Plex_PN_Op_Map_V2
/*
 * Corresponds to Plex part_v_part
 */
-- drop table Part_V2
-- truncate table Part_V2
CREATE TABLE Part_V2 (
	Plexus_Customer_No int NOT NULL,
	Part_Key int NOT NULL,
	Part_No	varchar (100),
	Revision varchar (8),  -- May not be a good idea to collect revision info.
	Name varchar (100),
	Part_Type varchar (50),
	PRIMARY KEY (Plexus_Customer_No,Part_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_part view';
insert into Part_V2 (Plexus_Customer_No,Part_Key,Part_No,Revision,Name,Part_Type)
-- Albion
-- values (300758,2794706,'10103355','A','P558 6K Knuckle Left Hand','Knuckle')
-- Avilla
-- values (310507,2809196,'51393TJB A040M1','40-M1-','RDX Right Hand','Bracket') 
-- select * from Part_V2 where Part_Key = 2809196

*
 * Corresponds to plex part_v_operation
 */
-- drop table Operation_V2
-- truncate table Operation_V2
CREATE TABLE Operation_V2 (
	Plexus_Customer_No int NOT NULL,
	Operation_Key	int NOT NULL,
	Operation_Code	varchar (30),
	PRIMARY KEY (Plexus_Customer_No,Operation_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_operation';
insert into Operation_V2 (Plexus_Customer_No,Operation_Key,Operation_Code)
-- Albion
-- values (300758,51168,'Machine A - WIP')
-- Avilla
-- values (310507,56400,'Final')

update Operation_V2 
set Operation_Code = 'Final'
where Operation_Key = 56400
select * from Operation_V2

/*
 * Corresponds to plex part_v_part operation
 */
-- drop table Part_Operation_V2
-- truncate table Part_Operation_V2
CREATE TABLE Part_Operation_V2 (
	Plexus_Customer_No int NOT NULL,
	Part_Operation_Key	int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	PRIMARY KEY (Plexus_Customer_No,Part_Operation_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_part_operation';
insert into Part_Operation_V2 (Plexus_Customer_No,Part_Operation_Key,Part_Key,Operation_Key)
-- Albion
-- values (300758,7874404,2794706,51168)  -- LH Knuckles, CNC120, Machine A -WIP,  Operation 10 in Tool List.
-- Avilla
values (310507,7917723,2809196,56400)  -- RDX AVILLA

select * from Part_Operation_V2

-- drop table CNC_Part_Operation_V2
-- truncate table CNC_Part_Operation_V2
CREATE TABLE CNC_Part_Operation_V2 (
	Plexus_Customer_No int NOT NULL,
	CNC_Part_Operation_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	PRIMARY KEY (Plexus_Customer_No,CNC_Part_Operation_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Links CNC to a part operation';
insert into CNC_Part_Operation_V2 (Plexus_Customer_No,CNC_Part_Operation_Key,CNC_Key,Part_Key,Operation_Key)
-- Albion
-- values(300758,2,3,2794706,51168)  -- CNC120, LH Knuckles
-- Avilla
values(310507,3,1,2809196,56400)  -- CNC103, RH RDX
select * from CNC_Part_Operation_V2

/*
 * This corresponds to a Plex tool assembly.
 * ASSEMBLY KEY WILL NEED TO BE CHANGED TO ACTUAL VALUE ONCE UPLOAD IS COMPLETE
 */
-- drop table Tool_Assembly_V2
-- truncate table Tool_Assembly_V2
CREATE TABLE Tool_Assembly_V2 (
	Plexus_Customer_No int NOT NULL,
	Assembly_Key int NOT NULL, 
	Assembly_No	varchar (50) NOT NULL,
	Description	varchar (100) NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Assembly_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Assembly';
insert into Tool_Assembly_V2 (Plexus_Customer_No,Assembly_Key,Assembly_No,Description)
-- Avilla
-- RDX, cnc 103
-- values (310507,1,'T10','86.575MM FINISH BORE')
-- values (310507,2,'T11','ETCHING TOOL')
-- values (310507,3,'T01','85.24MM ROUGH BORE')
-- values (310507,4,'T12','86.125MM ROUGH BORE')
-- values (310507,5,'T02','1.25" HELLICAL MILL')
-- values (310507,6,'T13','180MM DISK MILL')
-- values (310507,7,'T04','21MM DRILL')
-- values (310507,8,'T05','10MM END MILL')
-- values (310507,9,'T16','135MM DISK MILL')
-- values (310507,10,'T07','8.2MM DRILL')
-- values (310507,11,'T08','14.3MM DRILL')
-- values (310507,12,'T09','15.5MM DRILL')

-- Albion
-- P558 LH Knuckles
-- values (300758,13,'T01','3IN FACE MILL')
-- values (300758,14,'T21','2.5IN FACE MILL')
-- values (300758,15,'T22','M6 DRILL')
-- values (300758,16,'T23','M6 X 1.0 TAP')
-- values (300758,17,'T72','DRILL FACE HOLES')
-- values (300758,18,'T33','ROUGH MULTI BORE')
-- values (300758,19,'T30','FINISH CENTER BORE')
-- values (300758,20,'T4','FACE & DRILL CALIPER HOLES')
-- values (300758,21,'T15','1.937 ROUGH DRILL J BORE')
-- values (300758,22,'T7','DATUM J BACK FACE')
-- values (300758,23,'T6','DATUM L ROUGH BORE')
-- values (300758,24,'T9','FINISH DATUM L')
-- values (300758,25,'T8','FINISH DATUM J')
-- values (300758,26,'T12','TAPER REAM ONE SIDE')
-- values (300758,27,'T13','MILL PADS AND STOP')
-- values (300758,28,'T14','CHAMFER HOLES')
select * from Tool_Assembly_V2 
 /*  From ToolListAssemblies
tn|Description               
--|--------------------------
 1|3" FACE MILL              
 4|FACE & DRILL CALIPER HOLES
 6|DATUM L ROUGH BORE        
 7|DATUM J BACK FACE         
 8|FINISH DATUM J            
 9|FINISH DATUM L            
12|TAPER REAM ONE SIDE       
13|MILL PADS AND STOP        
14|CHAMFER HOLES             
15|1.937 ROUGH DRILL J BORE  
21|2.5" FACE MILL            
22|M6 DRILL                  
23|M6 X 1.0 TAP              
30|FINISH CENTER BORE        
33|ROUGH MULTI BORE          
72|DRILL FACE HOLES          
*/

select * from Tool_Assembly_V2 

-- drop table Tool_Assembly_Part_V2
-- truncate table Tool_Assembly_Part_V2
-- NEEDS UPDATED AFTER PLEX TOOLING MODULE UPLOAD
CREATE TABLE Tool_Assembly_Part_V2 (
	Plexus_Customer_No int NOT NULL,
	Tool_Assembly_Part_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
  	PRIMARY KEY (Plexus_Customer_No,Tool_Assembly_Part_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Assembly_Part';
insert into Tool_Assembly_Part_V2 (Plexus_Customer_No,Tool_Assembly_Part_Key,Assembly_Key,Part_Key,Operation_Key)
-- Avilla
-- values (310507,1,1,2809196,56409)
-- values (310507,2,2,2809196,56409)
-- values (310507,3,3,2809196,56409)
-- values (310507,4,4,2809196,56409)
-- values (310507,5,5,2809196,56409)
-- values (310507,6,6,2809196,56409)
-- values (310507,7,7,2809196,56409)
-- values (310507,8,8,2809196,56409)
-- values (310507,9,9,2809196,56409)
-- values (310507,10,10,2809196,56409)
-- values (310507,11,11,2809196,56409)
-- values (310507,12,12,2809196,56409)

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

select * from Tool_Assembly_Part_V2


/*
 * This corresponds to a Plex tool_type table for Albion.
 */
-- drop table Tool_Type_V2
-- truncate table Tool_Type_V2
CREATE TABLE Tool_Type_V2 (
	Plexus_Customer_No int NOT NULL,
	Tool_Type_Key int,
	Tool_Type_Code	varchar (20),
  	PRIMARY KEY (Plexus_Customer_No,Tool_Type_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Type';
insert into Tool_Type_V2 (Plexus_Customer_No,Tool_Type_Key,Tool_Type_Code)
-- Albion 
-- values (300758,30048,'Insert')
-- values (300758,30016,'Drill')
-- values (300758,30800,'Reamer')  -- Just added this get real number  was 1
-- values (300758,30801,'Tap')  -- Just added this get real number was 2
-- Avilla
-- values (310507,25115,'Insert')
-- values (310507,25118,'Drill')
-- values (310507,30760,'Drill Tip')
-- values (310507,25116,'End Mill')
-- values(310507,30740,'Boring Bar')
 values (310507,30762,'Engraving')

select * from Tool_Type_V2
delete from Tool_Type_V2 where Tool_Type_Key in (1,2)

/*
 * This corresponds to a Plex Tool_Group table.
 * Albion’s ExportMasterToolList Tool_Group looks like a tool_type where as Alabama and now Edon are set to Mill.
 * ADDED MILL TOOL GROUP LOOKUP TOOL_GROUP_KEY LATER AND CHANGE FROM 1
 */
-- drop table Tool_Group_V2
-- truncate table Tool_Group_V2
CREATE TABLE Tool_Group_V2 (
	Plexus_Customer_No int NOT NULL,
	Tool_Group_Key int,
	Tool_Group_Code	varchar (20),
  	PRIMARY KEY (Plexus_Customer_No,Tool_Group_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Group';
insert into Tool_Group_V2 (Plexus_Customer_No,Tool_Group_Key,Tool_Group_Code)
-- Albion
-- values (300758,3570,'Mill')
-- Avilla
-- values (310507,1,'Mill')  -- Added Mill update with tool_group_code
select * from Tool_Group_V2 

select * from TL_Plex_PN_Op_Map_V2

    
    
/*
 * This corresponds to a Plex tool_bom table.
 * -- THIS WILL NEED TO BE UPDATED AFTER TOOLING MODULE UPLOAD
 */
-- drop table Tool_V2
-- truncate table Tool_V2
CREATE TABLE Tool_V2 (
	Plexus_Customer_No int NOT NULL,
	Tool_Key int,
	Tool_No	varchar (50),
	Tool_Type_Key	int,
	Tool_Group_Key	int,
	Description	varchar (50),
	Consumable bit, -- Comes from Busche Tool List
	NumberOfCuttingEdges int, -- Comes from Busche Tool List
	Price	decimal (18,4),
  	PRIMARY KEY (Plexus_Customer_No,Tool_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool';
insert into Tool_V2 (Plexus_Customer_No,Tool_Key,Tool_No,Tool_Type_Key,Tool_Group_Key,Description,Consumable,NumberOfCuttingEdges,Price)  
-- Avilla
-- values (310507,21,'008431',25115,1,'TCGT 32.52 FL K10',1,3,6.690000)  -- insert
-- values (310507,22,'007221',25115,1,'XOEX120408FR-E06 H15',1,2,10.310000)  -- insert
-- values (310507,23,'16405',25115,1,'CCC-32503-010/PCD',1,1,92.000000)  -- insert
-- values (310507,24,'16406',30760,1,'HH-32503-21-AL',1,1,79.000000)  --
-- values (310507,25,'16461',25116,1,'A345M-100-D2-S.0-Z3',1,1,33.700000)  --
-- values (310507,26,'16110',25116,1,'CCC-30083 REV 1',1,1,101.000000)  --
-- values (310507,27,'16111',25118,1,'CCC-30082',1,1,163.1600000)  --
-- values (310507,28,'16130',25118,1,'CCC-30082',1,1,163.1600000)  --
-- values (310507,29,'16680',30740,1,'CCC-33146',1,1,103.000000)  -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $103.
-- values (310507,30,'12623',30762,1,'C-1875-2.0-60-.020-G',1,1,14.980000)  --
-- values (310507,31,'16409',30740,1,'CCC-32506-100',1,1,103.000000)  -- -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $103.
-- values (310507,32,'16407',30758,1,'CCC-32508-100',1,1,200.000000)   -- -- Can't find price anywhere in MSC,CM,Plex, Best guess from searching the web is $200.
-- values (310507,33,'16408',30758,1,'CCC-32507-100',1,1,1320.000000)  

-- Albion
-- values (300758,1,'009196',30048,1,'ONMU 090520ANTN-M15 MK2050',1,16,14.380000)  -- insert
-- values (300758,2,'17100',30016,1,'CCC-34231',1,1,276.000000)  -- drill
-- values (300758,3,'009240',30048,1,'SHLT110408N-PH1 IN2005',1,4,8.770000) -- 
-- values (300758,4,'15721',30048,1,'SHLT140516N-FS IN2005',1,4,12.570000) -- Shown as an alternate in the Tool List for 008318
-- values (300758,5,'008318',30048,1,'SHLT140516N-FS IN1030',1,4,10.950000) -- Shown as replacing 15721 in Plex 
/*
Cliff 008318 replaced 15721. Assembly takes both an inboard and outboard insert.
009240    |                   200|                   
008318    |                   200|                   
15721     |                   200|ALTERNATE INSERT FO
*/
-- values (300758,6,'008485',30048,1,'CDE323L022 IN2530',1,2,9.820000)  -- insert 
-- values (300758,7,'007864',30048,1,'TCMT 21.51-F1 TP1501',1,3,5.950000)  -- insert 
-- values (300758,8,'010338',1,1,'CCC-23575 REV A',1,1,506.000000)  -- Reamer 
-- values (300758,9,'008410',1,1,'CCC-21216 REV B',1,1,198.000000)  -- Reamer 
-- values (300758,10,'0003396',30048,1,'APFT1604PDTL-D15 MP1500 Insert',1,2,9.810000)  -- insert
-- values (300758,11,'008435',30048,1,'TCMT 110202 LC225T',1,3,10.370000)  -- insert
-- values (300758,12,'009155',30048,1,'SPLT140512N-PH IN2005',1,4,9.980000)  -- insert  -- Alternate in P558 Knuckles LH
-- values (300758,13,'13753',30048,1,'WDXT 156012-H ACK300',1,4,6.952000)  -- insert
-- values (300758,14,'17022',30048,1,'SNMX1407ZNTR-M16 MK2050',1,8,12.510000)  -- insert
-- values (300758,15,'14710',30016,1,'CCC-27629 REV 0',1,1,93.000000)  -- drill
-- values (300758,16,'0000951',2,1,'23910-05',1,1,32.350000)  -- Tap
-- values (300758,17,'16547',30048,1,'CCMT21.52MK MC5015',1,2,6.640000)  -- insert
-- values (300758,18,'010559',30048,1,'CCMT 32.52 -M3 TK1501',1,2,6.030000)  -- insert
-- values (300758,19,'15843',30048,1,'CCMT 432MT TT7015 INSERT',1,2,5.800000)  -- insert
-- values (300758,20,'14855',30016,1,'CCC-28434 REV 1',1,1,212.000000)  -- drill
select * from Tool_V2

/*
 * This corresponds to a Plex tool_bom table.
 * -- THIS WILL NEED TO BE UPDATED AFTER TOOLING MODULE UPLOAD
 */
-- drop table Tool_BOM_V2
-- truncate table Tool_BOM_V2
CREATE TABLE Tool_BOM_V2 (
	Plexus_Customer_No int,
	Tool_BOM_Key int,
	Tool_Key int,
	Assembly_Key int NOT NULL, 
	Quantity_Required decimal (18,2),
	Alternate bit(1),
  	PRIMARY KEY (Plexus_Customer_No,Tool_BOM_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_BOM';
insert into Tool_BOM_V2 (Plexus_Customer_No,Tool_BOM_Key,Tool_Key,Assembly_Key,Quantity_Required,Alternate) 
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



select * from Tool_BOM_V2  order by Plexus_Customer_No,Assembly_Key 



/*
 * UDP Datagrams sent from Moxa units.
 * Common variablies used as assembly counters are identified by an CNC_Part_Operation_Key, Set_No, and Block_No 
 * when sent to the UDP server.  This table links the assembly counter value to a Tool_Assembly_Part record.
 */
-- UPDATE ASSEMBLY KEY AFTER TOOLING UPLOAD
-- drop table CNC_Part_Operation_Set_Block_V2 
CREATE TABLE CNC_Part_Operation_Set_Block_V2 (
	Plexus_Customer_No int,
	CNC_Part_Operation_Set_Block_Key int NOT NULL,   -- each CNC_Part_Operation_Key, Set_No, Block_No combination maps to 1 CNC, Part, Part_Operation, Assembly_Key pair.
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
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
insert into CNC_Part_Operation_Set_Block_V2 (Plexus_Customer_No,CNC_Part_Operation_Set_Block_Key,CNC_Key,Part_Key,Operation_Key,Set_No,Block_No,Assembly_Key,Tool_Key)
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

 -- Avilla
-- values (310507,1,1,2809196,56400,1,1,1,29)
-- values (310507,2,1,2809196,56400,1,2,2,30)
-- values (310507,3,1,2809196,56400,1,3,3,21)
-- values (310507,4,1,2809196,56400,1,4,4,31)
-- values (310507,5,1,2809196,56400,1,5,5,22)
-- values (310507,6,1,2809196,56400,1,6,6,32)
-- values (310507,7,1,2809196,56400,1,7,7,23)
-- values (310507,8,1,2809196,56400,1,8,7,24)
-- values (310507,9,1,2809196,56400,1,9,8,25)
-- values (310507,10,1,2809196,56400,2,1,9,33)
-- values (310507,11,1,2809196,56400,2,2,10,26)
-- values (310507,12,1,2809196,56400,2,3,11,27)
-- values (310507,13,1,2809196,56400,2,4,12,28)
select * from CNC_Part_Operation_Set_Block_V2
-- delete from CNC_Part_Operation_Set_Block_V2 where CNC_Part_Operation_Set_Block_Key = 32 

-- DELETED VALUES
-- values (22,3,2794706,51168,2,1,21,12)  -- THIS IS AN ALTERNATE SO DELETE IT
-- values (30,3,2794706,51168,3,4,26,9) -- THIS IS AN ALTERNATE SO DELETE IT

/*
13|T01        |3IN FACEMILL             
14|T21        |2IN FACEMILL             
15|T22        |M6 TAP DRILL             
16|T23        |M6X1 TAP                 
17|T72        |15.1MM DRILL             
18|T33        |ROUGH BORE               
19|T30        |FINISH CENTER BORE       
20|T4         |16.95 CALIPER HOLES      
21|T15        |1.937 INDEXABLE DRILL    
22|T7         |ROUGH DATUM J BORE       
23|T6         |ROUGH DATUM L BORE       
24|T9         |DATUM L 44.330MM ROMICRON
25|T8         |DATUM J 50.110MM ROMICRON
26|T12        |TAPER DREAMER            
27|T13        |PLUNGE MILL              
28|T14        |CHAMFER MILL             
 */
select * from CNC_Part_Operation_Set_Block

/*
 * Maintain data specific to a tool assembly of a CNC part operation 
 */
-- drop table CNC_Part_Operation_Assembly 
-- truncate table CNC_Part_Operation_Assembly
CREATE TABLE CNC_Part_Operation_Assembly_V2 (
	CNC_Part_Operation_Assembly_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,  -- This is the Plex production operation number and not the CNC operation.
	Assembly_Key int NOT NULL, 
  	PRIMARY KEY (CNC_Part_Operation_Assembly_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Maintain data specific to a tool assembly of a CNC part operation';

set @Last_Update = '2020-08-15 00:00:00';
insert into CNC_Part_Operation_Assembly_V2 (CNC_Part_Operation_Assembly_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key)
-- P558 LH Knuckles, CNC120
-- values (13,3,2794706,51168,13)  -- vc1
-- values (14,3,2794706,51168,14)  -- vc21
-- values (15,3,2794706,51168,15)  -- vc22
-- values (16,3,2794706,51168,16)  -- vc23
-- values (17,3,2794706,51168,17)  -- vc72
-- values (18,3,2794706,51168,18)  -- vc33
-- values (19,3,2794706,51168,19)  -- vc30
-- values (20,3,2794706,51168,20)  -- vc4
-- values (21,3,2794706,51168,21)  -- vc15
-- values (22,3,2794706,51168,22)  -- vc7
-- values (23,3,2794706,51168,23)  -- vc6
-- values (24,3,2794706,51168,24)  -- vc9
-- values (25,3,2794706,51168,25)  -- vc8
-- values (26,3,2794706,51168,26)  -- vc12
-- values (27,3,2794706,51168,27)  -- vc13
-- values (28,3,2794706,51168,28)  -- vc14
-- update CNC_Part_Operation_Assembly_V2 
set Tool_Life = 5000
where CNC_Part_Operation_Assembly_Key = 28
select * from CNC_Part_Operation_Assembly_V2

insert into CNC_Part_Operation_Assembly_V2 (CNC_Part_Operation_Assembly_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key)
-- RDX, CNC 103
-- values (1,1,2809196,56409,1)  -- vc10
-- values (2,1,2809196,56409,2)  -- vc11
-- values (3,1,2809196,56409,3)
-- values (4,1,2809196,56409,4)  -- vc12
-- values (5,1,2809196,56409,5)
-- values (6,1,2809196,56409,6)
-- values (7,1,2809196,56409,7)
-- values (8,1,2809196,56409,8)
-- values (9,1,2809196,56409,9)
-- values (10,1,2809196,56409,10)
-- values (11,1,2809196,56409,11)
-- values (12,1,2809196,56409,12)
-- delete from CNC_Part_Operation_Assembly_V2 where CNC_Part_Operation_Assembly_Key in (2,4)
select * from CNC_Part_Operation_Assembly_V2



/*
 * Maintain data specific to tool cutters for tool assemblies. 
 */
1. The Plex Tool_Life is associated with a part operation but we have multiple assemblies 
that use the same tool for a part_operation.  
2. It is also associated with a work center but our work centers are associated with multiple 
CNC so we dont have a place to keep track of every CNCs Tool_Life.

of every CNCs Tool life. 
-- drop table CNC_Part_Operation_Assembly_Tool 
-- truncate table CNC_Part_Operation_Assembly_Tool
CREATE TABLE CNC_Part_Operation_Assembly_Tool (
	CNC_Part_Operation_Assembly_Tool_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Tool_Key int NOT NULL, 
	Increment_By int NOT NULL,
	Tool_Life int NOT NULL,  -- Tool list QuantityPerCuttingEdge 
  	Current_Value int NOT NULL,
  	Last_Update datetime NOT NULL,
  	PRIMARY KEY (CNC_Part_Operation_Assembly_Tool_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Maintain data specific to tool cutters for tool assemblies.';

set @Last_Update = '2020-08-15 00:00:00';
insert into CNC_Part_Operation_Assembly_Tool (CNC_Part_Operation_Assembly_Tool_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key,Tool_Key,Increment_By,Tool_Life,Current_Value,Last_Update)
-- P558 LH Knuckles, CNC120
-- values (13,3,2794706,51168,13,1,2,200,-1,@Last_Update )  -- vc1
-- values (14,3,2794706,51168,14,14,2,200,-1,@Last_Update )  -- vc21
-- values (15,3,2794706,51168,15,15,2,2500,-1,@Last_Update )  -- vc22
-- values (16,3,2794706,51168,16,16,2,3000,-1,@Last_Update )  -- vc23
-- values (17,3,2794706,51168,17,20,2,1800,-1,@Last_Update )  -- vc72
-- values (18,3,2794706,51168,18,19,2,200,-1,@Last_Update )  -- vc33
-- values (19,3,2794706,51168,18,18,2,1000,-1,@Last_Update )  -- different tool lives. Not an alternate of VC33. tHIS IS VC34
-- values (20,3,2794706,51168,19,17,2,350,-1,@Last_Update )  -- vc30
-- values (21,3,2794706,51168,20,2,2,3000,-1,@Last_Update )  -- vc4
-- values (22,3,2794706,51168,21,13,2,300,-1,@Last_Update )  -- vc15
-- values (23,3,2794706,51168,22,6,2,2500,-1,@Last_Update )  -- vc7
-- values (24,3,2794706,51168,23,3,2,200,-1,@Last_Update )  -- vc6
-- values (25,3,2794706,51168,23,5,2,200,-1,@Last_Update )  -- vc6
-- values (26,3,2794706,51168,24,7,2,3000,-1,@Last_Update )  -- vc9
-- values (27,3,2794706,51168,25,7,2,3000,-1,@Last_Update )  -- vc8
-- values (28,3,2794706,51168,26,8,2,18000,-1,@Last_Update )  -- vc12
-- values (29,3,2794706,51168,27,10,2,800,-1,@Last_Update )  -- vc13
 values (30,3,2794706,51168,28,11,2,5000,-1,@Last_Update )  -- vc14
-- update CNC_Part_Operation_Assembly 
set Tool_Life = 5000
where CNC_Part_Operation_Assembly_Key = 28
select * from CNC_Part_Operation_Assembly_Tool


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

