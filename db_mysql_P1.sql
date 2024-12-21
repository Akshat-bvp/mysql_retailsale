SELECT * FROM retail_sales;


SELECT * FROM retail_sales
WHERE transactions_id IS NULL;



SELECT * FROM retail_sales 
WHERE sale_date IS NULL;

SELECT * FROM retail_sales 
WHERE sale_time IS NULL;     

SELECT * FROM retail_sales
WHERE customer_id IS NULL;

SELECT * FROM retail_sales
WHERE category IS NULL;

SELECT * FROM retail_sales
WHERE transactions_id IS NULL 
OR sale_date IS NULL 
OR sale_time IS NULL 
OR gender IS NULL
OR quantiy IS NULL
OR cogs IS NULL
OR total_sale IS NULL;


SELECT COUNT(*) FROM retail_sales; 

SELECT COUNT(DISTINCT customer_id) AS total_sales FROM retail_sales;

SELECT COUNT(DISTINCT category) AS UNIQUE_CATEGORY FROM retail_sales;

SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

SELECT * FROM retail_sales WHERE category = 'Clothing' AND quantiy >= 4 AND YEAR(sale_date) = 2022 AND MONTH(sale_date) = 11;

SELECT category, SUM(total_sale) AS NSale FROM retail_sales GROUP BY category; 

SELECT AVG(age) AS vge FROM retail_sales WHERE category = 'Beauty';

SELECT * FROM retail_sales WHERE total_sale > 1000;

SELECT category, gender, COUNT(*) AS total_sales FROM retail_sales GROUP BY category, gender;

SELECT * FROM 
(
SELECT AVG(total_sale) AS ts, 
EXTRACT(YEAR FROM sale_date) as y, 
EXTRACT(MONTH FROM sale_date) as m,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS r
FROM retail_sales
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
ORDER BY EXTRACT(MONTH FROM sale_date), EXTRACT(YEAR FROM sale_date), ts DESC
) AS t1
WHERE r = 1 ;

SELECT * FROM retail_sales;

SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

SELECT * FROM retail_sales;

SELECT COUNT(DISTINCT customer_id), category
FROM retail_sales 
GROUP BY category;


WITH hourly_sale
AS
(
SELECT *, 
CASE WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN "Morning"
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN "Afternoon"
ELSE "Evening"
END AS shift
FROM retail_sales
)
SELECT shift, COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift;