set @startDate ='2020-02-15 00:00:00';
set @endDate ='2020-02-09 23:59:59';	
-- benchmark(1000000, FIRST_DAY_OF_WEEK(@startDate)); 
select FIRST_DAY_OF_WEEK(@startDate)
drop function FIRST_DAY_OF_WEEK;
CREATE FUNCTION FIRST_DAY_OF_WEEK(pDay DATETIME)
RETURNS DATETIME DETERMINISTIC
BEGIN
	DECLARE day,firstDay,floorDate DATETIME;
	DECLARE week,year int;
	DECLARE dayOne char(20);
	set day = pDay;
	set week = week(day);
	if week = 0 then
	 	set year = year(day);
		set dayOne = concat('01/01/',year,' 00:00:00');
		set firstDay = STR_TO_DATE(dayOne,'%m/%d/%Y %H:%i:%s');
	else
		set floorDate = ADDDATE(DATE(day),INTERVAL 0 second);
		set firstDay = subdate(floorDate, INTERVAL DAYOFWEEK(floorDate)-1 DAY);
	end if;
	-- IF @DEBUG then
	--   INSERT INTO debugger VALUES (CONCAT('[FIRST_DAY_OF_WEEK: day=',day,',week=',week,',firstDay=',firstDay,']'));
	-- End If;
	
	return firstDay;
END;	
