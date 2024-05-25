# US_Household_Income_Project

This repository contains two MySQL scripts:

# Data Cleaning Script: 
This script focuses on cleaning and preparing the datasets US_Household_Income and US_Household_Statistics.

The script performs various cleaning tasks including:
Removing duplicate rows
Fixing inconsistencies in state names
Filling missing values
Standardizing data types
Identifying rows with null or zero values in specific columns
Additionally, it renames a column and counts the total number of rows after cleaning in both datasets.
This script is designed to improve data quality and consistency for further analysis.

# Data Exploration Script: 
This script explores the cleaned US_Household_Income dataset to uncover insights about income distribution across different states and cities.

It performs several analyses including:
Calculating total land and water area for each state
Combining income data with household statistics
Identifying states with the lowest and highest average income
Finding the type of household with the highest average income
Analyzing average income at the city level within each state
Focusing on Puerto Rico to explore income distribution within the territory
Script Functionality
Both scripts utilize various SQL functions and clauses like SELECT, COUNT, GROUP BY, HAVING, ROW_NUMBER, OVER, PARTITION BY, ORDER BY, DELETE, UPDATE, WHERE, and DISTINCT.

# Conclusion
These scripts demonstrate techniques for data cleaning, preparation, and exploration in MySQL. They showcase how to utilize SQL functionalities to gain valuable insights from datasets. You can adapt these techniques for your own data analysis tasks.
