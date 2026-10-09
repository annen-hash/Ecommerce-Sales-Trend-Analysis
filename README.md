# Ecommerce Analysis: Sales Trend and Future Prediction
## Project Overview

This document provides an analysis of key performance data for a prominent Turkey based online retail platform with locations spanning 10 states. Metrics reviewed include sales across multiple locations, product category, customer segment and time unit.

## Technologies and Skills
- **Technologies**: SQL (MySQL), MySQL Workbench, Power BI, DAX
- **Skills**: Data modeling, database development, data wrangling, data cleaning, data analysis, data visualization/dashboarding

## Project Objectives
The analysis addresses the following objectives:
+ Evaluating the database structure
+ Calculating and analyzing sales by market size and city
+ Calculating customer retention
+ Identifying trends, consumer preferences, and changes over time
+ Predicting sales to occur in the next six months
+ Delivering actionable recommendations to the company stakeholders

The analysis was conducted using SQL and Microsoft Excel for data visualization.

## Dataset
This dataset, sourced from Kaggle, a widely recognized platform offering copyright-free datasets, contains a single sheet with 18 columns and 17049 rows, covering orders from January, 2023 to March, 2024.

The data set includes 8 product lines Books, Home & Garden, Sports, Food, Beauty, Toys, Fashion, and Electronics. 

## Analysis
I began by importing the csv file into MySQL workbench creating a database. I used Joins, CTE's, Order By, Group By, Temp Tables, Windows Functions, Aggregate Functions  and created 7 Views for my analysis. In order to create a visual representation of my findings, I imported the table into Power BI.

I create 4 new tables Calendar, Categories, Cities, and Customers in order to create relationships between them and ecommerce sales table

Calendar =
CALENDAR(
    MIN(ecommerce_sales[Date]),
    MAX(ecommerce_sales[Date]))

Categories =
DISTINCT(ecommerce_sales[Product_Category])

Cities =
DISTINCT(ecommerce_sales[City])

Customers =
DISTINCT(ecommerce_sales[Customer_ID])

I created a new column Customer_Type in the Ecommerce sales table in order to determine the rate of new customers vs returning customers
Customer_Type =
IF(ecommerce_sales[Is_Returning_Customer] = TRUE(),
    "Returning Customer",
    "New Customer")

I created the 4 key measures: Total Sales, Total Orders, Units Sold, and Average Order Value

