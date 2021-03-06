CREATE DEFINER=`brent`@`%` PROCEDURE `mach2`.`CompareSetupContainer`(
    IN  p_TransDate VARCHAR(25)
)
BEGIN
	
/* set @p_TransDate = '2019-12-15 09:00'; */
drop temporary table if exists ProdServer;
create temporary table ProdServer engine=memory	
select 
TransDate,Workcenter,CNC,Name,Part_no,Serial_No,ProdServer,Quantity,Container_Status 
from SetupContainer 
where TransDate = p_TransDate and ProdServer = 1; 

drop temporary table if exists TestServer;
create temporary table TestServer engine=memory	
select 
TransDate tst_TransDate,Workcenter tst_Workcenter,CNC tst_CNC,Name tst_Name, Part_no tst_Part_No,Serial_No tst_Serial_No,ProdServer tst_ProdServer,Quantity tst_Quantity,Container_Status tst_Container_Status
from SetupContainer 
where TransDate = p_TransDate and ProdServer = 0; 

select 
TransDate,Workcenter,CNC,Name,Part_no,Serial_No,tst_Serial_No, Quantity,tst_Quantity, Container_Status,
case 
when Serial_No <> tst_Serial_No then 'Red'
when ((Serial_No = tst_Serial_No) and (Quantity <> tst_Quantity)) then 'Yellow'
when ((Serial_No = tst_Serial_No) and (Quantity = tst_Quantity)) then 'Green'
when ((Serial_No = tst_Serial_No) and (Quantity is Null) and (tst_Quantity is Null)) then 'Green'
end Status
from ProdServer ps
left outer join TestServer ts
on ps.TransDate = ts.tst_TransDate
and ps.Workcenter = ts.tst_Workcenter
and ps.Part_No = ts.tst_Part_No
and ps.Container_Status = ts.tst_Container_Status
order by ps.TransDate,ps.Part_no,ps.Serial_no,ps.Container_Status;

END;