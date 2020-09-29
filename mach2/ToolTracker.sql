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
drop table 
-- mach2.Building definition

-- truncate table Building
drop table Building 
CREATE TABLE Building (
  Building_Key int NOT NULL,
  Building_Code varchar(50) DEFAULT NULL,
  Name varchar(100) DEFAULT NULL,
  Building_No int NOT NULL,
  PRIMARY KEY (Building_Key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Subset of Plex part_v_building view.';

insert into Building (Building_Key,Building_Code,Name,Building_No)
-- values(5680,'Mobex Global Avilla','Mobex Global Avilla - Plant 11',11)
-- values(5641,'Mobex Global Plant 8','Mobex Global Albion - Plant 8',8)
values(5644,'Mobex Global Plant 6','Mobex Global Albion - Plant 6',6)
-- select * from Building b2 

-- drop table Workcenter
-- truncate table Workcenter
CREATE TABLE Workcenter (
  	Workcenter_Key int NOT NULL,
  	Building_Key int NOT NULL,  -- This is a null value in Plex for 17 Avilla workcenters so added what it should be
  	Workcenter_Code varchar(50) NOT NULL,  
  	Name varchar (100),
  	
  	PRIMARY KEY (Workcenter_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Subset of Plex part_v_workcenter view.';
insert into Workcenter (Workcenter_Key,Building_Key,Workcenter_Code,Name)
-- values (61324,5680,'CNC103','Honda RDX RH') 
-- values (61314,5680,'Honda Civic CNC 359 362','Honda Civic Knuckle LH') 
values(61090,5644,'CNC 120 LH 6K Knuckle','P558 LH 6K Knuckle')

select * from Workcenter tt 



/*
 * CNC info, don't want to have a varchar primary_key
 */
-- drop table CNC 
CREATE TABLE CNC (
	CNC_Key int NOT NULL,
	CNC varchar(10) NOT NULL,
	CNC_TYPE_Key int NOT NULL, -- foreign key
	Serial_Port boolean NOT NULL,
	Networked boolean NOT NULL, 
  	PRIMARY KEY (CNC_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC info';
insert into CNC (CNC_Key,CNC,CNC_Type_Key,Serial_Port,Networked)
-- values (1,'103',1,true,false)
-- values (2,'362',2,false,true)
values(3,'120',1,true,false)

select * from CNC

-- drop table CNC_Type 
CREATE TABLE CNC_Type (
	CNC_Type_Key int NOT NULL,
	CNC_Type varchar(50) NOT NULL,
  	PRIMARY KEY (CNC_Type_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC types such as Makino, Okuma, Welles, etc.';
insert into CNC_Type (CNC_Type_key,CNC_Type)
-- values (1,'Okuma')
values (2,'Makino')
select * from CNC_Type

/*
 * Many CNC can be assigned to 1 work center
 */
-- drop table CNC_Workcenter
-- truncate table CNC_Workcenter
CREATE TABLE CNC_Workcenter (
	CNC_Workcenter_Key int NOT NULL,
	CNC_Key int NOT NULL,  -- foreign key
  	Workcenter_Key int NOT NULL, -- foreign key
  	PRIMARY KEY (CNC_Workcenter_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Link CNC to a workcenter';
insert into CNC_Workcenter (CNC_Workcenter_Key,CNC_Key,Workcenter_Key)
-- values (1,1,61324) 
-- values (2,2,61314) 
values(3,3,61090)

select * from CNC_Workcenter
/*
 * Tool List master table 
 */

/*
 * Corresponds to Plex part_v_part
 */
-- drop table Part
-- truncate table Part
CREATE TABLE Part (
	Part_Key int NOT NULL,
	Part_No	varchar (100),
	Revision varchar (8),  -- May not be a good idea to collect revision info.
	Name varchar (100),
	Part_Type varchar (50),
	PRIMARY KEY (Part_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_part view';
insert into Part (Part_Key,Part_No,Revision,Name,Part_Type)
-- values (2809196,'51393 TJB A040M1','40-M1-','RDX Right Hand','Bracket') 
values (2794706,'10103355','A','P558 6K Knuckle Left Hand','Knuckle')
select * from Part

/*
 * Corresponds to plex part_v_operation
 */
-- drop table Operation
-- truncate table Operation
CREATE TABLE Operation (
	Operation_Key	int NOT NULL,
	Operation_Code	varchar (30),
	PRIMARY KEY (Operation_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_operation';
insert into Operation (Operation_Key,Operation_Code)
-- values (56409,'Machine Complete')
values (51168,'Machine A - WIP')

select * from Operation


/*
 * Corresponds to plex part_v_part operation
 */
-- drop table Part_Operation
-- truncate table Part_Operation
CREATE TABLE Part_Operation (
	Part_Operation_Key	int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	PRIMARY KEY (Part_Operation_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_part_operation';
insert into Part_Operation (Part_Operation_Key,Part_Key,Operation_Key)
-- values (7914696,2809196,56409)
values (7874404,2794706,51168)
select * from Part_Operation


-- drop table CNC_Part_Operation
-- truncate table CNC_Part_Operation
CREATE TABLE CNC_Part_Operation (
	CNC_Part_Operation_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	PRIMARY KEY (CNC_Part_Operation_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Links CNC to a part operation';
insert into CNC_Part_Operation (CNC_Part_Operation_Key,CNC_Key,Part_Key,Operation_Key)
-- values(1,1,2809196,56409)
values(2,3,2794706,51168)
select * from CNC_Part_Operation 

/*
 * This corresponds to a Plex tool assembly.
 * ASSEMBLY KEY WILL NEED TO BE CHANGED TO ACTUAL VALUE ONCE UPLOAD IS COMPLETE
 */
-- drop table Tool_Assembly
-- truncate table Tool_Assembly
CREATE TABLE Tool_Assembly (
	Assembly_Key int NOT NULL, 
	Assembly_No	varchar (50) NOT NULL,
	Description	varchar (100) NOT NULL,
  	PRIMARY KEY (Assembly_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Assembly';
insert into Tool_Assembly (Assembly_Key,Assembly_No,Description)
-- P558 LH Knuckles
-- values (13,'T01','3IN FACE MILL')
-- values (14,'T21','2.5IN FACE MILL')
-- values (15,'T22','M6 DRILL')
-- values (16,'T23','M6 X 1.0 TAP')
-- values (17,'T72','DRILL FACE HOLES')
-- values (18,'T33','ROUGH MULTI BORE')
-- values (19,'T30','FINISH CENTER BORE')
-- values (20,'T4','FACE & DRILL CALIPER HOLES')
-- values (21,'T15','1.937 ROUGH DRILL J BORE')
-- values (22,'T7','DATUM J BACK FACE')
-- values (23,'T6','DATUM L ROUGH BORE')
-- values (24,'T9','FINISH DATUM L')
-- values (25,'T8','FINISH DATUM J')
-- values (26,'T12','TAPER REAM ONE SIDE')
-- values (27,'T13','MILL PADS AND STOP')
-- values (28,'T14','CHAMFER HOLES')
select * from Tool_Assembly 
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
-- RDX, cnc 103
-- values (1,'T10','86.575MM FINISH BORE')
-- values (2,'T11','ETCHING TOOL')
-- values (3,'T01','85.24MM ROUGH BORE')
-- values (4,'T12','86.125MM ROUGH BORE')
-- values (5,'T02','1.25" HELLICAL MILL')
-- values (6,'T13','180MM DISK MILL')
-- values (7,'T04','21MM DRILL')
-- values (8,'T05','10MM END MILL')
-- values (9,'T16','135MM DISK MILL')
-- values (10,'T07','8.2MM DRILL')
-- values (11,'T08','14.3MM DRILL')
-- values (12,'T09','15.5MM DRILL')

select * from Tool_Assembly 

-- drop table Tool_Assembly_Part
-- truncate table Tool_Assembly_Part
-- NEEDS UPDATED AFTER PLEX TOOLING MODULE UPLOAD
CREATE TABLE Tool_Assembly_Part (
	Tool_Assembly_Part_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
  	PRIMARY KEY (Tool_Assembly_Part_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Assembly_Part';
insert into Tool_Assembly_Part (Tool_Assembly_Part_Key,Part_Key,Operation_Key,Assembly_Key)
-- values (13,2794706,51168,13)
-- values (14,2794706,51168,14)
-- values (15,2794706,51168,15)
-- values (16,2794706,51168,16)
-- values (17,2794706,51168,17)
-- values (18,2794706,51168,18)
-- values (19,2794706,51168,19)
-- values (20,2794706,51168,20)
-- values (21,2794706,51168,21)
-- values (22,2794706,51168,22)
-- values (23,2794706,51168,23)
-- values (24,2794706,51168,24)
-- values (25,2794706,51168,25)
-- values (26,2794706,51168,26)
-- values (27,2794706,51168,27)
-- values (28,2794706,51168,28)
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
-- values (1,2809196,56409,1)
-- values (2,2809196,56409,2)
-- values (3,2809196,56409,3)
-- values (4,2809196,56409,4)
-- values (5,2809196,56409,5)
-- values (6,2809196,56409,6)
-- values (7,2809196,56409,7)
-- values (8,2809196,56409,8)
-- values (9,2809196,56409,9)
-- values (10,2809196,56409,10)
-- values (11,2809196,56409,11)
-- values (12,2809196,56409,12)
select * from Tool_Assembly_Part

-- (LEFT HAND 6K P558)
-- (PART# 10037973)


/*
 * This corresponds to a Plex tool_type table.
 */
-- drop table Tool_Type
-- truncate table Tool_Type
CREATE TABLE Tool_Type (
	Tool_Type_Key int,
	Tool_Type_Code	varchar (20),
  	PRIMARY KEY (Tool_Type_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Type';
insert into Tool_Type (Tool_Type_Key,Tool_Type_Code)
-- values (30048,'Insert')
-- values (30016,'Drill')
-- values (1,'Reamer')  -- Just added this get real number
-- values (2,'Tap')  -- Just added this get real number
select * from Tool_Type

/*
 * This corresponds to a Plex Tool_Group table.
 * Albion’s ExportMasterToolList Tool_Group looks like a tool_type where as Alabama and now Edon are set to Mill.
 * ADDED MILL TOOL GROUP LOOKUP TOOL_GROUP_KEY LATER AND CHANGE FROM 1
 */
-- drop table Tool_Group
-- truncate table Tool_Group
CREATE TABLE Tool_Group (
	Tool_Group_Key int,
	Tool_Group_Code	varchar (20),
  	PRIMARY KEY (Tool_Group_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_Group';
insert into Tool_Group (Tool_Group_Key,Tool_Group_Code)
-- values (1,'Mill')
select * from Tool_Group 


/*
 * This corresponds to a Plex tool_bom table.
 * -- THIS WILL NEED TO BE UPDATED AFTER TOOLING MODULE UPLOAD
 */
-- drop table Tool
-- truncate table Tool
CREATE TABLE Tool (
	Tool_Key int,
	Tool_No	varchar (50),
	Tool_Type_Key	int,
	Tool_Group_Key	int,
	Description	varchar (50),
	Consumable bit, -- Comes from Busche Tool List
	NumberOfCuttingEdges int, -- Comes from Busche Tool List
	Price	decimal (18,4),
  	PRIMARY KEY (Tool_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_BOM';
insert into Tool (Tool_Key,Tool_No,Tool_Type_Key,Tool_Group_Key,Description,Consumable,NumberOfCuttingEdges,Price)  
-- values (1,'009196',30048,1,'ONMU 090520ANTN-M15 MK2050',1,16,14.380000)  --insert
-- values (2,'17100',30016,1,'CCC-34231',1,1,276.000000)  -- drill
-- values (3,'009240',30048,1,'SHLT110408N-PH1 IN2005',1,4,8.770000) -- 3 inserts are shown for this tool so I'm listing them all.
-- values (4,'15721',30048,1,'SHLT140516N-FS IN2005',1,4,12.570000) -- 3 inserts are shown for this tool so I'm listing them all.
----- values (5,'008318',30048,1,'SHLT140516N-FS IN1030',1,4,10.950000) -- 3 inserts are shown for this tool so I'm listing them all.  -- This one is obsolete  Delete it
-- values (6,'008485',30048,1,'CDE323L022 IN2530',1,2,9.820000)  -- insert 
-- values (7,'007864',30048,1,'TCMT 21.51-F1 TP1501',1,3,5.950000)  -- insert 
-- values (8,'010338',1,1,'CCC-23575 REV A',1,1,506.000000)  -- Reamer 
-- values (9,'008410',1,1,'CCC-21216 REV B',1,1,198.000000)  -- Reamer 
-- values (10,'0003396',30048,1,'APFT1604PDTL-D15 MP1500 Insert',1,2,9.810000)  -- insert
-- values (11,'008435',30048,1,'TCMT 110202 LC225T',1,3,10.370000)  -- insert
-- values (12,'009155',30048,1,'SPLT140512N-PH IN2005',1,4,9.980000)  -- insert
-- values (13,'13753',30048,1,'WDXT 156012-H ACK300',1,4,6.952000)  -- insert
-- values (14,'17022',30048,1,'SNMX1407ZNTR-M16 MK2050',1,8,12.510000)  -- insert
-- values (15,'14710',30016,1,'CCC-27629 REV 0',1,1,93.000000)  -- drill
-- values (16,'0000951',2,1,'23910-05',1,1,32.350000)  -- Tap
-- values (17,'16547',30048,1,'CCMT21.52MK MC5015',1,2,6.640000)  -- insert
-- values (18,'010559',30048,1,'CCMT 32.52 -M3 TK1501',1,2,6.030000)  -- insert
-- values (19,'15843',30048,1,'CCMT 432MT TT7015 INSERT',1,2,5.800000)  -- insert
values (20,'14855',30016,1,'CCC-28434 REV 1',1,1,212.000000)  -- drill

delete from Tool where Tool_Key = 5

select * from Tool

/*
 * This corresponds to a Plex tool_bom table.
 * -- THIS WILL NEED TO BE UPDATED AFTER TOOLING MODULE UPLOAD
 */
-- drop table Tool_BOM
-- truncate table Tool_BOM
CREATE TABLE Tool_BOM (
	Tool_BOM_Key int,
	Tool_Key int,
	Assembly_Key int NOT NULL, 
	Quantity_Required decimal (18,2),
	QuantityPerCuttingEdge int,  -- This is take from the Tool List item.
  	PRIMARY KEY (Tool_BOM_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_Tool_BOM';
insert into Tool_BOM (Tool_BOM_Key,Tool_Key,Assembly_Key,Quantity_Required,QuantityPerCuttingEdge) 

-- values (1,1,13,9,200)
-- values (2,2,20,1,3000)
-- values (3,3,23,2,200)
-- values (4,4,23,2,200)
-- values (5,5,23,2,200)  -- Alternate Tool; Obsolete in Plex so delete it; If there are more of these tools they could be used.
-- delete from Tool_BOM where Tool_BOM_Key = 5;
-- values (6,6,22,7,2500)

-- values (7,7,24,1,3000)
-- values (8,7,25,1,3000)

-- values (9,8,26,1,18000)
-- values (10,9,26,1,18000)
-- values (11,10,27,2,800)
-- values (12,11,28,2,5000)
-- values (13,12,21,2,300)
-- values (14,13,21,2,300)
-- values (15,14,14,6,200)
-- values (16,15,15,1,2500)
-- values (17,16,16,1,3000)
-- values (18,17,19,1,350)
-- values (19,18,18,1,1000)
-- values (20,19,18,9,200)
-- values (21,20,17,1,1800)
select * from Tool_BOM

select 
ta.Assembly_No TN,t.Tool_No CribId,tb.QuantityPerCuttingEdge TLife 
/*
-- ta.Description, tt.Tool_Type_Code,tg.Tool_Group_Code,t.Description,tb.Quantity_Required,t.NumberOfCuttingEdges
ca.CNC_Part_Operation_Assembly_Key,
ca.CNC_Key,ca.Part_Key,ca.Operation_Key,ca.Assembly_Key,
c.CNC,p.Part_No,o.Operation_Code,ta.Assembly_No, ta.Description,t.Tool_No,tt.Tool_Type_Code,tg.Tool_Group_Code,ca.Tool_Life,
tb.Quantity_Required,tb.QuantityPerCuttingEdge,t.NumberOfCuttingEdges,t.Price,
t.price/t.NumberOfCuttingEdges Price_Per_Cutting_Edge,
tb.Quantity_Required*(t.price/t.NumberOfCuttingEdges) Price_Per_Tool_Change
*/
from CNC_Part_Operation_Assembly ca 
inner join CNC c 
on ca.CNC_Key=c.CNC_Key -- 1 to 1
inner join Part p 
on ca.Part_Key = p.Part_Key 
inner join Operation o 
on ca.Operation_Key = o.Operation_Key 
inner join Tool_Assembly ta 
on ca.Assembly_Key=ta.Assembly_Key   -- 1 to 1
inner join Tool_BOM tb 
on ca.Assembly_Key = tb.Assembly_Key  -- 1 to many
inner join Tool t 
on tb.Tool_Key=t.Tool_Key -- 1 to many
inner join Tool_Type tt 
on t.Tool_Type_Key=tt.Tool_Type_Key  -- 1 to 1
inner join Tool_Group tg 
on t.Tool_Group_Key=tg.Tool_Group_key  -- 1 to 1
where c.CNC='120'
select * from CNC

select * from Tool_Assembly ta where Assembly_Key = 18
/*
tn|item   |qty  
--|-------|-----
 1|009196 |  200
 4|17100  | 3000
 6|009240 |  200
 6|15721  |  200
 6|008318 |  200
 7|008485 | 2500
 8|007864 | 3000
 9|007864 | 3000
12|008410 |18000
12|010338 |18000
13|0003396|  800
14|008435 | 5000
15|009155 |  300
15|13753  |  300
21|17022  |  200
22|14710  | 2500
23|0000951| 3000
30|16547  |  350
33|15843  |  200
33|010559 | 1000
72|14855  | 1800
 */
-- P558 LH Knuckles
select * from Tool_BOM
/*
14|T21        |2IN FACEMILL             
15|T22        |M6 TAP DRILL             
16|T23        |M6X1 TAP                 
17|T72        |15.1MM DRILL             
18|T33        |ROUGH BORE               
19|T30        |FINISH CENTER BORE       
21|T15        |1.937 INDEXABLE DRILL    
22|T7         |ROUGH DATUM J BORE       
23|T6         |ROUGH DATUM L BORE       
24|T9         |DATUM L 44.330MM ROMICRON
25|T8         |DATUM J 50.110MM ROMICRON
26|T12        |TAPER DREAMER            
27|T13        |PLUNGE MILL              
28|T14        |CHAMFER MILL             
 */

/*
      198|         8.08875000000000
      798|       276.00000000000000
      198|         4.38500000000000
      198|         6.28500000000000
      198|         5.47500000000000
     2498|        34.37000000000000
     3498|         1.98333333300000
     3498|         1.98333333300000
    17998|       506.00000000000000
    17998|       198.00000000000000
      798|         9.81000000000000
     4998|         6.91333333200000
      298|         4.99000000000000
      298|         3.47600000000000
      198|         9.38250000000000
     2498|        93.00000000000000
     2998|        32.35000000000000
      348|         3.32000000000000
      198|         0.60300000000000
      198|        26.10000000000000
     1798|       212.00000000000000
 */



-- select * from Tool_Assembly ta2 

-- Quantity,QuantityPerCuttingEdge,NumberOfCuttingEdges,
-- P558 LH Knuckles
-- values (13,2794706,51168,13)
-- values (14,2794706,51168,14)
-- values (15,2794706,51168,15)
-- values (16,2794706,51168,16)
-- values (17,2794706,51168,17)
-- values (18,2794706,51168,18)
-- values (19,2794706,51168,19)
-- values (20,2794706,51168,20)
-- values (21,2794706,51168,21)
-- values (22,2794706,51168,22)
-- values (23,2794706,51168,23)
-- values (24,2794706,51168,24)
-- values (25,2794706,51168,25)
-- values (26,2794706,51168,26)
-- values (27,2794706,51168,27)
-- values (28,2794706,51168,28)
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


-- 009196|INSERT
/*
 * UDP Datagrams sent from Moxa units.
 * Common variablies used as assembly counters are identified by an CNC_Part_Operation_Key, Set_No, and Block_No 
 * when sent to the UDP server.  This table links the assembly counter value to a Tool_Assembly_Part record.
 */
-- UPDATE ASSEMBLY KEY AFTER TOOLING UPLOAD
-- drop table CNC_Part_Operation_Set_Block 
CREATE TABLE CNC_Part_Operation_Set_Block (
	CNC_Part_Operation_Set_Block_Key int NOT NULL,   -- each CNC_Part_Operation_Key, Set_No, Block_No combination maps to 1 CNC, Part, Part_Operation, Assembly_Key pair.
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Set_No int NOT NULL,  -- Can't avoid this Set_No because of the way the Moxa receives messages from the Okuma's serial port.
	Block_No int NOT NULL,  -- This is just an index to identify which 10-byte block in a datagram set. 
	Assembly_Key int NOT NULL, -- foreign key
  	PRIMARY KEY (CNC_Part_Operation_Set_Block_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='UDP Datagrams sent from Moxa units';
-- select * from CNC_Part_Operation_Set_Block
insert into CNC_Part_Operation_Set_Block (CNC_Part_Operation_Set_Block_Key,CNC_Key,Part_Key,Operation_Key,Set_No,Block_No,Assembly_Key)
-- values (13,3,2794706,51168,1,1,13)
-- values (14,3,2794706,51168,1,2,14)
-- values (15,3,2794706,51168,1,3,15)
-- values (16,3,2794706,51168,1,4,16)
-- values (17,3,2794706,51168,1,5,17)
-- values (18,3,2794706,51168,1,6,18)
-- values (19,3,2794706,51168,1,7,19)
-- values (20,3,2794706,51168,1,8,20)
-- values (21,3,2794706,51168,1,9,21)

-- values (22,3,2794706,51168,2,1,22)
-- values (23,3,2794706,51168,2,2,23)
-- values (24,3,2794706,51168,2,3,24)
-- values (25,3,2794706,51168,2,4,25)
-- values (26,3,2794706,51168,2,5,26)

-- values (27,3,2794706,51168,3,1,27)
-- values (28,3,2794706,51168,3,2,28)


-- RDX,CNC103
-- values (1,1,2809196,56409,1,1,1)
-- values (2,1,2809196,56409,1,2,2)
-- values (3,1,2809196,56409,1,3,3)
-- values (4,1,2809196,56409,1,4,4)
-- values (5,1,2809196,56409,1,5,5)
-- values (6,1,2809196,56409,1,6,6)
-- values (7,1,2809196,56409,1,7,7)
-- values (8,1,2809196,56409,1,8,8)
-- values (9,1,2809196,56409,1,9,9)
-- values (10,1,2809196,56409,2,1,10)
-- values (11,1,2809196,56409,2,2,11)
-- values (12,1,2809196,56409,2,3,12)
select * from CNC_Part_Operation_Set_Block
/*
 * CNC tool life for assembly from TLM.SSB
 */
-- drop table CNC_Part_Operation_Assembly 
-- truncate table CNC_Part_Operation_Assembly
CREATE TABLE CNC_Part_Operation_Assembly (
	CNC_Part_Operation_Assembly_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Increment_By int NOT NULL,
	Tool_Life int NOT NULL,  
	-- Tool Life per cutting edge,Can be different for every CNC, corresponds to QuantityPerCuttingEdge, The average of when the tool is changed.
	-- If there are multiple cutting tools this will be the tool life of the tool with the minimum tool life. 
	-- This number is take from OTLM.SSB of the CNC and not from the tool list.
  	Current_Value int NOT NULL,
  	Fastest_Cycle_Time int NOT NULL, -- In seconds
  	Last_Update datetime NOT NULL,
  	PRIMARY KEY (CNC_Part_Operation_Assembly_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC Part operation assembly info';



-- 5 * 60 = 300
select 
ta.Assembly_No Tool_No,
ca.Tool_Life
from CNC_Part_Operation_Assembly ca 
inner join Tool_Assembly ta  
on ca.Assembly_Key = ta.Assembly_Key 
where ca.CNC_Key = 3


set @Last_Update = '2020-08-15 00:00:00';
insert into CNC_Part_Operation_Assembly (CNC_Part_Operation_Assembly_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key,Increment_By,Tool_Life,Current_Value,Fastest_Cycle_Time,Last_Update)
-- P558 LH Knuckles, CNC120
-- values (13,3,2794706,51168,13,2,200,-1,600,@Last_Update )  -- vc1
-- values (14,3,2794706,51168,14,2,200,-1,600,@Last_Update )  -- vc21
-- values (15,3,2794706,51168,15,2,2500,-1,600,@Last_Update )  -- vc22
-- values (16,3,2794706,51168,16,2,3000,-1,600,@Last_Update )  -- vc23
-- values (17,3,2794706,51168,17,2,1800,-1,600,@Last_Update )  -- vc72
-- values (18,3,2794706,51168,18,2,200,-1,600,@Last_Update )  -- vc33
-- values (19,3,2794706,51168,19,2,350,-1,600,@Last_Update )  -- vc30
-- values (20,3,2794706,51168,20,2,3000,-1,600,@Last_Update )  -- vc4
-- values (21,3,2794706,51168,21,2,300,-1,600,@Last_Update )  -- vc15
-- values (22,3,2794706,51168,22,2,2500,-1,600,@Last_Update )  -- vc7
-- values (23,3,2794706,51168,23,2,200,-1,600,@Last_Update )  -- vc6
-- values (24,3,2794706,51168,24,2,3000,-1,600,@Last_Update )  -- vc9
-- values (25,3,2794706,51168,25,2,3000,-1,600,@Last_Update )  -- vc8
-- values (26,3,2794706,51168,26,2,18000,-1,600,@Last_Update )  -- vc12
-- values (27,3,2794706,51168,27,2,800,-1,600,@Last_Update )  -- vc13
-- values (28,3,2794706,51168,28,2,5000,-1,600,@Last_Update )  -- vc14
-- update CNC_Part_Operation_Assembly 
set Tool_Life = 5000
where CNC_Part_Operation_Assembly_Key = 28

/*
 
 */

-- RDX, CNC 103
-- values (1,1,2809196,56409,1,2,80500,-1,300,@Last_Update )  -- vc10
-- values (2,1,2809196,56409,2,2,132000,-1,300,@Last_Update)  -- vc11
-- values (3,1,2809196,56409,3,2,52600,-1,300,@Last_Update)
-- values (4,1,2809196,56409,4,2,78000,-1,300,@Last_Update)  -- vc12
-- values (5,1,2809196,56409,5,2,40000,-1,300,@Last_Update)
-- values (6,1,2809196,56409,6,2,999999,-1,300,@Last_Update)
-- values (7,1,2809196,56409,7,2,72000,-1,300,@Last_Update)
-- values (8,1,2809196,56409,8,2,50000,-1,300,@Last_Update)
-- values (9,1,2809196,56409,9,2,999999,-1,300,@Last_Update)
-- values (10,1,2809196,56409,10,2,110000,-1,300,@Last_Update)
-- values (11,1,2809196,56409,11,2,100000,-1,300,@Last_Update)
-- values (12,1,2809196,56409,12,2,110000,-1,300,@Last_Update)
-- delete from CNC_Part_Operation_Assembly a where CNC_Part_Operation_Assembly_Key in (2,4)
select * from CNC_Part_Operation_Assembly



--update CNC_Part_Operation_Assembly 
--set Tool_Life = 50000 
-- set Tool_Life = 50000, Last_Update = '2020-08-15 00:00:00' 
where CNC_Key = 1 and Part_Key = 2809196 and Assembly_Key = 11

select * from CNC_Part_Operation_Assembly
where CNC_Key = 1 and Part_Key = 2809196 and assembly_key = 1

set @CNC_Part_Operation_Key = 1;
set @Set_No = 1;
set @Block_No = 1;

CALL GetIncrementBy(@CNC_Part_Operation_Key,@Set_No,@Block_No,@IncrementBy,@Return_Value);

SELECT @IncrementBy,@Return_Value;

/*
 * So that we don't have to maintain a configuration file for UDP13319 we have
 * stored assembly counter increment values in a table. 
 */
-- DROP PROCEDURE GetIncrementBy;
CREATE PROCEDURE GetIncrementBy
(
	pCNC_Part_Operation_Key INT,
	pSet_No INT,
	pBlock_No INT,
	OUT pIncrementBy INT,
	OUT pReturnValue INT 
)
BEGIN

	select 
	-- p.CNC_Key,p.Part_Key,p.Operation_Key,b.Set_No,b.Block_No,b.Assembly_Key,
	a.Increment_By into pIncrementBy
	from CNC_Part_Operation p
	inner join CNC_Part_Operation_Set_Block b 
	on p.CNC_Key = b.CNC_Key
	and p.Part_Key = b.Part_Key
	and p.Operation_Key = b.Operation_Key
	inner join CNC_Part_Operation_Assembly a
	on b.CNC_Key = a.CNC_Key
	and b.Part_Key = a.Part_Key
	and b.Operation_Key = a.Operation_Key
	and b.Assembly_Key = a.Assembly_Key
	where CNC_Part_Operation_Key=pCNC_Part_Operation_Key and b.Set_No = pSet_No and b.Block_No = pBlock_No;
   	-- SELECT ROW_COUNT(); -- 0
   	-- set pRecordCount = FOUND_ROWS();
   	set pReturnValue = 0;
end;	

/*
 * Report query
 */

/*
 Published UpdateCNCPartOperationAssembly => {"CNC_Part_Operation_Key":2,"Set_No":1,"Block_No":4,"Current_Value":1182,"Last_Update":"2020-09-22 07:51:51"}
app13319    | updated currentAssembly.Current_Value=1182
app13319    | Tracker13319 => {"CNC_Part_Operation_Key":2,"Set_No":1,"Block_No":4,"Current_Value":1182,"Last_Update":"2020-09-22 07:51:51"}
*/
/*
set @Last_Update = '2020-09-22 08:33:51';
    select
    a.Last_Update,
    @Last_Update,
    TIMESTAMPDIFF(SECOND, a.Last_Update, @Last_Update),
   a.Fastest_Cycle_Time
   	from CNC_Part_Operation p
	inner join CNC_Part_Operation_Set_Block b 
	on p.CNC_Key = b.CNC_Key
	and p.Part_Key = b.Part_Key
	and p.Operation_Key = b.Operation_Key  -- 1 to many
	inner join CNC_Part_Operation_Assembly a
	on b.CNC_Key = a.CNC_Key
	and b.Part_Key = a.Part_Key 
	and b.Operation_Key = a.Operation_Key 
	and b.Assembly_Key = a.Assembly_Key 
	where p.CNC_Part_Operation_Key=2 
    and b.Set_No = 1 and b.Block_No = 4;
	
	
  	set a.Fastest_Cycle_Time = case 
	when TIMESTAMPDIFF(SECOND, a.Last_Update, pLast_Update) < a.Fastest_Cycle_Time then  TIMESTAMPDIFF(SECOND, a.Last_Update, pLast_Update)
	else a.Fastest_Cycle_Time 
	end
	where p.CNC_Part_Operation_Key=pCNC_Part_Operation_Key 
    and b.Set_No = pSet_No and b.Block_No = pBlock_No;

select a.Fastest_Cycle_Time,a.CNC_Key  
from CNC_Part_Operation_Assembly a
-- update CNC_Part_Operation_Assembly 
set Fastest_Cycle_Time = 999999
*/



DROP PROCEDURE UpdateCNCPartOperationAssembly;
CREATE PROCEDURE UpdateCNCPartOperationAssembly
(
	IN pCNC_Part_Operation_Key INT,
	IN pSet_No INT,
	IN pBlock_No INT,
	IN pCurrent_Value INT,
	IN pLast_Update datetime,
	OUT pReturnValue INT 
)
BEGIN

/* Debug only Section Start*/
	/*
	set @CNC_Part_Operation_Key = 1;
	set @Set_No = 1;
	set @Block_No = 1;
	set @Current_Value = 9999;
	set @Last_Update = '2020-08-028 10:10:00:00';

	select a.Fastest_Cycle_TimeStart,
	-- syntax is "old date" - :"new date", so:
	TIMESTAMPDIFF(SECOND, a.Last_Update, @Last_Update),
	case 
	when TIMESTAMPDIFF(SECOND, a.Last_Update, @Last_Update) < a.Fastest_Cycle_Time then 'New Fastest time'
	else 'Not faster'
	end compareFastestCycleTime
--	 SELECT TIMESTAMPDIFF(SECOND, '2018-11-14 15:00:00', '2018-11-15 15:00:30')
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
  --	set a.Current_Value = pCurrent_Value,
 -- 	a.Last_Update = pLast_Update

	where p.CNC_Part_Operation_Key=@CNC_Part_Operation_Key 
    and b.Set_No = @Set_No and b.Block_No = @Block_No;	
	
   select * from CNC_Part_Operation_Assembly a
   */
/* Debug only Section End */  
    update
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
  	set a.Fastest_Cycle_Time = case 
	when TIMESTAMPDIFF(SECOND, a.Last_Update, pLast_Update) < a.Fastest_Cycle_Time then  TIMESTAMPDIFF(SECOND, a.Last_Update, pLast_Update)
	else a.Fastest_Cycle_Time 
	end
	where p.CNC_Part_Operation_Key=pCNC_Part_Operation_Key 
    and b.Set_No = pSet_No and b.Block_No = pBlock_No;

   /*
    * Two update states needed since the first has a case clause.
    */
    update
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
  	set a.Current_Value = pCurrent_Value,
  	a.Last_Update = pLast_Update
	where p.CNC_Part_Operation_Key=pCNC_Part_Operation_Key 
    and b.Set_No = pSet_No and b.Block_No = pBlock_No;

   
-- SELECT ROW_COUNT(); -- 0
   	-- set pRecordCount = FOUND_ROWS();
   	set pReturnValue = 0;
end;	


set @CNC_Part_Operation_Key = 1;
set @Set_No = 1;
set @Block_No = 1;
set @Current_Value = 19342;
set @Last_Update = '2020-08-28 10:15:49';
-- CNC_Part_Operation_Key=1,Set_No=1,Block_No=1,Current_Value=18136,Last_Update=2020-08-25 10:38:27
-- "CNC_Part_Operation_Key":1,"Set_No":1,"Block_No":7,"Current_Value":29392,"Trans_Date":"2020-08-25 10:17:55"
-- select a.* from CNC_Part_Operation_Assembly a
CALL UpdateCNCPartOperationAssembly(@CNC_Part_Operation_Key,@Set_No,@Block_No,@Current_Value,@Last_Update,@Return_Value);
	 -- UpdateCNCPartOperationAssemblyCurrentValue(?,?,?,?,?,@ReturnValue); select @ReturnValue as pReturnValue
SELECT @Return_Value;

select * from CNC_Part_Operation_Assembly
where CNC_Key=1 and Part_Key=2809196 and Operation_Key = 56409 and Assembly_Key=1;

-- drop table Tool_Assembly_Change_History
CREATE TABLE Tool_Assembly_Change_History (
	Tool_Assembly_Change_History_Key int NOT NULL AUTO_INCREMENT,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Assembly_Key int NOT NULL,
  	Actual_Tool_Assembly_Life int NOT NULL,
  	Trans_Date datetime NOT NULL,
  	PRIMARY KEY (Tool_Assembly_Change_History_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Tool assembly change history';

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

/*
 * The only information we have at the CNC is a CNC_Part_Operation_Key,Set_No,Block_No,
 * so we have to use this info to link to CNC_Part_Operation_Assembly table.
 *
 */
-- drop procedure InsToolAssemblyChangeHistory;
CREATE PROCEDURE InsToolAssemblyChangeHistory(
	IN pCNC_Part_Operation_Key INT,
	IN pSet_No INT,
	IN pBlock_No INT,
	IN pActual_Tool_Assembly_Life INT,
  	IN pTrans_Date datetime,
  	OUT pTool_Assembly_Change_History_Key INT,
	OUT pReturnValue INT 
)
BEGIN
-- truncate table Tool_Assembly_Change_History	
/*
	set @CNC_Key = 1;
set @Part_Key = 1;
set @Operation_Key = 1;
set @Assembly_Key = 1;
set @Actual_Tool_Life = 2;
set @Trans_Date = '2020-08-18 00:00:01';	
	set @pCNC_Part_Operation_Key = 1;
	set @pSet_No = 1;
	set @pBlock_No = 1;
    set @pActual_Tool_Life = 12;
	set @pTrans_Date = '2020-08-18 00:00:01';	
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
select * from Tool_Assembly_Change_History

-- truncate table Tool_Assembly_Change_History
set @CNC_Part_Operation_Key = 1;
set @Set_No = 1;
set @Block_No = 1;
set @Actual_Tool_Assembly_Life = 80500;
set @Trans_Date = '2020-09-05 09:50:00';
CALL InsToolAssemblyChangeHistory(@CNC_Part_Operation_Key,@Set_No,@Block_No,@Actual_Tool_Assembly_Life,@Trans_Date,@Tool_Assembly_Change_History_Key,@Return_Value);
SELECT @Tool_Assembly_Change_History_Key,@Return_Value;


/*
 * Phase 2:
 * There may be multiple cutting tools per tool assembly.
 * Each cutting tool can have a different tool life.
 * Can't store this info in Tool_BOM because an assembly can be on more than 1 CNC part operation.
 * This must be manually entered by the tool setter via an HMI.
 */

CREATE TABLE Tool_Life_History (
	TOOL_Life_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Tool_Key int NOT NULL,
	Tool_Life int NOT NULL,
	Trans_Date datetime NOT NULL
)

-- values (1,1,2794706,51168,13,1,198,-1,600,@Last_Update )  -- vc1
-- values (14,3,2794706,51168,14,2,198,-1,600,@Last_Update )  -- vc21
-- values (15,3,2794706,51168,15,2,2498,-1,600,@Last_Update )  -- vc22
-- values (16,3,2794706,51168,16,2,2998,-1,600,@Last_Update )  -- vc23
-- values (17,3,2794706,51168,17,2,1798,-1,600,@Last_Update )  -- vc72
-- values (18,3,2794706,51168,18,2,198,-1,600,@Last_Update )  -- vc33
-- values (19,3,2794706,51168,19,2,348,-1,600,@Last_Update )  -- vc30
-- values (20,3,2794706,51168,20,2,798,-1,600,@Last_Update )  -- vc4
-- values (21,3,2794706,51168,21,2,298,-1,600,@Last_Update )  -- vc15
-- values (22,3,2794706,51168,22,2,2498,-1,600,@Last_Update )  -- vc7
-- values (23,3,2794706,51168,23,2,198,-1,600,@Last_Update )  -- vc6
-- values (24,3,2794706,51168,24,2,3498,-1,600,@Last_Update )  -- vc9
-- values (25,3,2794706,51168,25,2,3498,-1,600,@Last_Update )  -- vc8
-- values (26,3,2794706,51168,26,2,17998,-1,600,@Last_Update )  -- vc12
-- values (27,3,2794706,51168,27,2,798,-1,600,@Last_Update )  -- vc13
-- values (28,3,2794706,51168,28,2,4998,-1,600,@Last_Update )  -- vc14


set @Trans_Date = '2020-09-14 09:50:00';
call GenerateToolAssemblyChangeHistory(@Trans_Date);

/*
(CNC_Part_Operation_Assembly_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key,Increment_By,Tool_Life,Current_Value,Fastest_Cycle_Time,Last_Update)
                             Assembly_Key 
-- values (12,1,2809196,56409,12,2,110000,-1,300,@Last_Update)

CNC_Part_Operation_Set_Block (CNC_Part_Operation_Set_Block_Key,CNC_Key,Part_Key,Operation_Key,Set_No,Block_No,Assembly_Key)
                                 Assembly_Key
-- values (1,1,2809196,56409,1,1,1)
-- values (2,1,2809196,56409,1,2,2)
-- values (3,1,2809196,56409,1,3,3)
-- values (4,1,2809196,56409,1,4,4)
-- values (5,1,2809196,56409,1,5,5)
-- values (6,1,2809196,56409,1,6,6)
-- values (7,1,2809196,56409,1,7,7)
-- values (8,1,2809196,56409,1,8,8)
-- values (9,1,2809196,56409,1,9,9)
-- values (10,1,2809196,56409,2,1,10)
-- values (11,1,2809196,56409,2,2,11)
-- values (12,1,2809196,56409,2,3,12)

*/

select
c.CNC,ta.Assembly_No,ta.Description,
tc.Actual_Tool_Assembly_Life,
Trans_Date
 

-- tc.* 
from Tool_Assembly_Change_History tc 
		inner join CNC c 
		on tc.CNC_Key = c.CNC_Key  -- 1 to 1 
		inner join CNC_Workcenter cw 
		on c.CNC_Key = cw.CNC_Key -- 1 to 1
		inner join Workcenter w 
		on cw.Workcenter_Key = w.Workcenter_Key  -- 1 to 1 
		inner join Building b 
		on w.Building_Key = b.Building_Key -- 1 to 1
		inner join CNC_Part_Operation_Assembly cp 
		on tc.CNC_Key = cp.CNC_Key 
		and tc.Part_Key = cp.Part_Key 
		and tc.Operation_Key = cp.Operation_Key 
		and tc.Assembly_Key = cp.Assembly_Key  -- 1 to 1 
		inner join Part p 
		on tc.Part_Key = p.Part_Key -- 1 to 1
		inner join Operation o 
		on tc.Operation_Key = o.Operation_Key -- 1 to 1
		inner join Tool_Assembly ta  
		on tc.Assembly_Key=ta.Assembly_Key -- 1 to 1

where tc.CNC_Key = 3 

/*
 * Tool life detail report 
 * Test data has the same trans_date
 */
-- GenerateToolAssemblyChangeHistory
select 
c.CNC, 
p.Name,
CONCAT(CONCAT(p.Part_No,' Rev'),p.Revision) Part_No, 
o.Operation_Code,
ta.Assembly_No,
ta.Description, 
cp.Tool_Life,
tc.Actual_Tool_Assembly_Life,
tc.Trans_Date 
from Tool_Assembly_Change_History tc 
inner join CNC c 
on tc.CNC_Key = c.CNC_Key  -- 1 to 1 
inner join CNC_Part_Operation_Assembly cp 
on tc.CNC_Key = cp.CNC_Key 
and tc.Part_Key = cp.Part_Key 
and tc.Operation_Key = cp.Operation_Key 
and tc.Assembly_Key = cp.Assembly_Key  -- 1 to 1 
inner join Part p 
on tc.Part_Key = p.Part_Key -- 1 to 1
inner join Operation o 
on tc.Operation_Key = o.Operation_Key -- 1 to 1
inner join Tool_Assembly ta  
on tc.Assembly_Key=ta.Assembly_Key -- 1 to 1


  set @startDate = '2020-09-05 09:50:00';
  set @endDate = '2020-09-08 23:59:59';
  set @tableName = 'rpt0909a';
-- select * from rpt0909a;
-- select @returnValue;
-- drop table rpt0909a;
--   CreateToolChangeSummary(?,?,?,@recordCount,@returnValue)
call CreateToolChangeSummary(@startDate,@endDate,@tableName,@recordCount,@returnValue);
select @recordCount,@returnValue;

select @recordCount,@returnValue;
select * from test0902 t2; 
select * from rpt0909a

set @Building_Key = 5680;
set @tableName = 'test0901a';

call CreateUpcomingToolChanges(@Building_Key,@tableName,@recordCount,@returnValue);
select @recordCount,@returnValue;

DROP PROCEDURE CreateToolChangeSummary;

/*
 * Tool assembly change summary report 
 */

CREATE DEFINER=`brent`@`%` PROCEDURE `mach2`.`CreateToolChangeSummary`(
	pStartDate DATETIME,
	pEndDate DATETIME,
	pTableName varchar(12),
	OUT pRecordCount INT,
	OUT pReturnValue INT
)
BEGIN
	DECLARE startDate,endDate DATETIME;
	DECLARE tableName varchar(12);

	SET tableName = pTableName;
	set startDate =pStartDate;
	set endDate =pEndDate;

	SET @sqlQuery = CONCAT('DROP TABLE IF EXISTS ',tableName);
   	PREPARE stmt FROM @sqlQuery;
	execute stmt;
    DEALLOCATE PREPARE stmt;
   
  -- set @startDate = '2020-09-05 09:50:00';
  -- set @endDate = '2020-09-08 23:59:59';
  -- set @tableName = 'test0907';
	set @results = 
	CONCAT('
	select 
	s1.CNC,
	s1.Name,
	s1.Part_No,
	s1.Operation_Code,
	s1.Assembly_No,
	s1.Description,
	s1.Tool_Life,
	round(sum(s1.Actual_Tool_Assembly_Life) / count(*),0) Avg_Tool_Life
	from 
	(
		select 
		cp.CNC_Part_Operation_Assembly_Key, 
		c.CNC, 
		p.Name,
		CONCAT(CONCAT(p.Part_No," Rev"),p.Revision) Part_No, 
		o.Operation_Code,
		ta.Assembly_No,
		ta.Description, 
		cp.Tool_Life,
		tc.Actual_Tool_Assembly_Life,
		tc.Trans_Date 
		from Tool_Assembly_Change_History tc 
		inner join CNC c 
		on tc.CNC_Key = c.CNC_Key  -- 1 to 1 
		inner join CNC_Part_Operation_Assembly cp 
		on tc.CNC_Key = cp.CNC_Key 
		and tc.Part_Key = cp.Part_Key 
		and tc.Operation_Key = cp.Operation_Key 
		and tc.Assembly_Key = cp.Assembly_Key  -- 1 to 1 
		inner join Part p 
		on tc.Part_Key = p.Part_Key -- 1 to 1
		inner join Operation o 
		on tc.Operation_Key = o.Operation_Key -- 1 to 1
		inner join Tool_Assembly ta  
		on tc.Assembly_Key=ta.Assembly_Key -- 1 to 1
		where tc.Trans_Date BETWEEN \'', startDate,'\' and \'', endDate,'\'
	)s1
	group by s1.CNC_Part_Operation_Assembly_Key,s1.CNC,s1.Name,s1.Part_No,s1.Operation_Code,s1.Assembly_No,s1.Description,s1.Tool_Life;');
	-- select @results;
	
	set @sqlQuery = CONCAT('create table ',tableName,@results);
	PREPARE stmt FROM @sqlQuery;
	execute stmt;
    DEALLOCATE PREPARE stmt;
	set pRecordCount = FOUND_ROWS();
	set pReturnValue = 1;
end;


/*
set pRecordCount = FOUND_ROWS();
MySQL says it is depreciated
https://mariadb.com/kb/en/found_rows/
https://dev.mysql.com/doc/refman/5.7/en/set-variable.html
*/
/*
  	set pRecordCount = FOUND_ROWS();
	set pReturnValue = 1;
	set @sqlQuery = CONCAT('create table ',pTableName,@results);
	PREPARE stmt FROM @sqlQuery;
	execute stmt;
    DEALLOCATE PREPARE stmt;

   	set pRecordCount = FOUND_ROWS();
	set pReturnValue = 0;

 */
select * from CNC_Part_Operation_Assembly

/*
Tool Assembly Tool Change Report query
*/

-- drop procedure CreateUpcomingToolChanges;
	Format(a.Fastest_Cycle_Time,0) iFastest_Cycle_Time

CREATE DEFINER=`brent`@`%` PROCEDURE `mach2`.`CreateUpcomingToolChanges`(
	IN pBuilding_Key INT,
	IN pTableName varchar(12),
	OUT pRecordCount INT, 	
	OUT pReturnValue INT 
)
BEGIN

	DECLARE tableName varchar(12);

   set @pBuilding_Key = 5680;
   set @pTableName = 'test0901';


	-- SET tableName = pTableName;
	SET @sqlQuery = CONCAT('DROP TABLE IF EXISTS ',pTableName);
   	PREPARE stmt FROM @sqlQuery;
	execute stmt;
    DEALLOCATE PREPARE stmt;

   -- set @pBuilding_Key = 5680;
  -- set @pTableName = 'test0901';
	set @results = 
	CONCAT(' select 
	-- b.Building_Code,b.Name,
	-- w.Workcenter_Code, w.Name,
	ROW_NUMBER() OVER (
	  ORDER BY (((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time)
	) primary_key,
	b.Building_No, 
	c.CNC, 
	p.Part_No,
	-- p.Part_No,p.Revision,o.Operation_Code,
	ta.Assembly_No,
	ta.Description,
	Format(a.Tool_Life,0) Tool_Life,
	Format(a.Current_Value,0) Current_Value,
	-- (a.Tool_Life - a.Current_Value) Diff,
	-- ((a.Tool_Life - a.Current_Value) / a.Increment_By) Cycles_Remaining,
	-- (((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time) Seconds_Remaining,
	-- ((((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time) / 60) Minutes_Remaining,
	Format(Floor(((((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time) / 60)),0) iMinutes_Remaining,
	-- Floor(((((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time) % 60)) Seconds,
	DATE_FORMAT(a.Last_Update,"%m/%d/%Y %h:%i") Last_Update,
	Format(a.Fastest_Cycle_Time,0) iFastest_Cycle_Time 
	-- select DATEselect DATE_FORMAT(NOW(),"%m/%d/%Y %h:%i") Last_Update _FORMAT(NOW(),"%m/%d/%Y %h:%i") Last_Update 
	from CNC_Part_Operation_Assembly a
	inner join Tool_Assembly ta
	on a.Assembly_Key=ta.Assembly_Key
	inner join CNC_Part_Operation cpo 
	on a.CNC_Key = cpo.CNC_Key -- 1 to 1
	inner join Part p 
	on cpo.Part_Key = p.Part_Key -- 1 to 1 
	inner join Operation o 
	on cpo.Operation_Key = o.Operation_Key
	inner join CNC_Workcenter cw 
	on a.CNC_Key = cw.CNC_Key   -- 1 to 1
	inner join Workcenter w 
	on cw.Workcenter_Key = w.Workcenter_Key -- 1 to 1 
	inner join Building b 
	on w.Building_Key = b.Building_Key
	inner join CNC c 
	on a.CNC_Key = c.CNC_Key
	where b.Building_Key =',cast(pBuilding_Key as char));
	-- set @results = CONCAT(@results,' order by (((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time)');
    -- select @results;
    /*
	PREPARE stmt FROM @results;
	execute stmt;
    DEALLOCATE PREPARE stmt;
	*/

	set @sqlQuery = CONCAT('create table ',pTableName,@results);
	PREPARE stmt FROM @sqlQuery;
	execute stmt;
    DEALLOCATE PREPARE stmt;

   	set pRecordCount = FOUND_ROWS();
	set pReturnValue = 1;
   
END;

select * from CNC_Part_Operation_Assembly a

-- set @Building_Key = 5680;  -- Avilla
set @Building_Key = 5644;  -- Plant 6
set @tableName = 'test0901a';

call CreateUpcomingToolChanges(@Building_Key,@tableName,@recordCount,@returnValue);
select @recordCount,@returnValue;
select @returnValue;
select * from test0901a
-- drop table test0901
select * from rpt09020
CREATE PROCEDURE FetchUpcomingToolChanges(
	IN pBuilding_Key INT,
	OUT pReturnValue INT 
)
