-- ----- Create a database------- --
CREATE DATABASE P1_retail_db;

USE  P1_retail_db;

-- Create table name of retail_sales --

CREATE TABLE retail_sales(
	transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(20),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- Understanding table structure --
 
DESCRIBE retail_sales;
SELECT * FROM retail_sales LIMIT 1;

-- Count the total number of records in the dataset --

SELECT COUNT(*) AS Total_data FROM retail_sales;

-- Find out how many unique customers are in the dataset --

SELECT count(DISTINCT customer_id) AS unique_customers FROM retail_sales;

-- Identify all unique product categories in the dataset --

SELECT DISTINCT category FROM retail_sales;

-- Check for any null values in the dataset and delete records with missing data --

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    
    
-- ----------Data Analysis & Findings------------ --    
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022 --

SELECT * FROM retail_sales
WHERE 
	category='clothing' 
    AND
    quantity>=4
    and
    sale_date BETWEEN '2022-11-01' AND '2022-11-30';
    
-- 3. Write a SQL query to calculate the total sales (total_sale) for each category --

SELECT category,sum(total_sale) AS total_sales FROM retail_sales
GROUP BY category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category --

SELECT AVG(age) as avgc FROM retail_sales
WHERE category ='beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000 --

SELECT * FROM retail_sales
where total_sale > 1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category --

SELECT category,gender,COUNT(*) AS num_transaction FROM retail_sales
GROUP BY category,gender
ORDER BY 1;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year --

SELECT DATE_FORMAT(sale_date,'%M') AS month,AVG(total_sale) AS avrg_sell FROM retail_sales
GROUP BY DATE_FORMAT(sale_date,'%M')
ORDER BY AVG(total_sale) DESC;

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales --

SELECT customer_id,SUM(total_sale) FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category --

SELECT category,COUNT(DISTINCT customer_id) AS unique_customer FROM retail_sales
GROUP BY category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hours
AS
(
SELECT *,
	case
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS shift
FROM retail_sales
)
SELECT shift,COUNT(*) AS ASD FROM hours
GROUP BY shift;