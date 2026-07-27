
# 🐘 Online Bookstore Data Analytics Project (PostgreSQL)

## 📌 Project Overview
This project showcases a complete relational database design and analytical inquiry for an Online Bookstore using **PostgreSQL**. It features full database schema setup (DDL), relational foreign key constraints, data cleaning/alterations, and analytical business queries ranging from standard data retrieval to advanced multi-table JOINs and aggregations.

---

## 🛠️ Tech Stack & PostgreSQL Concepts
* **Database Management System:** PostgreSQL (pgAdmin / psql)
* **SQL Capabilities Highlighted:**
  * **Data Definition Language (DDL):** PostgreSQL `SERIAL` primary keys, data type adjustments (`VARCHAR`, `NUMERIC`), table constraints, and drop rules[cite: 1, 3].
  * **Data Filtering & Operations:** `WHERE`, `BETWEEN`, `LIKE`, `LIMIT`, `DISTINCT`.
  * **Aggregations & Grouping:** `SUM()`, `AVG()`, `COUNT()`, `GROUP BY`, `HAVING`.
  * **Relational Joins:** `INNER JOIN`, `LEFT JOIN`.
  * **Data Handling:** `COALESCE()` for NULL management during inventory calculations.

---

## 🗂️ Relational Database Schema

```sql
Books (Book_ID [PK], Title, Author, Genre, Published_year, Price, Stock)
Customers (Customer_id [PK], Name, Email, Phone, City, Country)
Orders (Order_ID [PK], Customer_ID [FK], Book_ID [FK], Order_date, Quantity, Total_Amount)
