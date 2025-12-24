CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_delivered_customer_date DATETIME
);

INSERT INTO orders
SELECT
    order_id,
    customer_id,
    order_status,
    TRY_CONVERT(DATETIME, order_purchase_timestamp, 120),
    TRY_CONVERT(DATETIME, order_delivered_customer_date, 120)
FROM stg_orders;

SELECT COUNT(*) FROM orders;


CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_city VARCHAR(50),
    customer_state CHAR(2)
);

INSERT INTO customers
SELECT
    customer_id,
    customer_unique_id,
    customer_city,
    LEFT(LTRIM(RTRIM(customer_state)), 2)
FROM stg_customers;


CREATE TABLE order_items (
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);

INSERT INTO order_items
SELECT
    order_id,
    product_id,
    TRY_CONVERT(DECIMAL(10,2), price),
    TRY_CONVERT(DECIMAL(10,2), freight_value)
FROM stg_order_items;



CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100)
);

INSERT INTO products
SELECT
    product_id,
    product_category_name
FROM stg_products;
