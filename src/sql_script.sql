-- Some SQL scripts used in the projects

-- 0.Determine total number of orders
SELECT
    COUNT(*) as total_transactions,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM 
    transactions;


-- 1.Find the top 10 single orders with higest/lowest profit margin
SELECT *
FROM
    transactions
ORDER BY profit_margin DESC
LIMIT 10;

SELECT *
FROM
    transactions
ORDER BY profit_margin
LIMIT 10;


-- 2.Summary of loss transactions
SELECT
    COUNT(*) as total_transactions,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin
FROM
    transactions
WHERE
    profit_margin < 0;


-- 3.Determine 10 products that have highest profit margin
SELECT
    product_code,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM
    transactions
GROUP BY
    product_code
ORDER BY
    profit_margin DESC
LIMIT
    10;

-- 3.Determine 10 products that have lowest profit margin
SELECT
    product_code,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM
    transactions
GROUP BY
    product_code
ORDER BY
    profit_margin
LIMIT
    10;

-- 4.Determine the products that have the higest profit margin percentage
SELECT
    product_code,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM
    transactions
GROUP BY
    product_code
HAVING
    total_quantity > 20
ORDER BY
    profit_margin_perc DESC
LIMIT
    10

-- 4.Determine the products that have the lowest profit margin percentage
SELECT
    product_code,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM
    transactions
GROUP BY
    product_code
HAVING
    total_quantity > 20
ORDER BY
    profit_margin_perc
LIMIT
    10;

-- 5A. Determine the performance of each market by joining market zones with transactions table
%
SELECT 
    ma.zone, 
    tr.market_code, 
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM 
    transactions tr
INNER JOIN 
    markets ma ON tr.market_code = ma.markets_code
GROUP BY 
    ma.zone, tr.market_code
ORDER BY 
    profit_margin DESC;

-- 5B. Total sales of each zone
%%sql

SELECT 
    ma.zone,  
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM 
    transactions tr
INNER JOIN 
    markets ma ON tr.market_code = ma.markets_code
GROUP BY 
    ma.zone
ORDER BY 
    profit_margin DESC;

-- 5C. Look at each zone performance in each year
SELECT 
    ma.zone,
    date.year,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM 
    transactions tr
INNER JOIN 
    markets ma ON tr.market_code = ma.markets_code
LEFT JOIN
    date ON order_date = date.date
GROUP BY 
    ma.zone, date.year
ORDER BY 
    ma.zone DESC;

-- 6. Sales by year
SELECT
    date.year,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM
    transactions
INNER JOIN
    date ON order_date = date.date
GROUP BY
    date.year
ORDER BY
    year DESC;

-- 7.Sales by each month of the year
SELECT
    date.month_name,
    ROUND(AVG(sales_qty), 1) as avg_quantity, 
    ROUND(AVG(sales_amount), 3) as avg_sales,
    ROUND(AVG(cost_price), 3) as avg_cost,
    ROUND(AVG(profit_margin), 3) as avg_profit_margin,
    ROUND(AVG(profit_margin) / AVG(sales_amount), 3) as avg_profit_margin_perc
FROM
    transactions
INNER JOIN
    date ON order_date = date.date
GROUP BY
    month_name
ORDER BY
    avg_profit_margin DESC;

-- 8. Statistics of each customer type
SELECT
    customers.customer_type,
    COUNT(*) as total_transactions,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM
    transactions tr
RIGHT JOIN
    customers ON customers.customer_code = tr.customer_code
GROUP BY
    customers.customer_type
ORDER BY
    profit_margin DESC
LIMIT
    5;

-- 8B. Sales trend in 4 years of each customer type
SELECT
    customers.customer_type,
    date.year,
    COUNT(*) as total_transactions,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM
    transactions tr
RIGHT JOIN
    customers ON customers.customer_code = tr.customer_code
INNER JOIN
    date ON order_date = date.date
GROUP BY
    customers.customer_type, date.year
ORDER BY
    customer_type;

-- 9A. Top 5 customers that make the highest profit margin
SELECT
    tr.customer_code,
    cu.customer_type,
    COUNT(*) as total_transactions,
    SUM(sales_qty) as total_quantity, 
    SUM(sales_amount) as sales_amount,
    ROUND(SUM(cost_price), 3) as total_cost,
    ROUND(SUM(profit_margin), 3) as profit_margin,
    ROUND(SUM(profit_margin) / SUM(sales_amount), 3) as profit_margin_perc
FROM
    transactions tr
RIGHT JOIN
    customers cu ON cu.customer_code = tr.customer_code
GROUP BY
    cu.customer_type, tr.customer_code
ORDER BY
    profit_margin DESC
LIMIT
    5;