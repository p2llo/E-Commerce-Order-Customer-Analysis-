CREATE DATABASE EcommerceDB;
GO
USE EcommerceDB;

CREATE TABLE stg_orders (
    order_id VARCHAR(100),
    customer_id VARCHAR(100),
    order_status VARCHAR(50),
    order_purchase_timestamp VARCHAR(100),
    order_delivered_customer_date VARCHAR(100)
);


CREATE TABLE stg_customers (
    customer_id VARCHAR(100),
    customer_unique_id VARCHAR(100),
    customer_city VARCHAR(100),
    customer_state VARCHAR(100)
);


CREATE TABLE stg_order_items (
    order_id VARCHAR(100),
    order_item_id VARCHAR(50),
    product_id VARCHAR(100),
    seller_id VARCHAR(100),
    shipping_limit_date VARCHAR(100),
    price VARCHAR(50),
    freight_value VARCHAR(50)
);


CREATE TABLE stg_products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100)
);


BULK INSERT stg_orders
FROM 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\olist_orders_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);

BULK INSERT stg_order_items
FROM 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\olist_order_items_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);



BULK INSERT stg_customers
FROM 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\olist_customers_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);

BULK INSERT stg_products
FROM 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\olist_products_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);


SELECT 'stg_orders' AS table_name, COUNT(*) AS rows FROM stg_orders
UNION ALL
SELECT 'stg_customers', COUNT(*) FROM stg_customers
UNION ALL
SELECT 'stg_order_items', COUNT(*) FROM stg_order_items
UNION ALL
SELECT 'stg_products', COUNT(*) FROM stg_products;


