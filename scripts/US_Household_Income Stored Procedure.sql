-- Automated Data Cleaning

SELECT *
FROM `analyst_builder`.`ushouseholdincome`;

-- 3. Create Stored Procedure
USE `analyst_builder`
DELIMITER $$
DROP PROCEDURE IF EXISTS Copy_and_Clean_Data;
CREATE PROCEDURE Copy_and_Clean_Data()
BEGIN

-- CREATE Table Copy
	CREATE TABLE IF NOT EXISTS `ushouseholdincome_cleaned` (
	  `row_id` int DEFAULT NULL,
	  `id` int DEFAULT NULL,
	  `State_Code` int DEFAULT NULL,
	  `State_Name` text,
	  `State_ab` text,
	  `County` text,
	  `City` text,
	  `Place` text,
	  `Type` text,
	  `Primary` text,
	  `Zip_Code` int DEFAULT NULL,
	  `Area_Code` int DEFAULT NULL,
	  `ALand` int DEFAULT NULL,
	  `AWater` int DEFAULT NULL,
	  `Lat` double DEFAULT NULL,
	  `Lon` double DEFAULT NULL,
	  `TimeStamp` TIMESTAMP DEFAULT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- COPY Data to Table
	INSERT INTO `ushouseholdincome_cleaned`
    SELECT *, CURRENT_TIMESTAMP
    FROM `ushouseholdincome`;
    
-- Data Cleraning Steps

-- 1. Remove Duplicates
	DELETE FROM `ushouseholdincome_cleaned`
	WHERE
		row_id IN (
		SELECT row_id
		FROM (
			SELECT row_id, id,
			ROW_NUMBER() OVER (
				PARTITION BY id, `TIMESTAMP` ORDER BY id, `TIMESTAMP`) as row_num
			FROM `ushouseholdincome_cleaned`
			) duplicates
		WHERE
			row_num > 1
	);

-- 2. Standarization
	UPDATE `ushouseholdincome_cleaned`
	SET State_Name = 'Georgia'
	WHERE State_Name = 'georia';

	UPDATE `ushouseholdincome_cleaned`
	SET County = UPPER(County);

	UPDATE `ushouseholdincome_cleaned`
	SET City = UPPER(City);

	UPDATE `ushouseholdincome_cleaned`
	SET Place = UPPER(Place);

	UPDATE `ushouseholdincome_cleaned`
	SET State_Name = UPPER(State_Name);

	UPDATE `ushouseholdincome_cleaned`
	SET `Type` = 'CDP'
	WHERE `Type` = 'CPD';

	UPDATE `ushouseholdincome_cleaned`
	SET `Type` = 'Borough'
	WHERE `Type` = 'Boroughs';
    
END $$
DELIMITER ;


CALL Copy_and_Clean_Data();


-- Create the Event that Calls the Stored Procedure
CREATE EVENT run_data_cleaning
	ON SCHEDULE EVERY 30 DAY
    DO CALL opy_and_Clean_Data();
    
-- DROP EVENT
DROP EVENT run_data_cleaning;
    
    


