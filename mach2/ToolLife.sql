-- drop table ToolLife
CREATE TABLE ToolLife (
	ToolLifeKey int(11) NOT NULL,  -- Don't auto generate key because it will be linked to ToolLifeHistory.
  	CNC int NOT NULL,  -- number on CNC
  	-- Plex 
  	Workcenter_Key int NOT NULL,  -- Plex
  	Workcenter_Code varchar(50) NOT NULL,  -- Plex
  	Part_Key int NOT NULL,  -- Plex
  	Part_No varchar (100) NOT NULL,
  	-- ToolList
  	ProcessID int NOT NULL,  -- primary key
  	OriginalProcessID int NOT NULL,  -- ToolBoss
  	Customer nvarchar(50) NOT NULL,  
  	PartFamily nvarchar(50) NOT NULL, 
  	OperationDescription nvarchar(50) NOT NULL,  -- Master  
  	ToolID int NOT NULL,  -- ToolList primary key
  	ToolNumber int NOT NULL,
  	OpDescription nvarchar(75) NOT NULL,  -- Tool
  	PRIMARY KEY (ToolLifeKey)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Tool life description';


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



CREATE TABLE ToolLifeHistory (
	ToolLifeHistoryKey int(11) NOT NULL AUTO_INCREMENT,
	ToolLifeKey int(11) NOT NULL,
  	Count int NOT NULL,
  	TransDate datetime NOT NULL,
  	PRIMARY KEY (ToolLifeHistoryKey)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='Tool life history';

insert into ToolLife (ToolLifeKey,CNC,Workcenter_Key,Workcenter_Code,Part_Key,Part_No,ProcessID,OriginalProcessID,Customer,PartFamily,OperationDescription,ToolID,ToolNumber,OpDescription)
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

8.2MM DRILL

select * from ToolLife

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

