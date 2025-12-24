SELECT
    SUM(price + freight_value) AS total_revenue
FROM order_items;

SELECT 'orders' AS table_name, COUNT(*) rows FROM orders
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'products', COUNT(*) FROM products;


-- Orders without customers (should be 0 or very low)
SELECT COUNT(*) 
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Order items without orders
SELECT COUNT(*)
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


-- Total Revenue
SELECT SUM(ISNULL(price,0) + ISNULL(freight_value,0)) AS total_revenue
FROM order_items;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- Total Customers
SELECT COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;



-- Monthly Revenue
SELECT
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS month,
    SUM(oi.price + oi.freight_value) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY month;


-- Repeat vs One-Time Customers
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    CASE 
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY
    CASE 
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END;



-- Revenue by Product Category
SELECT
    p.product_category_name,
    SUM(oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC;

-- Top 10 Customers by Spend
SELECT TOP 10
    c.customer_unique_id,
    SUM(oi.price + oi.freight_value) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC;

-- Month-over-Month Growth
WITH monthly_sales AS (
    SELECT
        FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS month,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
)
SELECT
    month,
    revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS mom_growth
FROM monthly_sales;


CREATE VIEW vw_kpi_summary AS
SELECT
    (SELECT COUNT(DISTINCT order_id) FROM orders) AS total_orders,
    (SELECT COUNT(DISTINCT customer_unique_id) FROM customers) AS total_customers,
    (SELECT SUM(price + freight_value) FROM order_items) AS total_revenue;

CREATE VIEW vw_monthly_revenue AS
SELECT
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS month,
    SUM(oi.price + oi.freight_value) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM');


-- Revenue by category
CREATE OR ALTER VIEW vw_category_revenue AS
SELECT
    p.product_category_name,
    SUM(oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name;


-- Customer type distribution
CREATE OR ALTER VIEW vw_customer_type AS
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    CASE 
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY
    CASE 
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END;
