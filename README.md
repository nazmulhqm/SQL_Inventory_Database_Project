# Inventory Management System (IMS)

**The Inventory Management System (IMS)** project is designed to efficiently manage inventory, suppliers, customers, and orders. This project is divided into two main parts: Data Definition Language (DDL) and Data Manipulation Language (DML). Each part handles different aspects of the system using SQL Server.

## Components

### 1. Data Definition Language (DDL)

  - Created a database named **`InventoryDB`** with customized properties.
  - Set up tables for storing various types of information, including: `Addresses`, `Contacts`,`Brands`, `Manufacturers`, `Suppliers`, `Products` etc
  - Designed table structures to store and organize data efficiently.
  - Created views to simplify data retrieval.
  - Developed stored procedures to automate tasks.
  - Added primary and foreign keys to ensure proper data relationships.
  - Implemented indexes to optimize search performance.

### 2. Data Manipulation Language (DML)
  - Added sample data to the tables.
  - Utilized SQL queries with the basic six clauses (`SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`) for data retrieval and analysis.
  - Demonstrated operations including:
    - `TRUNCATE` and `DELETE` for data management
    - Various joins (inner, left, right, full, and cross) for complex queries
    - `CAST` and `CONVERT` functions for data transformation
    - `DISTINCT` for unique values
    - Aggregate functions for summarization
    - Mathematical operations for calculations
    - `FETCH` for paginated results
