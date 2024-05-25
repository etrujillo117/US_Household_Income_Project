#US Household Income EDA

#Initial Table views
SELECT * FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
;

SELECT * FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics`
;

# Explore the Area of Land and Water date by State
#Top 15 states by area of land
SELECT State_Name, SUM(ALand) AS State_ALand, SUM(AWater) AS State_AWater
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 15
;

#Top 15 states by area of water
SELECT State_Name, SUM(ALand) AS State_ALand, SUM(AWater) AS State_AWater
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income`
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 15
;

#Combine the data from both tables to see what other interesting findings we may have
SELECT *
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income` as u
INNER JOIN `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics` as us
  ON u.id = us.id
WHERE Mean <> 0
;

#What are the 5 Lowest Average Income States according to the data set?
SELECT u.State_Name, ROUND(AVG(Mean),1) as AVG_Mean, ROUND(AVG(Median),1) as AVG_Median
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income` as u
INNER JOIN `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics` as us
  ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER By 2  #Switch to Order by 3 for Average Median
LIMIT 5
;

#What are the 5 Highest Average Income States according to the data set?
SELECT u.State_Name, ROUND(AVG(Mean),1) as AVG_Mean, ROUND(AVG(Median),1) as AVG_Median
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income` as u
INNER JOIN `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics` as us
  ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER By 2 DESC #Switch to Order by 3 for Average Median
LIMIT 5
;

# What Type has the Highest Average income?
SELECT Type, COUNT(Type) as type_entries, ROUND(AVG(Mean),1) as AVG_Mean, ROUND(AVG(Median),1) as AVG_Median
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income` as u
INNER JOIN `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics` as us
  ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 3 DESC
Limit 1
;

# City level Average Income
SELECT u.State_Name, City, ROUND(AVG(Mean),1) as AVG_Mean
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income` as u
INNER JOIN `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics` as us
  ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name, City
ORDER By 3 DESC
;

# Puerto Rico Average Income by City
SELECT u.State_Name, City, ROUND(AVG(Mean),1) as AVG_Mean
FROM `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Income` as u
INNER JOIN `bigquery-public-data-313800.AnalystBuilderMySQLCourse.US_Household_Statistics` as us
  ON u.id = us.id
WHERE Mean <> 0
AND u.State_Name = 'Puerto Rico'
GROUP BY u.State_Name, City
ORDER By 3 DESC
;
