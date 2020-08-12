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

-- drop table CNC_Workcenter
CREATE TABLE CNC_Workcenter (
	CNC varchar(6),
  	Workcenter_Key int NOT NULL, 
  	PRIMARY KEY (CNC)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Link CNC to a workcenter';
insert into CNC_Workcenter (CNC,Workcenter_Key)
values ('103',2809196) 

select * from CNC_Workcenter
/*
 * Tool List master table 
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

-- drop table Part_Operation
-- truncate table Part_Operation
CREATE TABLE Part_Operation (
	Part_Operation_Key	int NOT NULL,
	Part_Key int NOT NULL,
	Operation_No int NOT NULL,
	Operation_Key int NOT NULL,
	PRIMARY KEY (Part_Operation_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='A subset of fields from Plex part_v_part_operation';
select * from Part_Operation

insert into Part_Operation (Part_Operation_Key,Part_Key,Operation_No,Operation_Key)
values (7914696,2809196,100,56409)

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
 * This corresponds to a Plex tool assembly
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
-- values (1,'T12','86.125MM PRE FINISH BORE')
-- values (2,'T01','85.24MM ROUGH BORE')
-- values (3,'T10','86.925MM FINISH BORE')
-- values (4,'T11','ETCHER')
-- values (5,'T13','180MM BACK CUTTER RH PART ONLY')
-- values (6,'T16','135MM BACK CUTTER RH ONLY')
-- values (7,'T07','8.2MM DRILL')
-- values (8,'T08','14.3MM DRILL/CHAMFER')
-- values (9,'T09','15.5MM DRILL/CHAMFER')
-- values (10,'T04','21MM DRILL/SPOTFACE')
-- values (11,'T05','10MM END MILL')
-- values (12,'T02','1.25\" HELICAL MILL')

select * from Tool_Assembly 



/*
 * CNC info, don't want to have a varchar primary_key
 */
-- drop table CNC 
CREATE TABLE CNC (
	CNC_Key int NOT NULL,
	CNC varchar(10) NOT NULL,
  	PRIMARY KEY (CNC_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC unique identifier';
insert into CNC (CNC_Key,CNC)
values (1,'103')

select * from CNC
/*
 * CNC tool life for assembly from TLM.SSB
 */
-- drop table CNC_Tool_Tracker 
CREATE TABLE CNC_Tool_Tracker (
	CNC_Tool_Tracker_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Part_Key int NOT NULL,
	Assembly_Key int NOT NULL, 
	Tool_Life int NOT NULL,  -- Can be different for every CNC
  	Current_Value int NOT NULL,
  	PRIMARY KEY (CNC_Tool_Tracker_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC tool tracker info';

insert into CNC_Tool_Tracker (CNC_Tool_Tracker_Key,CNC_Key,Part_Key,Assembly_Key,Tool_Life,Current_Value)
-- values (1,1,2809196,1,73000,-1)
-- values (2,1,2809196,2,52600,-1)
-- values (3,1,2809196,3,80500,-1)
-- values (4,1,2809196,4,130000,-1)
-- values (5,1,2809196,5,999999,-1)
-- values (6,1,2809196,6,999999,-1)
-- values (7,1,2809196,7,110000,-1)
-- values (8,1,2809196,8,100000,-1)
-- values (9,1,2809196,9,110000,-1)
-- values (10,1,2809196,10,72000,-1)
-- values (11,1,2809196,11,130000,-1)
-- values (12,1,2809196,12,40000,-1)
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

-- OBSOLETE
-- insert into ToolTracker (ToolTrackerKey,CNC,Workcenter_Key,Workcenter_Code,Part_Key,Part_No,ProcessID,OriginalProcessID,Customer,PartFamily,OperationDescription,ToolID,ToolNumber,OpDescription)
-- values (1,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383254,12,'86.125MM PRE FINISH BORE') 
-- values (2,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383255,1,'85.24MM ROUGH BORE') 
-- values (3,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383256,10,'86.925MM FINISH BORE') 
-- values (4,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383257,11,'ETCHER')
-- values (5,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383258,13,'180MM BACK CUTTER RH PART ONLY') 
-- values (6,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383259,16,'135MM BACK CUTTER RH ONLY')
-- values (7,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383260,7,'8.2MM DRILL')
-- values (8,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383261,8,'14.3MM DRILL/CHAMFER')
-- values (9,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383262,9,'15.5MM DRILL/CHAMFER')
-- values (10,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383263,4,'21MM DRILL/SPOTFACE')
-- values (11,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383264,5,'10MM END MILL')
-- values (12,103,60740,'Honda RDX CNC- 103',2960018,'51393TJB A040M1',61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',383265,2,'1.25\" HELICAL MILL')




/*
 * 
      "CNC": 103,
      "workcenter_Key": 60740,
      "workcenter_Code": "Honda RDX CNC- 103",        
      "Part_Key": 2960018,
      "Part_No": "51393TJB A040M1",
      "ProcessID": 61442, 
      "OriginalProcessID": 49396,
      "Customer": "SAT",
      "PartFamily": "51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET",
      "ToolTracker":

 */


383254,12,'86.125MM PRE FINISH BORE')
383255,1,'85.24MM ROUGH BORE')
383256,10,'86.925MM FINISH BORE')
383257,11,'ETCHER')
383258,13,'180MM BACK CUTTER RH PART ONLY')
383259,16,'135MM BACK CUTTER RH ONLY')
383260,7,'8.2MM DRILL')
383261,8,'14.3MM DRILL/CHAMFER')
383262,9,'15.5MM DRILL/CHAMFER')
383263,4,'21MM DRILL/SPOTFACE')
383264,5,'10MM END MILL')
383265,2,'1.25\" HELICAL MILL')




8.2MM DRILL

select * from ToolTracker

set @transDate = '2020-06-25 00:00:00';
call InsToolLife(103,12345, 100, @transDate); 
select * from ToolLife where cnc=103 order by CNC, desc
-- drop procedure InsKep13319
CREATE PROCEDURE InsKep13319
(
  	IN nodeId varchar(50),
  	IN name varchar(50),
  	IN plexus_Customer_No int(11),
	IN pcn varchar(50),
  	IN workcenter_Key int(11),
  	IN workcenter_Code varchar(50),
  	IN cnc varchar(6),
  	IN value int(11),
  	IN transDate datetime
)
BEGIN
   
INSERT INTO Kep13319 
(nodeId,name,plexus_Customer_No,pcn, workcenter_Key,workcenter_Code,cnc,value,transDate)
VALUES(nodeId,name,plexus_Customer_No,pcn, workcenter_Key,workcenter_Code,cnc,value,transDate);

-- Display the last inserted row.
select kep13319Key, workcenter_Key from Kep13319 k where Kep13319Key=(SELECT LAST_INSERT_ID());

END;

