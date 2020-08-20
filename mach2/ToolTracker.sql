/*
 * Subset of Plex part_v_workcenter view.  Plex has multiple CNC assigned to a workcenter.
 * 
 */
-- drop table Workcenter
CREATE TABLE Workcenter (
  	Workcenter_Key int NOT NULL,  
  	Workcenter_Code varchar(50) NOT NULL,  
  	Name varchar (100),
  	PRIMARY KEY (Workcenter_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Subset of Plex part_v_workcenter view.';
insert into Workcenter (Workcenter_Key,Workcenter_Code,Name)
values (2809196,'Honda Civic CNC 359 362','Honda Civic Knuckle LH') 

select * from Workcenter tt 


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
values (1,'103',1,true,false)

select * from CNC


/*
 * Many CNC can be assigned to 1 work center
 */
-- drop table CNC_Workcenter
CREATE TABLE CNC_Workcenter (
	CNC_Workcenter_Key int NOT NULL,
	CNC_Key int NOT NULL,  -- foreign key
  	Workcenter_Key int NOT NULL, -- foreign key
  	PRIMARY KEY (CNC_Workcenter_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Link CNC to a workcenter';
insert into CNC_Workcenter (CNC_Key,Workcenter_Key)
values (1,2809196) 

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
values (2809196,'51393 TJB A040M1','40-M1-','RDX Right Hand','Bracket') 
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
values (56409,'Machine Complete')

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
values (7914696,2809196,56409)
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
values(1,1,2809196,56409)
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

-- values (1,1,2809196,1,73000,-1,@Last_Update )
-- values (2,1,2809196,2,52600,-1,@Last_Update)
-- values (3,1,2809196,3,80500,-1,@Last_Update)
-- values (4,1,2809196,4,130000,-1,@Last_Update)
-- values (5,1,2809196,5,999999,-1,@Last_Update)
-- values (6,1,2809196,6,999999,-1,@Last_Update)
-- values (7,1,2809196,7,110000,-1,@Last_Update)
-- values (8,1,2809196,8,100000,-1,@Last_Update)
-- values (9,1,2809196,9,110000,-1,@Last_Update)
-- values (10,1,2809196,10,72000,-1,@Last_Update)
-- values (11,1,2809196,11,50000,-1,@Last_Update)
-- values (12,1,2809196,12,40000,-1,@Last_Update)



/*
 * UDP Datagrams sent from Moxa units.
 * Common variablies used as assembly counters are identified by an CNC_Part_Operation_Key, Set_No, and Block_No 
 * when sent to the UDP server.  This table links the assembly counter value to a Tool_Assembly_Part record.
 */
-- UPDATE ASSEMBLY KEY AFTER TOOLING UPLOAD
-- drop table CNC_Part_Operation_Set_Block 
CREATE TABLE CNC_Part_Operation_Set_Block (
	CNC_Part_Operation_Set_Block int NOT NULL,
	CNC_Part_Operation_Key int NOT NULL,  -- each Datagram_Key, Set_No, Block_No combination maps to 1 CNC, Part, Part_Operation, Assembly_Key pair.
	Set_No int NOT NULL,  -- Can't avoid this Set_No because of the way the Moxa receives messages from the Okuma's serial port.
	Block_No int NOT NULL,  -- This is just an index to identify which 10-byte block in a datagram set. 
	Assembly_Key int NOT NULL, -- foreign key
  	PRIMARY KEY (CNC_Part_Operation_Set_Block)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='UDP Datagrams sent from Moxa units';

insert into CNC_Part_Operation_Set_Block (CNC_Part_Operation_Set_Block,CNC_Part_Operation_Key,Set_No,Block_No,Assembly_Key)
-- values (1,1,1,1,1)
-- values (2,1,1,2,2)
-- values (3,1,1,3,3)
-- values (4,1,1,4,4)
-- values (5,1,1,5,5)
-- values (6,1,1,6,6)
-- values (7,1,1,7,7)
-- values (8,1,1,8,8)
-- values (9,1,1,9,9)
-- values (10,1,2,1,10)
-- values (11,1,2,2,11)
-- values (12,1,2,3,12)
select * from CNC_Part_Operation_Set_Block
/*
 * CNC tool life for assembly from TLM.SSB
 */
-- drop table CNC_Tool_Tracker 
-- truncate table CNC_Tool_Tracker
CREATE TABLE CNC_Tool_Tracker (
	CNC_Tool_Tracker_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Operation_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Tool_Life int NOT NULL,  -- Can be different for every CNC
  	Current_Value int NOT NULL,
  	Last_Update datetime NOT NULL,
  	PRIMARY KEY (CNC_Tool_Tracker_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC tool tracker info';

set @Last_Update = '2020-08-15 00:00:00';
insert into CNC_Tool_Tracker (CNC_Tool_Tracker_Key,CNC_Key,Part_Key,Assembly_Key,Tool_Life,Current_Value,Last_Update)
-- values (1,1,2809196,1,80500,-1,@Last_Update )
-- values (2,1,2809196,2,130000,-1,@Last_Update)
-- values (3,1,2809196,3,52600,-1,@Last_Update)
-- values (4,1,2809196,4,73000,-1,@Last_Update)
-- values (5,1,2809196,5,40000,-1,@Last_Update)
-- values (6,1,2809196,6,999999,-1,@Last_Update)
-- values (7,1,2809196,7,72000,-1,@Last_Update)
-- values (8,1,2809196,8,50000,-1,@Last_Update)
-- values (9,1,2809196,9,999999,-1,@Last_Update)
-- values (10,1,2809196,10,110000,-1,@Last_Update)
-- values (11,1,2809196,11,100000,-1,@Last_Update)
-- values (12,1,2809196,12,110000,-1,@Last_Update)

select * from CNC_Tool_Tracker


--update CNC_Tool_Tracker 
--set Tool_Life = 50000 
-- set Tool_Life = 50000, Last_Update = '2020-08-15 00:00:00' 
where CNC_Key = 1 and Part_Key = 2809196 and Assembly_Key = 11

select * from CNC_Tool_Tracker 
where CNC_Key = 1 and Part_Key = 2809196 and assembly_key = 1

/*
 * Report query
 */
select 
c.CNC,
p.Part_No,p.Name, 
tt.Tool_Life,tt.Current_Value,tt.Last_Update
from CNC_Tool_Tracker tt 
inner join CNC c 
on tt.CNC_Key=tt.CNC_Key 
inner join Part p 
on tt.Part_Key = p.Part_Key 
/*
	Assembly_Key int NOT NULL, 
	Assembly_No	varchar (50) NOT NULL,
	Description	varchar (100) NOT NULL,

 *  * 	CNC_Tool_Tracker_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Tool_Life int NOT NULL,  -- Can be different for every CNC
  	Current_Value int NOT NULL,
  	Last_Update datetime NOT NULL,

 */

DROP PROCEDURE UpdateTrackerCurrentValue;
CREATE PROCEDURE UpdateTrackerCurrentValue
(
	pCNC_Key INT,
	pPart_Key INT,
	pAssembly_Key INT,
	pCurrent_Value INT,	
	pLast_Update DATETIME,
	OUT pReturnValue INT 
)
BEGIN
   
   	update CNC_Tool_Tracker 
	set Current_Value = pCurrent_Value, Last_Update = pLast_Update
	where CNC_Key = pCNC_Key and Part_Key = pPart_Key and Assembly_Key = pAssembly_Key;

   	-- SELECT ROW_COUNT(); -- 0
   	-- set pRecordCount = FOUND_ROWS();
   	set pReturnValue = 0;
end;	

set @CNC_Key = 1;
set @Part_Key = 2809196;
set @Assembly_Key = 1;
set @Current_Value = 2;
set @Last_Update = '2020-08-15 00:00:01';

CALL UpdateTrackerCurrentValue(@CNC_Key,@Part_Key,@Assembly_Key,@Current_Value,@Last_Update,@Return_Value);

SELECT @Return_Value;

select * from CNC_Tool_Tracker 
where CNC_Key = 1 and Part_Key = 2809196 and assembly_key = 1


-- drop table Tool_Change
CREATE TABLE Tool_Change (
	Tool_Change_Key int NOT NULL AUTO_INCREMENT,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Assembly_Key int NOT NULL,
  	Actual_Tool_Life int NOT NULL,
  	Trans_Date datetime NOT NULL,
  	PRIMARY KEY (Tool_Change_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Tool change history';
select * from Tool_Change tc 
where CNC_Key = 1 and Part_Key = 2809196 and assembly_key = 1

select * from ToolTracker

set @transDate = '2020-06-25 00:00:00';
call InsToolLife(103,12345, 100, @transDate); 
select * from ToolLife where cnc=103 order by CNC, desc
