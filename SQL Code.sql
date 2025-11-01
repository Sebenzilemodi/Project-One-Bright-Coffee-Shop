SELECT*
FROM CASESTUDY.BRIGHT.COFFEE_SHOP
--------------------------------------------------------------------------------------
--Categorical columns
SELECT DISTINCT STORE_LOCATION
FROM CASESTUDY.BRIGHT.COFFEE_SHOP

SELECT DISTINCT PRODUCT_CATEGORY
FROM CASESTUDY.BRIGHT.COFFEE_SHOP

SELECT DISTINCT PRODUCT_TYPE
FROM CASESTUDY.BRIGHT.COFFEE_SHOP
--------------------------------------------------------------------------------------
---Date Functions
---Transaction date
---Checkinng earliest operating hour

SELECT MIN(TRANSACTION_TIME) AS Shop_Opening_Time
FROM CASESTUDY.BRIGHT.COFFEE_SHOP

SELECT MAX(TRANSACTION_TIME) AS Shop_Closing_Time
FROM CASESTUDY.BRIGHT.COFFEE_SHOP
---------------------------------------------------------------------------------------
---Checking the shop opening date

SELECT MIN(TRANSACTION_DATE) AS Shop_Opening_Date
FROM CASESTUDY.BRIGHT.COFFEE_SHOP

---Checking the shop closing date
SELECT MAX(TRANSACTION_DATE) AS Shop_Closing_Date
FROM CASESTUDY.BRIGHT.COFFEE_SHOP
--------------------------------------------------------------------------------------
---checking Revenue  the latest transaction date

SELECT MAX(TRANSACTION_DATE) AS Last_Operating_Date
FROM CASESTUDY.BRIGHT.COFFEE_SHOP
--- DAY_NAME
SELECT Transaction_Date,
       DAYNAME (TRANSACTION_DATE) AS Day_Name
FROM CASESTUDY.BRIGHT.COFFEE_SHOP
---MONTH_NAME
SELECT Transaction_Date,
       MONTHNAME (TRANSACTION_DATE) AS Month_Nmae
FROM CASESTUDY.BRIGHT.COFFEE_SHOP

------------------------------------------------------------------------------------------
--Revenue Comparison 
SELECT Transaction_Date,
       DAYNAME (TRANSACTION_DATE) AS Day_Name,
       CASE
            WHEN DAYNAME(Transaction_Date) IN ('Sat','Sun') THEN 'Weekend'
            ELSE 'Weekday'
END AS DAY_CLASSIFICATION,
COUNT(DISTINCT transaction_id) AS Numeber_of_Sales,
MONTHNAME (TRANSACTION_DATE) AS Month_Name,
CASE
WHEN Transaction_time BETWEEN '06:00:00'AND'11:59:59'THEN 'Morning'
WHEN Transaction_time BETWEEN '12:00:00'AND'16:59:59'THEN 'Afternoon'
WHEN Transaction_time >= '17:00:00'THEN 'Evening'
END AS Time_Bucket,
HOUR(Transaction_Time) AS hour_of_day,
STORE_LOCATION,
PRODUCT_CATEGORY,
PRODUCT_DETAIL,
PRODUCT_TYPE,
UNIT_PRICE,
TRANSACTION_QTY,
SUM (TRANSACTION_QTY*UNIT_PRICE) AS Revenue,
CASE
WHEN Revenue =0 THEN 'None Spender'
WHEN Revenue BETWEEN 1 AND 50 THEN 'Low Spender'
WHEN Revenue BETWEEN 51 AND 100 THEN 'Medium Spender'
WHEN Revenue > 100 THEN 'High Spender'
END AS Spend_Bucket,
FROM CASESTUDY.BRIGHT.COFFEE_SHOP
GROUP BY ALL;

SELECT
    product_category,
    product_detail,
    product_type,
    COUNT(DISTINCT transaction_id) AS number_sales,
    SUM(CASE WHEN transaction_date BETWEEN '2023-01-01' AND '2023-01-31' THEN transaction_qty * unit_price ELSE 0 END) AS January_Revenue,
    SUM(CASE WHEN transaction_date BETWEEN '2023-02-01' AND '2023-02-28' THEN transaction_qty * unit_price ELSE 0 END) AS February_Revenue,
    SUM(CASE WHEN transaction_date BETWEEN '2023-03-01' AND '2023-03-30' THEN transaction_qty * unit_price ELSE 0 END) AS March_Revenue
FROM CASESTUDY.BRIGHT.COFFEE_SHOP  
GROUP BY ALL;