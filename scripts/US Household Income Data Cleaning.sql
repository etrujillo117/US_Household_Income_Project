#US Household Income Data Cleaning

#Initial Data view
SELECT *
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`;

SELECT *
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics`;

#Rename the id column
#ALTER TABLE `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics` RENAME COLUMN `i?id` TO `id`;

#Check total count of rows
SELECT COUNT(id) as id_count
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`;
#32533

SELECT COUNT(id) as id_count
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics`;
#32526

#Check if multiple ids exist for US_Household_Income table
SELECT id, COUNT(id) as id_count
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
GROUP BY id
HAVING COUNT(id) > 1;

SELECT *
FROM(
  SELECT row_id,id,
  ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
  FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
  ) duplicates
  WHERE row_num >1
;

#DELETE Duplicate Rows
DELETE FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
WHERE row_id IN (
  SELECT row_id
  FROM(
    SELECT row_id,id,
    ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
    FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
    ) duplicates
  WHERE row_num >1
);

#Check if multiple ids exist for US_Household_Income_Statistics table
SELECT id, COUNT(id) as id_count
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics`
GROUP BY id
HAVING COUNT(id) > 1;

#Check and correct the State names
SELECT State_Name
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
GROUP BY State_Name
;

#Check and correct the State names
SELECT DISTINCT State_Name
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
ORDER BY State_Name ASC
;

#UPDATE incorrect or misspelled state names
UPDATE `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

#UPDATE incorrect or misspelled state names
UPDATE `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

#Check for rows with an empty value in the place column
SELECT *
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
WHERE Place is null
ORDER BY id ASC
;

# Only one Place is null, use the surrounding data values to determine what the correct Place value should be for specific row
SELECT State_Name, County, City, Place
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
WHERE County = 'Autauga County'
ORDER BY City DESC
;

#Using the above query, we determinded that the correct value is Autaugaville for the missing Place, update the table accordingly
UPDATE `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;

#Check for misspellings or errors in the Type Column
SELECT Type, COUNT(Type) AS type_count
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
GROUP BY Type
ORDER BY Type ASC
;

#Update the following type pairs to the first one entered: 
#(CDP, CPD)
UPDATE `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
SET Type = 'CDP'
WHERE Type = 'CPD'
;

#(Borough, Boroughs)
UPDATE `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

#(City, CITY)
UPDATE `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
SET Type = 'City'
WHERE Type = 'CITY'
;

#(Village, village)
UPDATE `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
SET Type = 'Village'
WHERE Type = 'village'
;

#Check for 0 or nulls in the ALand or AWater columns
SELECT ALand, AWater
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
WHERE (ALand = 0 OR ALand is null)
OR (AWater = 0 OR AWater is null);
