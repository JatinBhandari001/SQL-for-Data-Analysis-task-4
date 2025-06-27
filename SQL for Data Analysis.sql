create table book(
book_id int(3) primary key,
tittle varchar(100),
author varchar(100),
genre varchar(200),
published_year int(4),
price numeric(10,2),
stock int(2)); 

create table customer(
customer_id int(3) primary key,
customer_name varchar(100),
email varchar(100) unique,
phone numeric(15),
city varchar(100),
country varchar(100));

Create table orders(
order_id int(3) primary key,
customer_id int(3) references customer(customer_id),
book_id int(3) references book(book_id),
order_date date,
quantity int(3),
amount numeric(10,2));

##data imported through import wizard

select * from book;
select * from customer;
select * from orders;

## retrieve all books in the fiction genre.
select * from book
where genre='fiction';

## Find the book with the lowest stock 
select * from book
order by stock 
limit 5;

## calculate the total revenue generated from all order
select sum(amount) as total_revenune
from orders;

## Retrieve the total number of book sold for each genre
select book.genre, sum(orders.quantity)
as Total_book_sold
from orders
join book on orders.book_id = book.book_id
group by genre;

## Find the average price of book in the fantasy genre
select avg(price) as Fantasy_book
from book
where genre="fantasy";

# Find the customer who spend the most on the orders
select customer.customer_id, customer.customer_name, sum(orders.amount) as total_spend
from orders
join customer on orders.customer_id = customer.customer_id
group by customer.customer_id, customer.customer_name
order by total_spend desc limit 1;

#Calculate the stock remaining after all the orders
select book.book_id, book.title, coalesce(sum(orders.quantity),0) as order_quantity,
 book.title-coalesce(sum(orders.quantity),0) as Remaining_stock
from book
left join orders on book.book_id=orders.book_id
group by book.book_id
order by book.book_id;

## List the cities where customer who spent over $30 are located
select distinct customer.city , orders.amount
from orders
join customer on orders.customer_id = customer.customer_id
where orders.amount>30;

## Show order placed in Nov 2023
select * from orders
where order_date between "2023-11-01" and "2023-11-30";

##Views 
Create view TopBooksView AS
select  
    b.book_id, b.title, b.genre,SUM(o.Quantity) AS UnitsSold,
    SUM(o.Quantity * b.price) AS TotalRevenue
From orders o
Join book b ON o.book_id = b.book_id
GROUP BY b.book_id, b.title, b.genre
ORDER BY UnitsSold DESC;
Select * from TopBooksView;

Create view Lowstockbookview AS
Select book_id,title,stock
From book
where Stock < 10;
Select * from Lowstockbookview;

##index 
Create index idx_orders_bookid on orders(book_id);
select * from orders where book_id = 102;

#########################################################







