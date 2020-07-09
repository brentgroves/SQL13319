DROP TABLE IF EXISTS SetupContainer
CREATE TABLE SetupContainer(
  SetupContainer_Key INT NOT NULL AUTO_INCREMENT, 
  TransDate datetime DEFAULT NULL,
  PCN varchar(50) NULL,
  ProdServer bit NULL,
  Workcenter varchar(50) NULL,
  CNC varchar(25) NULL,
  Part_No varchar(50) NULL,
  Name varchar(50) NULL,
  Multiple int NULL,
  Container_Note varchar(50) NULL,
  Cavity_Status_Key INT NULL,
  Container_Status varchar(50) NULL,
  Defect_Type varchar(50) NULL,
  Serial_No varchar(50) NULL,
  Setup_Container_Key INT NULL,
  Count int NULL,
  Part_Count int NULL,
  Part_Key INT NULL,
  Part_Operation_Key INT NULL,
  Standard_Container_Type varchar(50) NULL,
  Container_Type_Key INT NULL,
  Parent_Part varchar(50) NULL,
  Parent varchar(50) NULL,
  Cavity_No varchar(50) NULL,
  Master_Unit_Key INT NULL DEFAULT 0,
  Workcenter_Printer_Key INT NULL,
  Master_Unit_No varchar(50) NULL,
  Physical_Printer_Name varchar(50) NULL,
  Container_Count int NULL,
  Container_Quantity int NULL,
  Default_Printer varchar(50) NULL,
  Default_Printer_Key INT NULL,
  Class_Key INT NULL,
  Quantity INT NULL,
  Companion bit NULL,
  Container_Type varchar(50) NULL,
  Container_Type_Description varchar(100) NULL,
  Sort_Order int NULL,
  PRIMARY KEY (SetupContainer_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

set @transDate = '2020-06-25 00:00:00';
call InsertSetupContainer(@transDate,'PCN',false,'Workcenter','CNC','Part_No','Name',1,
 'Container_Note',1234,'Container_Status','Defect_Type',
 'Serial_No',12,13,14,15,16,
 'Standard_Container_Type',17,'Parent_Part','Parent','Cavity_No',18,
 19,'Master_Unit_No','Physical_Printer_Name',20,21,
 'Default_Printer',22,23,24,false,'Container_Type','Container_Type_Description',0); 
select * from SetupContainer sc 
-- delete from SetupContainer sc2 where SetupContainer_Key <= 4
-- drop procedure InsertSetupContainer
CREATE PROCEDURE InsertSetupContainer
(
  IN TransDate datetime,
  IN PCN varchar(50),
  IN ProdServer bit,
  IN Workcenter varchar(50),
  IN CNC varchar(25),
  IN Part_No varchar(50),
  IN Name varchar(50),
  IN Multiple int,
  IN Container_Note varchar(50),
  IN Cavity_Status_Key INT,
  IN Container_Status varchar(50),
  IN Defect_Type varchar(50),
  IN Serial_No varchar(50),
  IN Setup_Container_Key INT,
  IN Count int,
  IN Part_Count int,
  IN Part_Key INT,
  IN Part_Operation_Key INT,
  IN Standard_Container_Type varchar(50),
  IN Container_Type_Key INT,
  IN Parent_Part varchar(50),
  IN Parent varchar(50),
  IN Cavity_No varchar(50),
  IN Master_Unit_Key INT,
  IN Workcenter_Printer_Key INT,
  IN Master_Unit_No varchar(50),
  IN Physical_Printer_Name varchar(50),
  IN Container_Count int,
  IN Container_Quantity int,
  IN Default_Printer varchar(50),
  IN Default_Printer_Key INT,
  IN Class_Key INT,
  IN Quantity INT,
  IN Companion bit,
  IN Container_Type varchar(50),
  IN Container_Type_Description varchar(100),
  IN Sort_Order int
)
BEGIN
   
INSERT INTO SetupContainer 
(TransDate,PCN,ProdServer,Workcenter,CNC,Part_No,Name,Multiple,
 Container_Note,Cavity_Status_Key,Container_Status,Defect_Type,
 Serial_No,Setup_Container_Key,Count,Part_Count,Part_Key,Part_Operation_Key,
 Standard_Container_Type,Container_Type_Key,Parent_Part,Parent,Cavity_No,Master_Unit_Key,
 Workcenter_Printer_Key,Master_Unit_No,Physical_Printer_Name,Container_Count,Container_Quantity,
 Default_Printer,Default_Printer_Key,Class_Key,Quantity,Companion,Container_Type,Container_Type_Description,Sort_Order)
VALUES(TransDate,PCN,ProdServer,Workcenter,CNC,Part_No,Name,Multiple,
 Container_Note,Cavity_Status_Key,Container_Status,Defect_Type,
 Serial_No,Setup_Container_Key,Count,Part_Count,Part_Key,Part_Operation_Key,
 Standard_Container_Type,Container_Type_Key,Parent_Part,Parent,Cavity_No,Master_Unit_Key,
 Workcenter_Printer_Key,Master_Unit_No,Physical_Printer_Name,Container_Count,Container_Quantity,
 Default_Printer,Default_Printer_Key,Class_Key,Quantity,Companion,Container_Type,Container_Type_Description,Sort_Order);

-- Display the last inserted row.
select SetupContainer_Key, Workcenter from SetupContainer sc where SetupContainer_Key =(SELECT LAST_INSERT_ID());

END;


