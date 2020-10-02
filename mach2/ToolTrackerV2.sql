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
-- values (310507,56400,'Machine Complete')

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
  	PRIMARY KEY (Plexus_Customer_No,Tool_BOM_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_BOM';
insert into Tool_BOM_V2 (Plexus_Customer_No,Tool_BOM_Key,Tool_Key,Assembly_Key,Quantity_Required) 
-- P558 Knuckles
-- values (300758,1,1,13,9)
-- values (300758,2,2,20,1)
-- values (300758,3,3,23,2)
-- -- values (4,4,23,2) -- Alternate Tool; 
-- delete from Tool_BOM where Tool_BOM_Key = 4;
-- values (300758,5,5,23,2)  
-- values (300758,6,6,22,7)

-- values (300758,7,7,24,1)
-- values (300758,8,7,25,1)

-- values (300758,9,8,26,1)
-- -- values (10,9,26,1)  -- Do not add this to the BOM.  It is an Alternate.
-- delete from Tool_BOM where Tool_BOM_Key = 10;

-- values (300758,11,10,27,2)
-- values (300758,12,11,28,2)
-- -- values (13,12,21,2)  -- Do not add this to the BOM.  It is an Alternate.
-- delete from Tool_BOM where Tool_BOM_Key = 13
-- values (300758,14,13,21,2)
-- values (300758,15,14,14,6)
-- values (300758,16,15,15,1)
-- values (300758,17,16,16,1)
-- values (300758,18,17,19,1)
-- values (300758,19,18,18,1)
-- values (300758,20,19,18,9)
-- values (300758,21,20,17,1)


-- RDX Brackets
-- values (310507,25,29,1,1)
-- values (310507,26,30,2,1)
-- values (310507,27,21,3,3)
-- values (310507,28,31,4,1)
-- values (310507,29,22,5,12)
-- values (310507,30,32,6,1)
-- values (310507,31,23,7,2)
-- values (310507,32,24,7,1)
-- values (310507,33,25,8,1)
-- values (310507,34,33,9,1)
-- values (310507,35,26,10,1)
-- values (310507,36,27,11,1)
-- values (310507,37,28,12,1)

select * from Tool_BOM_V2



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
-- select * from CNC_Part_Operation_Set_Block
-- insert into Tool_BOM (Tool_BOM_Key,Tool_Key,Assembly_Key,Quantity_Required,QuantityPerCuttingEdge)  
-- values (5,5,23,2,200)  -- Alternate Tool; Obsolete in Plex so delete it; If there are more of these tools they could be used.
-- delete from Tool_BOM where Tool_BOM_Key = 5;

-- values (21,20,17,1,1800)
-- truncate table CNC_Part_Operation_Set_Block_V2
insert into CNC_Part_Operation_Set_Block_V2 (Plexus_Customer_No,CNC_Part_Operation_Set_Block_Key,CNC_Key,Part_Key,Operation_Key,Set_No,Block_No,Assembly_Key,Tool_Key)
-- select * from CNC_Part_Operation_Set_Block_V2
-- P558 LH Knuckles
-- values (300758,13,3,2794706,51168,1,1,13,1)
-- values (300758,14,3,2794706,51168,1,2,14,14)
-- values (300758,15,3,2794706,51168,1,3,15,15)
-- values (300758,16,3,2794706,51168,1,4,16,16)
-- values (300758,17,3,2794706,51168,1,5,17,20)
-- values (300758,18,3,2794706,51168,1,6,18,19) -- VC33
-- values (300758,19,3,2794706,51168,1,7,18,18) -- different tool lifes. Not an alternate of VC33. tHIS IS VC34
-- values (300758,20,3,2794706,51168,1,8,19,17)
-- values (300758,21,3,2794706,51168,1,9,20,2)
-- 100 bytes
-- values (300758,22,3,2794706,51168,2,1,21,13)
-- values (300758,23,3,2794706,51168,2,2,22,6)
-- values (300758,24,3,2794706,51168,2,3,23,3)  
-- values (300758,25,3,2794706,51168,2,4,23,5) -- 2 cutters but the same tool life; send the same common variable twice.
-- values (300758,26,3,2794706,51168,2,5,24,7)
-- 160 bytes now start over
-- values (300758,27,3,2794706,51168,3,1,25,7)
-- values (300758,28,3,2794706,51168,3,2,26,8)
-- values (300758,29,3,2794706,51168,3,3,27,10)
 values (300758,30,3,2794706,51168,3,4,28,11)
-- 60/100 bytes
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

