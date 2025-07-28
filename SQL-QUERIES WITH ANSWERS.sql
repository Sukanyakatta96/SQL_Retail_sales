-- SQL Retail Sales Analysis 

CREATE DATABASE SALES PROJECT;

--Create sales table 
CREATE TABLE sales
                  (
                   transactions_id	INT PRIMARY KEY,
				   sale_date	DATE,
				   sale_time	TIME,
				   customer_id	 INT,
				   gender	VARCHAR(10),
				   age	INT,
				   category VARCHAR(20),
				   quantiy	INT,
				   price_per_unit FLOAT,
				   cogs FLOAT, 
				   total_sale FLOAT
				  );
				  
----

SELECT * FROM sales;

----

SELECT COUNT(*)
FROM sales; 

----

--DATA CLEANING 
--checking all the null values in the table 

SELECT * FROM sales
WHERE transactions_id IS  NULL;

----

SELECT * FROM sales
WHERE sale_date IS  NULL;

----

SELECT * FROM sales
WHERE sale_time IS  NULL;

----

SELECT * FROM sales
WHERE customer_id IS  NULL;

----

SELECT * FROM sales
WHERE gender IS  NULL;

----

SELECT * FROM sales
WHERE age IS  NULL;

----

SELECT * FROM sales
WHERE category IS  NULL;

----

SELECT * FROM sales
WHERE quantiy IS  NULL;

----

SELECT * FROM sales
WHERE price_per_unit IS  NULL;

----

SELECT * FROM sales
WHERE cogs IS  NULL;

----

SELECT * FROM sales
WHERE total_sale IS  NULL;

----

SELECT * FROM sales
WHERE transactions_id IS  NULL 
      OR 
	  sale_date IS NULL
	  OR 
	  sale_time IS NULL
	  OR
	  customer_id IS NULL
	  OR
	  gender IS NULL
	  OR
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantiy IS NULL 
	  OR
	  price_per_unit IS NULL
	  OR 
	  cogs IS NULL 
	  OR
	  total_sale IS NULL;

------

--deleting null values
DELETE FROM sales
WHERE transactions_id IS  NULL 
      OR 
	  sale_date IS NULL
	  OR 
	  sale_time IS NULL
	  OR
	  customer_id IS NULL
	  OR
	  gender IS NULL
	  OR
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantiy IS NULL 
	  OR
	  price_per_unit IS NULL
	  OR 
	  cogs IS NULL 
	  OR
	  total_sale IS NULL;

----

SELECT * FROM sales;

-- Data Exploration 

--How many sales we have ?
SELECT COUNT(*) AS total_sales FROM sales;


--How many unique customers we have ?

SELECT COUNT(DISTINCT(customer_id)) AS total_customers FROM sales;

--How many unique categories we have ?
SELECT DISTINCT(category) AS total_customers FROM sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * 
FROM sales 
WHERE sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT * 
FROM sales
WHERE 
      category = 'Clothing' 
      AND 
	  quantiy>=4
	  AND
	  to_char(sale_date,'yyyy-mm')='2022-11'
     

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, 
       SUM(total_sale) AS total_sales,
	   COUNT(*) AS total_orders   
FROM sales
GROUP BY 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT round(AVG(age),2) 
FROM sales
WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * 
FROM sales
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.

SELECT gender, 
       category, 
	   COUNT(*) AS totla_transactions
FROM sales
GROUP BY gender, category
ORDER BY COUNT(*) ASC

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,
       COUNT(DISTINCT(customer_id))
from sales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM sales
GROUP BY 
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END

-- End of Project 