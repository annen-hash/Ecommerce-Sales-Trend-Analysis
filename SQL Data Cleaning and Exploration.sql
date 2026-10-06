/*
Data Cleaning and Exploration
Skills used: Joins, CTE's, Order By, Group By, Temp Tables, Windows Functions, Aggregate Functions, Creating Views
*/
----------------------------------------------------------------------------------------------------------------------- 

 
SELECT *
FROM ecommerce_sales
LIMIT 10;


-------------------------------------------------------------------------------------------------- 
/*Counts the number of rows and check if there are any missing value*/
------------------------------------------------------------------------------------------------- 


SELECT COUNT(*) AS total_records
FROM ecommerce_sales;

SELECT
    COUNT(*) AS total_rows,
    SUM(Order_ID IS NULL) AS missing_order_id,
    SUM(Customer_ID IS NULL) AS missing_customer_id,
    SUM(Date IS NULL) AS missing_date,
    SUM(Product_Category IS NULL) AS missing_category,
    SUM(Total_Amount IS NULL) AS missing_sales
FROM ecommerce_sales;

SELECT
    Order_ID,
    COUNT(*) AS occurrences
FROM ecommerce_sales
GROUP BY Order_ID
HAVING COUNT(*) > 1;


----------------------------------------------------------------------------------------------------------------------------------------
/*Checking how many days worth of data is being analyzed*/
----------------------------------------------------------------------------------------------------------------------------------------



SELECT
    MIN(Date) AS first_date,
    MAX(Date) AS last_date,
    COUNT(DISTINCT Date) AS number_of_days
FROM ecommerce_sales;

SELECT
    Date,
    SUM(Total_Amount) AS daily_sales,
    COUNT(DISTINCT Order_ID) AS number_of_orders,
    SUM(Quantity) AS units_sold
FROM ecommerce_sales
GROUP BY Date
ORDER BY Date;

---------------------------------------------------------------------------------------------------- 
 /*Creating a temp table*/
 
----------------------------------------------------------------------------------------------------- 
 
    
WITH monthly_sales AS (
    SELECT
        YEAR(Date) AS sales_year,
        MONTH(Date) AS sales_month,
        SUM(Total_Amount) AS total_sales
    FROM ecommerce_sales
    GROUP BY
        YEAR(Date),
        MONTH(Date)
)

SELECT
    sales_year,
    sales_month,
    total_sales,

    LAG(total_sales) OVER (
        ORDER BY sales_year, sales_month
    ) AS previous_month_sales

FROM monthly_sales
ORDER BY sales_year, sales_month;



WITH monthly_sales AS (
    SELECT
        YEAR(Date) AS sales_year,
        MONTH(Date) AS sales_month,
        SUM(Total_Amount) AS total_sales
    FROM ecommerce_sales
    GROUP BY
        YEAR(Date),
        MONTH(Date)
),

sales_with_previous AS (
    SELECT
        sales_year,
        sales_month,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY sales_year, sales_month
        ) AS previous_month_sales
    FROM monthly_sales
)

SELECT
    sales_year,
    sales_month,
    total_sales,
    previous_month_sales,

    total_sales - previous_month_sales AS sales_change,

    ROUND(
        (total_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0) * 100,
        2
    ) AS growth_percentage

FROM sales_with_previous
ORDER BY sales_year, sales_month;

SELECT
    Product_Category,
    SUM(Total_Amount) AS total_sales,
    SUM(Quantity) AS units_sold,
    COUNT(DISTINCT Order_ID) AS orders
FROM ecommerce_sales
GROUP BY Product_Category
ORDER BY total_sales DESC;

SELECT
    Is_Returning_Customer,
    COUNT(DISTINCT Customer_ID) AS customers,
    COUNT(DISTINCT Order_ID) AS orders,
    SUM(Total_Amount) AS total_sales,
    AVG(Total_Amount) AS average_order_value
FROM ecommerce_sales
GROUP BY Is_Returning_Customer;

SELECT
    DAYNAME(Date) AS day_of_week,
    SUM(Total_Amount) AS total_sales,
    COUNT(DISTINCT Order_ID) AS orders
FROM ecommerce_sales
GROUP BY DAYNAME(Date), DAYOFWEEK(Date)
ORDER BY DAYOFWEEK(Date);


------------------------------------------------------------------------------------------ 
/*Creating views for analysis*/
------------------------------------------------------------------------------------------ 



CREATE VIEW monthly_sales_analysis AS
SELECT
    YEAR(`Date`) AS sales_year,
    MONTH(`Date`) AS sales_month,
    SUM(Total_Amount) AS total_sales,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS units_sold,
    AVG(Total_Amount) AS average_order_value
FROM ecommerce_sales
GROUP BY
    YEAR(`Date`),
    MONTH(`Date`);
    
SELECT *
FROM monthly_sales_analysis;
    

CREATE VIEW vw_monthly_sales_growth AS
SELECT
    sales_year,
    sales_month,
    total_sales,

    LAG(total_sales) OVER (
        ORDER BY sales_year, sales_month
    ) AS previous_month_sales,

    total_sales -
    LAG(total_sales) OVER (
        ORDER BY sales_year, sales_month
    ) AS sales_change,

    ROUND(
        (
            total_sales -
            LAG(total_sales) OVER (
                ORDER BY sales_year, sales_month
            )
        )
        /
        NULLIF(
            LAG(total_sales) OVER (
                ORDER BY sales_year, sales_month
            ),
            0
        ) * 100,
        2
    ) AS growth_percentage

FROM monthly_sales_analysis;

SELECT *
FROM vw_monthly_sales_growth;


CREATE VIEW vw_customer_sales AS
SELECT
    Is_Returning_Customer,
    COUNT(DISTINCT Customer_ID) AS total_customers,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Total_Amount) AS total_sales,
    SUM(Quantity) AS units_sold,
    AVG(Total_Amount) AS average_order_value
FROM ecommerce_sales
GROUP BY Is_Returning_Customer;

SELECT *
FROM vw_customer_sales;


CREATE VIEW vw_daily_sales AS
SELECT
    Date,
    SUM(Total_Amount) AS total_sales,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS units_sold
FROM ecommerce_sales
GROUP BY Date;

SELECT *
FROM vw_daily_sales;


CREATE VIEW vw_weekday_sales AS
SELECT
    DAYOFWEEK(Date) AS day_number,
    DAYNAME(Date) AS day_of_week,
    SUM(Total_Amount) AS total_sales,
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS units_sold
FROM ecommerce_sales
GROUP BY
    DAYOFWEEK(Date),
    DAYNAME(Date);
    
SELECT *
FROM vw_weekday_sales
ORDER BY day_number;


CREATE VIEW vw_city_sales AS
SELECT
    City,
    SUM(Total_Amount) AS total_sales,
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Customer_ID) AS total_customers,
    SUM(Quantity) AS units_sold,
    AVG(Total_Amount) AS average_order_value
FROM ecommerce_sales
GROUP BY City;

SELECT *
FROM vw_city_sales;


CREATE VIEW vw_category_sales AS
SELECT
    Product_Category,
    SUM(Total_Amount) AS total_sales,
    SUM(Quantity) AS units_sold,
    COUNT(DISTINCT Order_ID) AS total_orders,
    AVG(Total_Amount) AS average_order_value
FROM ecommerce_sales
GROUP BY Product_Category;

SELECT *
FROM vw_category_sales;