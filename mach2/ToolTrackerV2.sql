/*
 * UDP Datagrams sent from Moxa units.
 * Common variablies used as assembly counters are identified by an CNC_Part_Operation_Key, Set_No, and Block_No 
 * when sent to the UDP server.  This table links the assembly counter value to a Tool_Assembly_Part record.
 */
-- UPDATE ASSEMBLY KEY AFTER TOOLING UPLOAD
-- drop table CNC_Part_Operation_Set_Block 
CREATE TABLE CNC_Part_Operation_Set_Block_V2 (
	CNC_Part_Operation_Set_Block_Key int NOT NULL,   -- each CNC_Part_Operation_Key, Set_No, Block_No combination maps to 1 CNC, Part, Part_Operation, Assembly_Key pair.
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Set_No int NOT NULL,  -- Can't avoid this Set_No because of the way the Moxa receives messages from the Okuma's serial port.
	Block_No int NOT NULL,  -- This is just an index to identify which 10-byte block in a datagram set. 
	Assembly_Key int NOT NULL, -- foreign key
	Tool_Key int NOT NULL, -- foreign key  -- V2 ADDITION used to take into consideration Tool assemblies with multiple cutting tools.
  	PRIMARY KEY (CNC_Part_Operation_Set_Block_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='UDP Datagrams sent from Moxa units';
-- select * from CNC_Part_Operation_Set_Block
-- insert into Tool_BOM (Tool_BOM_Key,Tool_Key,Assembly_Key,Quantity_Required,QuantityPerCuttingEdge)  
-- values (5,5,23,2,200)  -- Alternate Tool; Obsolete in Plex so delete it; If there are more of these tools they could be used.
-- delete from Tool_BOM where Tool_BOM_Key = 5;

-- values (21,20,17,1,1800)

insert into CNC_Part_Operation_Set_Block_V2 (CNC_Part_Operation_Set_Block_Key,CNC_Key,Part_Key,Operation_Key,Set_No,Block_No,Assembly_Key,Tool_Key)

-- P558 LH Knuckles
-- values (13,3,2794706,51168,1,1,13,1)
-- values (14,3,2794706,51168,1,2,14,14)
-- values (15,3,2794706,51168,1,3,15,15)
-- values (16,3,2794706,51168,1,4,16,16)
-- values (17,3,2794706,51168,1,5,17,20)
-- values (18,3,2794706,51168,1,6,18,18)
-- values (19,3,2794706,51168,1,7,18,19)
-- values (20,3,2794706,51168,1,8,19,17)
-- values (21,3,2794706,51168,1,9,20,2)
-- 100 bytes
-- values (22,3,2794706,51168,2,1,21,12)
-- values (23,3,2794706,51168,2,2,21,13)
-- values (24,3,2794706,51168,2,3,22,6)
-- values (25,3,2794706,51168,2,4,23,3)
-- values (26,3,2794706,51168,2,5,23,4)
-- 160 bytes now start over
-- values (27,3,2794706,51168,3,1,24,7)
-- values (28,3,2794706,51168,3,2,25,7)
-- values (29,3,2794706,51168,3,3,26,8)
-- values (30,3,2794706,51168,3,4,26,9)
-- values (31,3,2794706,51168,3,5,27,10)
-- values (32,3,2794706,51168,3,6,28,11)
-- 60/100 bytes

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
