# Ecommerce Analysis: Sales Trend and Future Prediction
## **Table of Contents** <br>
- [Project Overview](#project-overview) <br>
- [Technology and Skills](#technology--skills)
- [Project Objectives](#project-objetives)
- [Key Insights](#key-insights)
- [Reommendations](#recommendations)
- [Limitations](#limitations)

## Project Overview

This document provides an analysis of key performance data for a prominent Turkey based online retail platform with locations spanning 10 states. Metrics reviewed include sales across multiple locations, product category, customer segment and time unit. This dataset, sourced from Kaggle, a widely recognized platform offering copyright-free datasets, contains a single sheet with 18 columns and 17049 rows, covering orders from January, 2023 to March, 2024. The data set includes 8 product lines Books, Home & Garden, Sports, Food, Beauty, Toys, Fashion, and Electronics. The analysis was conducted using SQL and Microsoft Excel for data visualization.


## Technologies & Skills
- **Technologies**: SQL (MySQL), MySQL Workbench, Power BI, DAX
- **Skills**: Data modeling, database development, data wrangling, data cleaning, data analysis, data visualization/dashboarding

## Project Objectives
The analysis addresses the following objectives:
+ Calculating and analyzing sales by market size and city
+ Calculating customer retention
+ Identifying trends, consumer preferences, and changes over time
+ Predicting sales to occur in the next six months
+ Delivering actionable recommendations to the company stakeholders

## Analysis
I began by importing the csv file into MySQL workbench creating a database. I used Joins, CTE's, Order By, Group By, Temp Tables, Windows Functions, Aggregate Functions  and created 7 Views for my analysis. In order to create a visual representation of my findings, I imported the table into Power BI.

I created 4 new tables using DAX Query tables: Calendar, Categories, Cities, and Customers in order to create relationships between them and ecommerce sales table

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

I created the 4 key DAX measures: Total Sales, Total Orders, Units Sold, and Average Order Value
Total Sales =
SUM(ecommerce_sales[Total_Amount])

Total Orders =
DISTINCTCOUNT(ecommerce_sales[Order_ID])

Units Sold =
SUM(ecommerce_sales[Quantity])

Average Order Value =
DIVIDE(
    [Total Sales],
    [Total Orders]
)

A relationship diagram between tables can be seen in the picture below
<img width="539" height="445" alt="Ecommerce Dashboard Model" src="https://github.com/user-attachments/assets/3dfe0bc7-ab2c-4f20-bb0c-20e29d302629" />

Four Slicers were added to the dashboard in order to filer the charts and KPI cards, by date, product, category, city and returning customers or new customers.

## Key Insights
+ For the period of January 2023 to March 2024, a total of  TL21.78M sales was achieved with 51.34K units sold.
  
+ The top three product categories with the highest sales are Electronics, Home & Garden, and Sports, respectively. Electronics is the product with the highest sales during this period with a total sale of TL10,481,897.65. This is a huge difference compared with the Books, the product category with lowest sales amount TL360,399.11. Although Electronics is relatively larger than Books in sales amount. I found that Books had a higher number of units sold than Electronics. Books had 6,727 units sold and Electronics had 6,277 units sold. The difference in sales amount is due to difference in price levels.

+ There 8 product categories were almost equally popular in terms of number of units sold.
  
+ The top three cities with the highest population are Istanbul, Ankara, and Izmir respectively. The vast difference between Istanbul and Eskisehir in sales size can be explained through population size. Istanbul is the city with the highest population in Turkey inhabiting nearly 20% of Turkey's total population.

+ It was seen that the sales from returning customers was significantly higher than that of new customers. Returning customers had 45,253 units sold and TL19,190,720.46 sales amount and New customers had 6088 units sold and TL2,588,332.13 sales. 

+ There was no seasonal trend affecting sales. Monthly sales were generally around 1.3M–1.6M. Revenue increased from January through April, dipped in June, and recovered in July with an increase of 12.97% and dipped again and increased slightly in December. Then in early 2024, January to March, there was a decrease in sales. Revenue and sales growth was inconsistent rather than following a steady trend.
<img width="659" height="488" alt="Screenshot (8)" src="https://github.com/user-attachments/assets/28a3826a-49c6-4b39-9d10-ba6a25c97557" />


## Recommendations
+ Marketing strategies to attract new customers. It is seen that majority of sales stems from existing customers. Focusing on marketing strategies like advertisement can help attract new customers which would increase sales.
+ Discount. Discounts can be given during holiday seasons like Republic Day ( October 29), Yew year's eve and  Christmas in order to boost sales during holidays.

## Limitations
+ The short historical period restricts seasonal analysis. The causes of sales fluctuations over the months would have been more clearer if data for several years was available The sales increase and decreases could have been analyzed better to identify the causes if the data for several years was available.
+ The forecast accuracy of the trend chart has not been established. If newer data had been available a comparison between predicted level of sales and results would have been possible.
