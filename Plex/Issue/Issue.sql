/*
 * Link this to the Plex Issue Tracking System.
 */
DROP TABLE Issue;

CREATE TABLE Issue (
	Issue_Key int NOT NULL AUTO_INCREMENT,
	Plexus_Customer_No int NOT NULL,
	Issue_Type_Key int NOT NULL,
	Workcenter_Key int NOT NULL,
	CNC_Key int NOT NULL,
	Pallet_No int NOT NULL,
	Part_Key int NOT NULL,
	Part_Operation_Key int NOT NULL,
	Assembly_Key int NOT NULL,
	Tool_Key int NOT NULL,
	Start_Time datetime NOT NULL,
	-- AMH Start_Time  -- When issue was detected at InsAssemblyMachiningHistory SPROC.
	Previous_Time datetime NULL,
	-- AMH Start_Time  
	Cycle_Time int NULL,
	Fastest_Cycle_Time int NULL,
	Current_Value int NULL,
	Previous_Value int NULL,
	Pallet_Looped_Out int NULL,
	-- WHICH PALLET IS LOOPED OUT
	Description varchar(500) NULL,
	PRIMARY KEY (Issue_Key)
)
SELECT
	*
FROM
	Issue;

DROP TABLE Issue_Type;

CREATE TABLE Issue_Type (
	Plexus_Customer_No int,
	Issue_Type_Key int NOT NULL,
	Severity_Key int NOT NULL,
	Issue_Type varchar(50) NOT NULL,
	PRIMARY KEY (Plexus_Customer_No, Issue_Type_Key) -- this must be unique
) TRUNCATE TABLE Issue_Type
INSERT INTO
	Issue_Type (
		Plexus_Customer_No,
		Issue_Type_Key,
		Severity_Key,
		Issue_Type
	)
VALUES
	-- Albion
	(300758, 1, 1, 'Counter Rolled Back'),
	(300758, 2, 1, 'Network Error'),
	(300758, 3, 1, 'Shift Tool Change Avoidance'),
	(300758, 4, 1, 'Pallet Looped Out'),
	-- Avilla
	(310507, 101, 1, 'Counter Rolled Back'),
	(310507, 102, 1, 'Network Error'),
	(310507, 103, 1, 'Shift Tool Change Avoidance'),
	(310507, 104, 1, 'Pallet Looped Out')
SELECT
	*
FROM
	Issue_Type;

CREATE TABLE Severity (
	Plexus_Customer_No int,
	Severity_Key int NOT NULL,
	Severity varchar(50) NOT NULL,
	PRIMARY KEY (Plexus_Customer_No, Severity_Key)
)
INSERT INTO
	Severity
VALUES
	-- Albion
	(300758, 1, 'low'),
	(300758, 2, 'medium'),
	(300758, 3, 'high'),
	-- Avilla
	(300758, 10, 'low'),
	(300758, 11, 'medium'),
	(300758, 13, 'high')
SELECT
	*
FROM
	Severity.