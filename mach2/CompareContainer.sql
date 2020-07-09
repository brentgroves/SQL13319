-- DROP TABLE IF EXISTS CompareContainer
-- truncate CompareContainer
CREATE TABLE CompareContainer(
  CompareContainer_Key INT NOT NULL AUTO_INCREMENT, 
  TransDate datetime DEFAULT NULL,
  PCN varchar(50) NULL,
  Workcenter varchar(50) NULL,
  CNC varchar(25) NULL,
  Name varchar(50) NULL,
  Part_No varchar(50) NULL,
  Serial_No varchar(50) NULL,
  tst_Serial_No varchar(50) NULL,
  Quantity INT NULL,
  tst_Quantity INT NULL,
  Container_Status varchar(50),
  Status varchar(50),
  PRIMARY KEY (CompareContainer_Key)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
select * from SetupContainer sc 

set @transDate = '2020-07-09 09:45:00';
-- set @transDate = '2020-06-25 00:00:00';
-- delete from CompareContainer where CompareSetupContainer_Key = 3
-- call CompareContainer(@transDate); 
select * from CompareContainer 
--where transDate = @transDate;  
-- drop procedure CompareContainer
CREATE DEFINER=`brent`@`%` PROCEDURE `mach2`.`CompareContainer`(
    IN  p_TransDate VARCHAR(25)
)
BEGIN
	
/* set @p_TransDate = '2019-12-15 09:00'; */
drop temporary table if exists ProdServer;
create temporary table ProdServer engine=memory	
select 
TransDate,PCN,Workcenter,CNC,Name,Part_no,Serial_No,ProdServer,Quantity,Container_Status 
from SetupContainer 
where TransDate = p_TransDate and ProdServer = 1; 

drop temporary table if exists TestServer;
create temporary table TestServer engine=memory	
select 
TransDate tst_TransDate,PCN tst_PCN,Workcenter tst_Workcenter,CNC tst_CNC,Name tst_Name, Part_no tst_Part_No,Serial_No tst_Serial_No,ProdServer tst_ProdServer,Quantity tst_Quantity,Container_Status tst_Container_Status
from SetupContainer 
where TransDate = p_TransDate and ProdServer = 0; 

insert into CompareContainer ( TransDate,PCN,Workcenter,CNC,Name,Part_No,Serial_No,tst_Serial_No,Quantity,tst_Quantity,Container_Status,Status)
(
	select 
	TransDate,PCN, Workcenter,CNC,Name,Part_no,Serial_No,tst_Serial_No, Quantity,tst_Quantity, Container_Status,
	case 
	when Serial_No <> tst_Serial_No then 'Red'
	when ((Serial_No = tst_Serial_No) and (Quantity <> tst_Quantity)) then 'Yellow'
	when ((Serial_No = tst_Serial_No) and (Quantity = tst_Quantity)) then 'Green'
	when ((Serial_No = tst_Serial_No) and (Quantity is Null) and (tst_Quantity is Null)) then 'Green'
	end Status
	from ProdServer ps
	left outer join TestServer ts
	on ps.TransDate = ts.tst_TransDate
	and ps.PCN = ts.tst_PCN
	and ps.Workcenter = ts.tst_Workcenter
	and ps.Part_No = ts.tst_Part_No
	and ps.Container_Status= ts.tst_Container_Status
);
select 
TransDate,PCN,Workcenter,CNC,Name,Part_No,Serial_No,tst_Serial_No,Quantity,tst_Quantity,Container_Status,Status
from CompareContainer
where TransDate = p_TransDate
order by TransDate,Part_no,Serial_no,Container_Status;

END;