/*
 * Tool List master table 
 */

-- drop table ToolList
-- truncate table ToolList
CREATE TABLE ToolList (
	ToolListKey int NOT NULL, -- AUTO_INCREMENT, I have the keys already in a json file
  	-- Busche ToolList database foriegn keys and needed fields for UI
  	ProcessID int NOT NULL,  -- primary key
  	OriginalProcessID int NOT NULL,  -- ToolBoss
  	Customer nvarchar(50) NOT NULL,  
  	PartFamily nvarchar(50) NOT NULL, 
  	OperationDescription nvarchar(50) NOT NULL,  -- Master  
  	Part_Key int NOT NULL,  -- Plex
  	Part_No varchar (100) NOT NULL,
  	PRIMARY KEY (ToolListKey)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Tool list master table';

insert into ToolList (ToolListKey,ProcessID,OriginalProcessID,Customer,PartFamily,OperationDescription,Part_Key,Part_No)
values (1,61442,49396,'SAT','51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET','MILL COMPLETE',2960018,'51393TJB A040M1') 

select * from ToolList


-- drop table ToolListItem
CREATE TABLE ToolListItem (
	ToolListItemKey int NOT NULL,  -- AUTO_INCREMENT, I have the keys already in a json file
	ToolListKey int NOT NULL, -- foreign key. 1 to many
  	-- Busche ToolList foriegn keys and needed fields for UI
  	ToolID int NOT NULL,  -- [ToolList Tool] primary key
  	ToolNumber int NOT NULL,
  	OpDescription nvarchar(75) NOT NULL,  
  	PRIMARY KEY (ToolListItemKey)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Tool list item descriptions';
select * from ToolListItem
insert into ToolListItem (ToolListItemKey,ToolListKey,ToolID,ToolNumber,OpDescription)
-- values (1,1,383254,12,'86.125MM PRE FINISH BORE') 
-- values (2,1,383255,1,'85.24MM ROUGH BORE') 
-- values (3,1,383256,10,'86.925MM FINISH BORE') 
-- values (4,1,383257,11,'ETCHER')
-- values (5,1,383258,13,'180MM BACK CUTTER RH PART ONLY') 
-- values (6,1,383259,16,'135MM BACK CUTTER RH ONLY')
-- values (7,1,383260,7,'8.2MM DRILL')
-- values (8,1,383261,8,'14.3MM DRILL/CHAMFER')
-- values (9,1,383262,9,'15.5MM DRILL/CHAMFER')
-- values (10,1,383263,4,'21MM DRILL/SPOTFACE')
-- values (11,1,383264,5,'10MM END MILL')
 values (12,1,383265,2,'1.25\" HELICAL MILL')
/*
 * Tool List to CNC mapping table. 1 to many
 */
-- drop table ToolTracker
CREATE TABLE ToolTracker (
	ToolTrackerKey int NOT NULL, -- AUTO_INCREMENT, I have the keys already in a json file
	ToolListItemKey int, -- foreign key
  	CNC int NOT NULL,  -- number on CNC
  	-- Plex foriegn keys and needed fields for UI
  	Workcenter_Key int NOT NULL,  -- Plex
  	Workcenter_Code varchar(50) NOT NULL,  -- Plex
  	PRIMARY KEY (ToolTrackerKey)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Tool List to CNC mapping table.';

select * from ToolTracker tt 
insert into ToolTracker (ToolTrackerKey,ToolListItemKey,CNC,Workcenter_Key,Workcenter_Code)
-- values (1,1,103,60740,'Honda RDX CNC- 103') 
-- values (2,2,103,60740,'Honda RDX CNC- 103') 
-- values (3,3,103,60740,'Honda RDX CNC- 103') 
-- values (4,4,103,60740,'Honda RDX CNC- 103')
-- values (5,5,103,60740,'Honda RDX CNC- 103') 
-- values (6,6,103,60740,'Honda RDX CNC- 103')
-- values (7,7,103,60740,'Honda RDX CNC- 103')
-- values (8,8,103,60740,'Honda RDX CNC- 103')
-- values (9,9,103,60740,'Honda RDX CNC- 103')
-- values (10,10,103,60740,'Honda RDX CNC- 103')
-- values (11,11,103,60740,'Honda RDX CNC- 103')
-- values (12,12,103,60740,'Honda RDX CNC- 103')

insert into ToolTracker (ToolTrackerKey,CNC,Workcenter_Key,Workcenter_Code,Part_Key,Part_No,ProcessID,OriginalProcessID,Customer,PartFamily,OperationDescription,ToolID,ToolNumber,OpDescription)
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


CREATE TABLE ToolChange (
	ToolChangeKey int(11) NOT NULL AUTO_INCREMENT,
	ToolTrackerKey int(11) NOT NULL,
  	ToolLife int NOT NULL,
  	TransDate datetime NOT NULL,
  	PRIMARY KEY (ToolChangeKey)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Tool change history';


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

