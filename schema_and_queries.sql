--Create tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
      Book_ID SERIAL PRIMARY KEY,
	  Title VARCHAR(50),
	  Author VARCHAR(50),
	  Genre VARCHAR(50),
	  Published_year INT,
	  Price NUMERIC (10,2),
	  Stock INT
);

SELECT*FROM Books;

ALTER TABLE Books
ALTER COLUMN Title TYPE VARCHAR(255);

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
         Customer_id SERIAL PRIMARY KEY,
		 Name VARCHAR(100),
		 Email VARCHAR (50),
		 Phone INT,
		 City VARCHAR(50),
		 Country VARCHAR(50)
		 
);

SELECT*FROM Customers;

ALTER TABLE Customers
ALTER COLUMN Country TYPE VARCHAR(255);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
         Order_ID SERIAL PRIMARY KEY,
		 Customer_ID INT REFERENCES Customers(Customer_ID),
		 Book_ID INT REFERENCES Books(Book_ID),
		 Order_date DATE, 
		 Quantity INT,
		 Total_Amount NUMERIC(10,2)
);

SELECT*FROM Orders;

--BASIC QUESTION

--1.Retrive all the books in the 'Fiction' genre.
SELECT * FROM Books
WHERE genre='Fiction';

--2.Find books published after the year 1950
SELECT * FROM Books
WHERE published_year>1950;

--3.List all the customers from the Canada.
SELECT*FROM Customers
WHERE Country='Canada';

--4.Show orders placed in November 2023.
SELECT*FROM Orders
WHERE order_date BETWEEN '2023-11-01'AND '2023-11-30';

--5.Retrive the total stock of books available.
SELECT SUM(Stock) AS Total_Stock
FROM Books;

--6.Find the details of the most expensive book.
SELECT*FROM Books
ORDER BY Price DESC LIMIT 1;

--7.Show all the customers who orderd more than 1 quantity of a book
SELECT*FROM Orders
WHERE quantity>1;

--8.Retrive all Orders where the total amount exceeds $20
SELECT*FROM Orders
where total_amount>20;

--9.List all genres available in the books table
SELECT DISTINCT genre FROM Books;

--10.Find the book with the lowest stock
SELECT *from books order by stock limit 1;

--11.Calculate the total revenue generated from all orders
SELECT SUM(Total_amount) AS total_revenue from orders;

--ADVANCED QUESTIONS

--1.Retrive total number of books sold for each genre
SELECT b. genre,SUM(o.Quantity)AS total_book_sold
FROM Orders o
JOIN Books b ON o.book_id=b.book_id
GROUP BY b.Genre;

--2.Find the average price of books in the 'fantasy' genre:
SELECT AVG(price) AS Average_price
FROM Books
WHERE Genre='Fantasy';

--3.List customers who have placed atleast 2 orders:

SELECT customer_id, COUNT(order_id) AS Order_count
FROM orders
GROUP BY customer_id
Having COUNT (order_id)>=2;

--or(customer name)
SELECT o.customer_id,c.name,COUNT(o.order_id) AS order_count
FROM Orders o
JOIN Customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id,c.name
Having COUNT (o.order_id)>=2;

--4.Find the most frequently orderd book
SELECT book_id,COUNT(order_id)AS Order_count
FROM orders
GROUP BY book_id
Order by Order_count DESC LIMIT 1;

--or(Book name)
SELECT o.book_id,b.title,COUNT(o.order_id) AS Order_count
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id,b.title
ORDER BY Order_count DESC LIMIT 1;

--5.Show the top 3 expensive books of 'Fantasy':
SELECT * FROM Books
WHERE genre='Fantasy'
ORDER BY price DESC LIMIT 3;

--6. Retrive the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity) AS total_book_sold
FROM orders o
JOIN books b on O.book_id=b.book_id
GROUP BY b.author;

--7.List the cities where customers who spent over $30 are located:
SELECT  DISTINCT c.city,total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE total_amount>30;

--8. Find the customer who spent the most on orders:
SELECT c.customer_id,c.name,SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.name
ORDER BY total_spent DESC LIMIT 1;

--9.Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id,b.title,b.stock,COALESCE(SUM(o.quantity),0) AS order_quantity,
b.stock- COALESCE (SUM(o.quantity),0) AS Remaining_quantity
FROM books b
 LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;


