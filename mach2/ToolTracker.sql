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
	Tool_Life int NOT NULL,  -- Can be different for every CNC
  	Current_Value int NOT NULL,
  	Fastest_Cycle_Time int NOT NULL, -- In seconds
  	Last_Update datetime NOT NULL,
  	PRIMARY KEY (CNC_Part_Operation_Assembly_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='CNC Part operation assembly info';

-- 5 * 60 = 300


set @Last_Update = '2020-08-15 00:00:00';
insert into CNC_Part_Operation_Assembly (CNC_Part_Operation_Assembly_Key,CNC_Key,Part_Key,Operation_Key,Assembly_Key,Increment_By,Tool_Life,Current_Value,Fastest_Cycle_Time,Last_Update)
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


set @Trans_Date = '2020-09-07 09:50:00';
call GenerateToolAssemblyChangeHistory(@Trans_Date);

-- truncate table Tool_Assembly_Change_History;
select count(*) from Tool_Assembly_Change_History
-- drop procedure GenerateToolAssemblyChangeHistory
CREATE PROCEDURE GenerateToolAssemblyChangeHistory
(
	IN pTrans_Date datetime
)
BEGIN
	DECLARE x  INT;
	DECLARE rnd INT;
	DECLARE CNC_Part_Operation_Key int;
	DECLARE Set_No int;
	DECLARE Block_No int;
	DECLARE Actual_Tool_Assembly_Life int;
	DECLARE Trans_Date datetime;
	DECLARE Return_Value int;
	DECLARE Tool_Assembly_Change_History_Key int;

	set Trans_Date = pTrans_Date;

	SET x = 1;
	set CNC_Part_Operation_Key = 1;
	set Set_No = 1;
	set Block_No = 1;
	set rnd = RAND() * (80500*.1);
	set Actual_Tool_Assembly_Life = 80500 - (80500 * .05) + rnd;  -- equals tool life - 5%
	loop_label:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

	SET x = 1;
	set Block_No = 2;
	set rnd = RAND() * (132000*.1);
	set Actual_Tool_Assembly_Life = 132000 - (132000 * .05) + rnd;  -- +/- 5%
	loop_label2:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label2;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

	SET x = 1;
	set Block_No = 3;
	set rnd = RAND() * (52600*.1);
	set Actual_Tool_Assembly_Life = 52600 - (52600 * .05) + rnd;  -- +/- 5%
	
	loop_label3:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label3;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

	SET x = 1;
	set Block_No = 4;
	set rnd = RAND() * (78000*.1);
	set Actual_Tool_Assembly_Life = 78000 - (78000 * .05) + rnd;  -- +/- 5%
	loop_label4:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label4;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

	SET x = 1;
	set Block_No = 5;
	set rnd = RAND() * (40000*.1);
	set Actual_Tool_Assembly_Life = 40000 - (40000 * .05) + rnd;  -- +/- 5%
	loop_label5:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label5;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

	SET x = 1;
	set Block_No = 6;
	set rnd = RAND() * (10000*.1);
	set Actual_Tool_Assembly_Life = 10000 - (10000 * .05) + rnd;  -- +/- 5%
	loop_label6:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label6;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

	SET x = 1;
	set Block_No = 7;
	set rnd = RAND() * (72000*.1);
	set Actual_Tool_Assembly_Life = 72000 - (72000 * .05) + rnd;  -- +/- 5%
	loop_label7:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label7;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

	SET x = 1;
	set Block_No = 8;
	set rnd = RAND() * (50000*.1);
	set Actual_Tool_Assembly_Life = 50000 - (50000 * .05) + rnd;  -- +/- 5%
	loop_label8:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label8;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

	SET x = 1;
	set Block_No = 9;
	set rnd = RAND() * (20000*.1);
	set Actual_Tool_Assembly_Life = 20000 - (20000 * .05) + rnd;  -- +/- 5%
	loop_label9:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label9;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;


	SET x = 1;
	set Set_No = 2;
	set Block_No = 1;
	set rnd = RAND() * (110000*.1);
	set Actual_Tool_Assembly_Life = 110000 - (110000 * .05) + rnd;  -- +/- 5%
	loop_label10:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label10;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

	SET x = 1;
	set Block_No = 2;
	set rnd = RAND() * (100000*.1);
	set Actual_Tool_Assembly_Life = 100000 - (100000 * .05) + rnd;  -- +/- 5%
	loop_label11:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label11;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

	SET x = 1;
	set Block_No = 3;
	set rnd = RAND() * (110000*.1);
	set Actual_Tool_Assembly_Life = 110000 - (110000 * .05) + rnd;  -- +/- 5%
	loop_label12:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label12;
		END  IF;
		            
		SET  x = x + 1;
		CALL InsToolAssemblyChangeHistory(CNC_Part_Operation_Key,Set_No,Block_No,Actual_Tool_Assembly_Life,Trans_Date,Tool_Assembly_Change_History_Key,Return_Value);
	END LOOP;

END
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

select * from Tool_Assembly_Change_History tc 
where CNC_Key = 1 and Part_Key = 2809196 and assembly_key = 1
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
set @endDate = '2020-09-07 23:59:59';
set @tableName = 'test0901b';

--   CreateToolChangeSummary(?,?,?,@recordCount,@returnValue)
call CreateToolChangeSummary(@startDate,@endDate,@tableName,@recordCount,@returnValue);
select @recordCount,@returnValue;
select * from test0902 t2; 
select * from rpt09083

DROP PROCEDURE CreateToolChangeSummary;

/*
 * Tool assembly change summary report 
 */
CREATE PROCEDURE CreateToolChangeSummary
(
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
end
/*
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
CREATE PROCEDURE CreateUpcomingToolChanges(
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
	b.Building_No, 
	c.CNC, 
	p.Part_No,
	-- p.Part_No,p.Revision,o.Operation_Code,
	Format(a.Tool_Life,0) Tool_Life,
	Format(a.Current_Value,0) Current_Value,
	-- (a.Tool_Life - a.Current_Value) Diff,
	-- ((a.Tool_Life - a.Current_Value) / a.Increment_By) Cycles_Remaining,
	-- (((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time) Seconds_Remaining,
	-- ((((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time) / 60) Minutes_Remaining,
	Format(Floor(((((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time) / 60)),0) iMinutes_Remaining,
	-- Floor(((((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time) % 60)) Seconds,
	DATE_FORMAT(a.Last_Update,"%m/%d/%Y %h:%i") Last_Update 
	-- select DATEselect DATE_FORMAT(NOW(),"%m/%d/%Y %h:%i") Last_Update _FORMAT(NOW(),"%m/%d/%Y %h:%i") Last_Update 
	from CNC_Part_Operation_Assembly a
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
	set @results = CONCAT(@results,' order by (((a.Tool_Life - a.Current_Value) / a.Increment_By) * a.Fastest_Cycle_Time)');
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

set @Building_Key = 5680;
set @tableName = 'test0901a';

call CreateUpcomingToolChanges(@Building_Key,@tableName,@recordCount,@returnValue);
select @recordCount,@returnValue;
select @returnValue;
select * from test0901
-- drop table test0901
select * from rpt09020
CREATE PROCEDURE FetchUpcomingToolChanges(
	IN pBuilding_Key INT,
	OUT pReturnValue INT 
)
