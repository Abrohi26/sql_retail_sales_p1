-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;
--Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
      transactions_id INT PRIMARY KEY,	
	  sale_date	DATE,
	  sale_time	TIME,
	  customer_id INT,	
	  gender VARCHAR(15),
	  age INT,	
	  category VARCHAR(15),	
	  quantiy INT,	
	  price_per_unit FLOAT,	
	  cogs	FLOAT,
	  total_sale FLOAT
	  );

--
SELECT * FROM Retail_sales
WHERE 
	transactions_id IS NULL 
	OR
	sale_date IS NULL
	OR 
	sale_time IS NULL 
	OR 
	customer_id IS NULL
	OR 
	GENDER IS NULL 
	OR 
	AGE IS NULL 
	OR 
	category IS NULL
	OR 
	quantiy IS NULL 
	OR 
	price_per_unit IS NULL
	or 
	cogs IS NULL 
	OR 
	total_sale IS NULL
-- data exploration 
-- How many sales do we have?
SELECT COUNT(*) AS total_sale from retail_sales

-- How many UNIQUE customers do we have?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

-- How many Unique categorys do we have?
SELECT COUNT(DISTINCT category) as total_sale FROM retail_sales
SELECT DISTINCT category FROM  retail_sales

-- Data Analysis & Business Key Problems and Answers

--Q.1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';

--Q.2. Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 3 in the month of Nov - 2022
SELECT *
From retail_sales
WHERE category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND 
	quantiy >=3

--Q.3. Write a SQL query to calculate the total sales (total_sale) for each cateogry.
SELECT 
    category,
	SUM(total_sale) as net_sale,
	count(*) as total_orders
FROM retail_sales 
Group by 1

--Q.4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT 
ROUND(avg(age),2) 
from retail_sales
WHERE category = 'Beauty'

--Q.5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * 
FROM retail_sales 
Where total_sale > 1000

--Q.6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT
	CATEGORY,
	gender,
	COUNT(*) as total_trans
FROM retail_sales
GROUP BY category,
gender
ORDER BY 1

-- Q.7. Write a SQL query to calculate the avg sale for each month. Find out the best selling month in each year?
SELECT 
year,
month, 
avg_sale

FROM 
(
	SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as AVG_SALE,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG (total_sale)DESC) as rank
	
	FROM retail_sales
	group by 1,2
	) AS t1
WHERE rank = 1

-- Q.8. Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
	Customer_id,
	SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 5

-- Q.9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
category,
COUNT(DISTINCT customer_id) as count_unique_customers
FROM retail_sales
GROUP BY 1
--Q.10 Write a SQL Query to create each shift and number of orders 
with HOURLY_SALE
AS
(
SELECT *,
	CASE
		WHEN extract (hour from sale_time) < 12 THEN 'Morning' 
		WHEN EXTRACT (hour from sale_time) BETWEEN 12 AND 17 THEN 'Afternoon' 
		ELSE 'Evening'
	END as shift
FROM Retail_sales
)
SELECT 
	shift,
	COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift


--SELECT EXTRACT(HOUR FROM CURRENT_TIME)
--END OF PROJECT



