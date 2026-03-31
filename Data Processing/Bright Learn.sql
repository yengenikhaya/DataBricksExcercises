------------------------------------------------------------
--1. check the table types of columns i have
-----------------------------------------------------------

SELECT*
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;
------------------------------------------------------
--2.Date Range Checking
------------------------------------------------------
SELECT MIN(transaction_date) AS min_date 
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;

--  When did they start collecting the data (2023-01-01)

SELECT MAX(transaction_date) AS latest_date 
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;

--  Last date for collecting the data (2023-06-30)
------------------------------------------------------------
--3.Diffrent store locations
----------------------------------------------------------
SELECT DISTINCT store_location
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;
--How many stores do we have?
----------------------------------------------------------
--4. products sold at our store- 9 different product categories
------------------------------------------------------
SELECT DISTINCT product_category
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;

--------------------------------------------------------------
--5. Checking product prices
--------------------------------------------------------------
SELECT MIN(unit_price) As cheapest_price
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;

SELECT MAX(unit_price) As expensive_price
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;
-------------------------------------------------------------
---6. Product Types - 29 product types
-------------------------------------------------------
SELECT DISTINCT product_type
From workspace.default.bright_coffee_shop_analysis_case_study_1;
---------------------------------------------------------------
--7.product_detail - 80 different product details
---------------------------------------------------------------
SELECT DISTINCT product_detail
From workspace.default.bright_coffee_shop_analysis_case_study_1;
-----------------------------------------------------------------
--8. Checking for NULL IN COLUMNS
---------------------------------------------------------------
SELECT* 
FROM workspace.default.bright_coffee_shop_analysis_case_study_1
WHERE unit_price IS NULL;

--------------------------------------------------------
-- 9.Day and Month of the transaction
--------------------------------------------------------

SELECT transaction_date,
dayname(transaction_date) AS Day_name,
monthname(transaction_date) AS Month_name
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;

----------------------------------------------------
--10. Revenue
--------------------------------------------------
SELECT unit_price,
transaction_qty,
unit_price*transaction_qty AS Revenue
FROM workspace.default.bright_coffee_shop_analysis_case_study_1;

------------------------------------------------------------------
--Money Data (Big Data)
-------------------------------------------------------------
SELECT 
transaction_id,
transaction_date,
transaction_time,
transaction_qty,
store_id,
store_location,
product_id,
unit_price,
product_category,
product_type,
product_detail,
unit_price*transaction_qty AS Revenue,

--Enhancing table for better insight by adding columns
Dayname(transaction_date) AS Day_name,
Monthname(transaction_date) AS Month_name,
Dayofmonth(transaction_date) AS Date_of_month,

CASE WHEN Dayname(transaction_date) = "Sat" OR Dayname(transaction_date) = "Sun" THEN 'Weekend'
ELSE 'Weekday'
END AS Day_Classification,
CASE WHEN Dayofmonth(transaction_date) between "25" AND "31" THEN 'Month_End'
WHEN Dayofmonth(transaction_date) between "1" AND "7" THEN 'Month_Start'

ELSE 'Mid_month'
END AS Time_of_month_Classification,

CASE WHEN date_format(transaction_time,'HH;mm;ss') between "05:00:00" AND "09:59;59" THEN 'Rush_hour'
WHEN date_format(transaction_time,'HH;mm;ss') between "10:00:00" AND "11:59;59" THEN 'Mid_morning'
WHEN date_format(transaction_time,'HH;mm;ss') between "12:00:00" AND "16:59;59" THEN 'Afternoon'
WHEN date_format(transaction_time,'HH;mm;ss') between "17:00:00" AND "18:59;59" THEN 'Evening'
WHEN date_format(transaction_time,'HH;mm;ss') between "19:00:00" AND "23:59;59" THEN 'Night'
ELSE 'Night'
END AS Time_of_day_Classification,
--Spend Buckets

CASE 
        WHEN (transaction_qty * unit_price) <= 50 THEN '01.Low_spender'
        WHEN (transaction_qty * unit_price) BETWEEN 51 AND 200 THEN '02.Medium_spender'
        WHEN (transaction_qty * unit_price) BETWEEN 201 AND 300 THEN '03.High_spender'
        ELSE '04.Very_high_spender'
    END AS Spend_Bucket


FROM workspace.default.bright_coffee_shop_analysis_case_study_1;

