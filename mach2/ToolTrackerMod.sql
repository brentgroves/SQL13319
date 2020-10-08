/*
 * PlexExt Table
 * Maintain data specific to a tool assembly of a CNC part operation 
 * select * from Part_Operation_V2
 */
-- drop table CNC_Part_Operation_Assembly_V2 
-- truncate table CNC_Part_Operation_Assembly_V2
CREATE TABLE Tool_Assembly_Part_Ext_V2 (
	Plexus_Customer_No int,
	Tool_Assembly_Part_Ext_Key int NOT NULL,
	Tool_Assembly_Part_Key int NOT NULL,  -- This is a key into the standard Plex table.  Which can ensure we don't have to enter reduntant info into PlexEXT.
	CNC_Key int NOT NULL,  -- PlexEXT column.
	Part_Key int NOT NULL,
	Part_Operation_Key int NOT NULL,  -- I had the operation_key here but this will give access to more information in the part_operation table as well as the operation_key.
	Assembly_Key int NOT NULL,
	Standard_Tool_Life int NOT NULL,  -- Tool list QuantityPerCuttingEdge. This column is in the Plex part_v_tool table because Plex has to cope with the user wanting  the tool life by tool and not by part.
	Rework_Tool_Life int NOT NULL,  -- This column is in the Plex part_v_tool table
	-- The Tool Life can also be tracked per CNC in the CNC_Part_Operation_Assembly_Tool table.
	Regrind_Count int NOT NULL,  -- Number of regrinds currently in the tool assembly.
	PRIMARY KEY (Plexus_Customer_No,CNC_Part_Operation_Assembly_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Maintain data specific to a tool assembly of a CNC part operation';

insert into CNC_Part_Operation_Assembly_V2 (Plexus_Customer_No,CNC_Part_Operation_Assembly_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key)
-- Avilla
-- RDX, CNC 103
-- values (310507,1,1,2809196,56400,1)  -- vc10
-- values (310507,2,1,2809196,56400,2)  -- vc11
-- values (310507,3,1,2809196,56400,3)
-- values (310507,4,1,2809196,56400,4)  -- vc12
-- values (310507,5,1,2809196,56400,5)
-- values (310507,6,1,2809196,56400,6)
-- values (310507,7,1,2809196,56400,7)
-- values (310507,8,1,2809196,56400,8)
-- values (310507,9,1,2809196,56400,9)
-- values (310507,10,1,2809196,56400,10)
-- values (310507,11,1,2809196,56400,11)
-- values (310507,12,1,2809196,56400,12)
-- delete from CNC_Part_Operation_Assembly_V2 where CNC_Part_Operation_Assembly_Key in (2,4)
select * from CNC_Part_Operation_Assembly_V2
select * from Part_V2 
select * from Operation_V2 
select * from Tool_Assembly_V2 

insert into CNC_Part_Operation_Assembly_V2 (Plexus_Customer_No,CNC_Part_Operation_Assembly_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key)
-- Albion
-- P558 LH Knuckles, CNC120
-- values (300758,13,3,2794706,51168,13)  -- vc1
-- values (300758,14,3,2794706,51168,14)  -- vc21
-- values (300758,15,3,2794706,51168,15)  -- vc22
-- values (300758,16,3,2794706,51168,16)  -- vc23
-- values (300758,17,3,2794706,51168,17,)  -- vc72
-- values (300758,18,3,2794706,51168,18)  -- vc33
-- values (300758,19,3,2794706,51168,19)  -- vc30
-- values (300758,20,3,2794706,51168,20)  -- vc4
-- values (300758,21,3,2794706,51168,21)  -- vc15
-- values (300758,22,3,2794706,51168,22)  -- vc7
-- values (300758,23,3,2794706,51168,23)  -- vc6
-- values (300758,24,3,2794706,51168,24)  -- vc9
-- values (300758,25,3,2794706,51168,25)  -- vc8
-- values (300758,26,3,2794706,51168,26)  -- vc12
-- values (300758,27,3,2794706,51168,27)  -- vc13
-- values (300758,28,3,2794706,51168,28)  -- vc14


-- update CNC_Part_Operation_Assembly_V2 
set Tool_Life = 5000
where CNC_Part_Operation_Assembly_Key = 28
select * from CNC_Part_Operation_Assembly_V2
select * from Part_V2 
select * from Operation_V2 
select * from Tool_Assembly_V2 
