# 🛒 E-Commerce Order & Customer Analysis 

## 📌 Project Overview

This project performs an **end-to-end E-Commerce analytics workflow** using **SQL Server** with a strong focus on **SQL-based data engineering and analysis**.
The goal is to transform raw CSV data into clean relational tables and derive **business insights related to revenue, customer behavior, and product performance**.

The project follows a **professional ETL approach**:
**Staging → Cleaning → Analytics → Reporting**

---

## 🧰 Tech Stack

* **SQL Server (Express / Developer Edition)**
* **VS Code** with SQL Server (mssql) extension
* **Power BI** (used only for final visualization)
* **GitHub** for version control

---

## 📂 Dataset Information

### Dataset Name

**Brazilian E-Commerce Public Dataset by Olist**

### Source

Available on Kaggle

### Dataset Link

[https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

### Files Used

* `olist_orders_dataset.csv`
* `olist_customers_dataset.csv`
* `olist_order_items_dataset.csv`
* `olist_products_dataset.csv`

---

## 🗂️ Project Structure

```
Ecommerce-Order-Customer-Analysis/
│
├── data/
│   └── olist_*.csv
│
├── sql/
│   ├── create.sql
│   ├── cleaning.sql
│   ├── analysis.sql
│
├── powerbi/
│   └── Ecommerce_Analytics.pbix
│
└── README.md
```

---

## 🏗️ Data Pipeline Architecture

1. **Staging Tables**

   * All columns defined as `VARCHAR`
   * Used for safe ingestion of raw CSV data
   * Handles dirty data, format inconsistencies, and truncation issues

2. **Clean Tables**

   * Proper data types (`INT`, `DECIMAL`, `DATETIME`)
   * Data cleaned using `TRY_CONVERT`, trimming, and controlled transformations

3. **Analytics Layer**

   * Business-driven SQL queries
   * Aggregations, joins, CTEs, and window functions

4. **Reporting Layer**

   * SQL views created for Power BI consumption

---

## 🧪 Key SQL Concepts Used

* `BULK INSERT` with safe options (`FIELDQUOTE`, `CODEPAGE`, `ROWTERMINATOR`)
* Staging vs clean schema design
* Data type conversion using `TRY_CONVERT`
* Common Table Expressions (CTEs)
* Aggregations & joins
* Window functions (`LAG`)
* SQL views for BI reporting

---

## 📊 Business Questions Answered

* What is the **total revenue** generated?
* How does **monthly revenue trend** over time?
* Who are the **top revenue-generating customers**?
* What percentage of customers are **repeat vs one-time buyers**?
* Which **product categories** generate the most revenue?

---

## 📈 Sample Insights

* Revenue shows clear monthly seasonality patterns
* A smaller group of repeat customers contributes a large share of revenue
* Certain product categories dominate overall sales performance
* Freight cost has a noticeable impact on total order value

---

## 📊 Power BI Usage (Lightweight)

Power BI is used only for **visualization**, while all transformations and metrics are handled in SQL.

**Dashboards include:**

* KPI cards (Revenue, Orders, Customers)
* Monthly revenue trend
* Revenue by product category
* One-time vs repeat customer distribution

---


## 🚀 How to Run This Project

1. Install SQL Server and VS Code
2. Download dataset from Kaggle
3. Move CSV files to SQL Server DATA directory
4. Execute SQL scripts in order:
5. Open Power BI file for visualization

---

## 📎 Future Enhancements

* Add payments and reviews datasets
* Customer Lifetime Value (CLV) analysis
* Indexing and performance optimization
* Incremental data loading
* Advanced Power BI DAX measures
