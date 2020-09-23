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
