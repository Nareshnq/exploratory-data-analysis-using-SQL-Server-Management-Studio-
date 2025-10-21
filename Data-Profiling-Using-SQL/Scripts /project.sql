---Database Exploration
--==============================================================
--==============================================================
-- we will use DataWarehouseAnalytics database for this project --

USE DataWarehouseAnalytics;

--explore all object in the database 
SELECT * FROM INFORMATION_SCHEMA.TABLES

--explore all columns in database 
SELECT * FROM INFORMATION_SCHEMA.COLUMNS

--for specific  table
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dim_customers'


--==============================================================
--==============================================================
--- Dimensions Exploration
--==============================================================
--==============================================================


--Identifying the unique values (or categories) in each dimension.Recognizing how data might be grouped or segmented,which is useful for later analysis.

/*
 PURPOSE:
To understand the categorical structure of our data 
by finding the UNIQUE values for each DIMENSION column.
*/

/*
 WHY THIS MATTERS:
- Helps identify what categories, countries, or product types exist.
- Shows the granularity of each dimension (e.g., few categories vs. many products).
- Gives insight into how detailed or broad each dimension is.
*/

/*
 SQL TOOL: DISTINCT
- Use DISTINCT to get all unique (non-repeated) values from a column.
- Syntax:
    SELECT DISTINCT column_name
    FROM table_name;
*/


-- EXAMPLES:

-- 1️ Explore countries of customers
SELECT DISTINCT country FROM gold.dim_customers;
--  Shows all unique countries (e.g., Germany, USA, France, Canada, etc.)
-- Helps understand the geographical spread of customers.

-- 2️ Explore product categories
SELECT DISTINCT category FROM gold.dim_products;
--  Displays all main product divisions (e.g., Accessories, Bikes, Clothing, Components).

-- 3️ Explore subcategories with categories
SELECT DISTINCT category, subcategory FROM gold.dim_products;
--  Reveals detailed product structure (e.g., Bikes → Mountain Bikes, Road Bikes).

-- 4️ Full product hierarchy
SELECT DISTINCT category, subCategory, product_name FROM gold.dim_products ORDER BY category, subcategory, product_name;

--  Shows the relationship between all three levels.
-- Helps understand how many total products exist (e.g., ~295 products).


/*
 INSIGHT:
- Different dimensions have different levels of granularity:
    ▪ Category → 4 values (high-level)
    ▪ SubCategory → dozens of values (mid-level)
    ▪ ProductName → hundreds of values (detailed)
*/

/*
 KEY TAKEAWAY:
- Exploring dimensions using DISTINCT gives a clear understanding 
  of how the data is structured.
*/

--==============================================================
--==============================================================
-- Date Exploration
--==============================================================
--==============================================================
--it helps us to understand how date is affecting the outcome 

-- we are taking table gold.fact_sales as an example 


--finding the date of first and last order --
SELECT 
MIN(order_date) AS First_order_date,
MAX(order_date) AS Last_order_date
FROM gold.fact_sales

--how many years of sales are available --
--SYNTAX:  DATEDIFF ( datepart , start_date , end_date )

SELECT 
MIN(order_date) AS First_order_date,
MAX(order_date) AS Last_order_date,
DATEDIFF(YEAR,MIN(order_date),MAX(order_date)) AS order_range_years,
DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS order_range_months
FROM gold.fact_sales

--Find the youngest and oldest customer using  gold.dim_customers
SELECT * FROM gold.dim_customers;

SELECT 
MIN(birthdate) AS old_customer ,
MAX(birthdate) AS young_customer
FROM gold.dim_customers



SELECT 
MIN(birthdate) AS old_customer ,
MAX(birthdate) AS young_customer,
DATEDIFF(YEAR ,MIN(birthdate),GETDATE())AS old_age ,
DATEDIFF(YEAR ,MAX(birthdate),GETDATE())AS youngest_age
FROM gold.dim_customers

---================================================
---================================================
----Measure Exploration
--=================================================
--=================================================
/*
Find the Total Sales
Find how many items are sold
Find the average selling price
Find the Total number of Orders
Find the total number of products
Find the total number of customers
Find the total number of customers that has placed an order   */


-- Find the Total Sales
SELECT SUM(sales_amount) AS total_sales FROM gold. fact_sales

--Find how many items are sold
SELECT SUM(quantity) AS total_quantity FROM gold. fact_sales

-- Find the average selling price
SELECT AVG(price) AS avg_price FROM gold. fact_sales

-- Find the Total number of Orders
SELECT COUNT (order_number) AS total_orders FROM gold. fact_sales
SELECT COUNT (DISTINCT order_number) AS total_orders FROM gold. fact_sales

-- Find the total number of products
SELECT COUNT(product_name) AS total_products FROM gold.dim_products
SELECT COUNT(DISTINCT product_name) AS total_products FROM gold.dim_products

--Find the total number of customers
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers

--Find the total number of customers that has placed an order
-- SELECT * FROM gold. fact_sales;
SELECT COUNT(DISTINCT customer_key) AS customers_who_ordered FROM gold.dim_customers


--Generate a report that shows all key metrics of the business 

SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold. fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold. fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold. fact_sales
UNION ALL
SELECT 'Total Nr. Orders', COUNT(DISTINCT order_number) FROM gold. fact_sales
UNION ALL
SELECT 'Total Nr. Products', COUNT(product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Nr. Customers', COUNT(customer_key) FROM gold.dim_customers



---=========================================================================
---=========================================================================
---Magnitude Analysis
---=========================================================================
---=========================================================================


/*
 DEFINITION:
Magnitude Analysis is about comparing MEASURE values across different DIMENSIONS.
It helps us understand the relative importance or performance of each category.

 PURPOSE:
- Identify which category performs best or worst.
- Compare totals, averages, or counts between groups.
- Reveal insights like “Top-performing country”, “Highest sales category”, etc.

 FORMULA:
Aggregate a MEASURE → Group it BY a DIMENSION

 General pattern:
SELECT Dimension, AGGREGATE(Measure)
FROM Table
GROUP BY Dimension;

 EXAMPLES:

-- 1️ Total Sales by Country
-- 2️ Total Quantity by Category
-- 3️ Average Price by Product
-- 4️ Total Orders by Customer

 CONCEPT:
If total measure = 600
and grouped by Category (A, B, C):
   ▪ A → 200
   ▪ B → 300
   ▪ C → 100
We can now COMPARE categories:
   ▪ Highest = B
   ▪ Lowest  = C

 INSIGHT:
By combining ANY MEASURE with ANY DIMENSION,
you create a new insight (e.g., Total Sales by Region, Avg Age by Gender).
This is the foundation of most business analysis and dashboards.

 TAKEAWAY:
Magnitude Analysis = Aggregation + Comparison
It tells us:
→ “How much” per “What”                             */



--Some working example --> 

-- Find total customers by countries                            (gold.dim_customers)
-- Find total customers by gender                               (gold.dim_customers)
-- Find total products by category                              (gold.dim_products)
-- What is the average costs in each category?                  (gold.dim_products)
-- What is the total revenue generated for each category?       (gold.dim_products and gold. fact_sales)
-- Find total revenue is generated by each customer             (gold.dim_customers and gold. fact_sales)
-- What is the distribution of sold items across countries?     (gold.dim_customers and gold. fact_sales)


-- Find total customers by countries (gold.dim_customers)
SELECT * FROM gold.dim_customers ;


SELECT country,customer_key  FROM gold.dim_customers;

SELECT 
country ,
COUNT(customer_key) Total
FROM gold.dim_customers
GROUP BY country 

SELECT 
country ,
COUNT(customer_key) Total
FROM gold.dim_customers
GROUP BY country 
ORDER BY Total
ASC
----------------------------------------------------------------------
-- Find total customers by gender (gold.dim_customers)
SELECT * FROM gold.dim_customers


SELECT 
gender ,
COUNT(customer_key) Total
FROM gold.dim_customers
GROUP BY gender 
ORDER BY Total
ASC
----------------------------------------------------------------------
-- Find total products by category
SELECT * FROM gold.dim_products

SELECT
category,
COUNT(product_key) AS total_products 
FROM gold.dim_products
GROUP BY category
ORDER BY total_products ASC 

----------------------------------------------------------------------
-- What is the average costs in each category?
SELECT * FROM gold.dim_products

SELECT
category,
AVG(cost) AS Avg_cost 
FROM gold.dim_products
GROUP BY category
ORDER BY Avg_cost ASC 

----------------------------------------------------------------------
-- What is the total revenue generated for each category?    (gold.dim_products and gold. fact_sales)
SELECT * FROM gold.dim_products
SELECT * FROM gold. fact_sales


SELECT
p.category,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold. dim_products p
ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC
----------------------------------------------------------------------
-- Find total revenue is generated by each customer
SELECT * FROM gold. dim_customers
SELECT * FROM gold. fact_sales


SELECT
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold. dim_customers c
ON c.customer_key = f.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_revenue

----------------------------------------------------------------------
-- What is the distribution of sold items across countries?
SELECT * FROM gold. dim_customers
SELECT * FROM gold. fact_sales


SELECT
c.country,
SUM(f.quantity) AS total_sold_items
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY
c.country
ORDER BY total_sold_items DESC

----------------------------------------------------------------------
----------------------------------------------------------------------
-- Ranking Analysis
----------------------------------------------------------------------
----------------------------------------------------------------------

--which 5 products generate the highest revenue ?
SELECT * FROM gold. fact_sales
SELECT * FROM gold. dim_products


SELECT product_key,sales_amount FROM gold. fact_sales;

SELECT TOP 5
p.product_name,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

--same answer using window function 
SELECT
p.product_name,
SUM(f.sales_amount) total_revenue,
ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name


SELECT * FROM
(
SELECT
p.product_name,
SUM(f.sales_amount) total_revenue,
ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
FROM gold. fact_sales f
LEFT JOIN gold. dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
)t
WHERE rank_products <= 5

----------------------------------------------------------------------

--which 5 products generate the lowest revenue ?

SELECT TOP 5
p.product_name,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC

----------------------------------------------------------------------
--Find the top 10 customers who have generated the highest revenue
SELECT
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold. dim_customers c
ON c.customer_key = f.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_revenue DESC
----------------------------------------------------------------------

-- The 3 customers with the fewest orders placed

SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) AS total_orders
FROM gold. fact_sales f
LEFT JOIN gold. dim_customers c
ON c.customer_key = f.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_orders

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
