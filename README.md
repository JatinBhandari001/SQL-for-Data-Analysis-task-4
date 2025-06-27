# SQL-for-Data-Analysis-task-4

This project demonstrates the use of **SQL** to analyze customer behavior, book sales, and revenue patterns from an online bookstore dataset.

---

## 📁 Dataset Overview

The analysis is based on three CSV files:

| File         | Description                             |
|--------------|-----------------------------------------|
| `Books.csv`  | Book details including title, genre, stock, and price |
| `Customers.csv` | Customer info like name, country, and email |
| `Orders.csv` | Order transactions (bookID, quantity, date, etc.) | <br>

Data was imported using SQL import wizard from CSV files.

---

## 🎯 Objectives

- Identify top-selling books and genres
- Calculate customer-wise revenue
- Track monthly sales trends
- Find low-stock books
- Use SQL views, subqueries, and indexes for analysis

---

## 🛠️ Tools Used

- **SQL** (MySQL workbench)
- CSV datasets

---

## 🧠 Sample Analysis Questions

- Who are the top 5 customers by revenue?
- What are the top 10 books by sales volume?
- How much revenue is generated each month?
- Which books need restocking (Stock < 10)?
- What genre generates the most income?

---

**Views created**

-- Books that sold the most
CREATE VIEW TopBooksView AS
SELECT b.book_id, b.title, b.genre, SUM(o.quantity) AS UnitsSold,
       SUM(o.quantity * b.price) AS TotalRevenue
FROM orders o
JOIN book b ON o.book_id = b.book_id
GROUP BY b.book_id, b.title, b.genre
ORDER BY UnitsSold DESC;<br>




-- Books with stock less than 10
CREATE VIEW Lowstockbookview AS
SELECT book_id, title, stock
FROM book
WHERE stock < 10; <br>


-- **Index** to speed up book lookups in orders
CREATE INDEX idx_orders_bookid ON orders(book_id);<br>

## 🖼️ Screenshots

Screenshots of query outputs are available in the sql 'screenshots task 4` folder.

---


## 🚀 How to Use

1. Clone the repo.
2. Load the `.csv` files into your SQL database.
3. Run `create_tables.sql` to create the schema.
4. Import data and execute queries from `analysis_queries.sql`.

---

