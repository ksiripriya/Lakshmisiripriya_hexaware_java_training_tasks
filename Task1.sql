-- Creating database
CREATE database Techshop;
USE Techshop;
-- customer table 
CREATE table Customers 
(
CustomerID int auto_increment primary key,
firstName varchar(30),
lastName varchar(30),
email varchar(30) not null,
phone varchar(12) not null,
address varchar(60)
);
-- product table 
CREATE table Products
(
ProductID int auto_increment primary key,
ProductName varchar(50),
Descriptionp text,
Price int
);
-- orders table
CREATE table Orders
(
OrderID int auto_increment primary key,
CustomerID int,
OrderDate date,
Totalamount int,

foreign key (CustomerID) references Customers(CustomerID)
);
-- orderdetails table
CREATE table Orderdetails
(
OrderdetailID int auto_increment primary key,
OrderID int,
CustomerID int,
Quantity int,
foreign key (CustomerID) references Customers(CustomerID)
);
-- Inventory table
CREATE table Inventory
(
InventoryID int auto_increment primary key,
ProductID int,
Quantityinstock int,
Laststockupdate date,
foreign key (ProductID) references Products(ProductID)
);
INSERT into Customers (firstname,lastname,email,phone,address)
values
('sai','ram','abc@gmail.com','9999999999','123st.'),
('sai','priya','def@gmail.com','9999999999','123st.'),
('srija','ram','ghi@gmail.com','9999999999','123st.'),
('krishna','ram','jkl@gmail.com','9999999999','123st.'),
('sai','teja','mno@gmail.com','9999999999','123st.'),
('vedic','ram','pqr@gmail.com','9999999999','123st.'),
('sai','surya','stu@gmail.com','9999999999','123st.'),
('sai','sri','vwx@gmail.com','9999999999','123st.'),
('abhi','ram','yz@gmail.com','9999999999','123st.'),
('ramu','raj','cba@gmail.com','9999999999','123st.');

INSERT into Products (ProductName, Descriptionp, Price)
Values
('Smartphone', 'Latest model', 699),
('Laptop', 'High-performance', 999),
('Tablet', 'Lightweight', 499),
('Headphones', 'Noise-cancelling', 199),
('Smartwatch', 'Track fitness', 249),
('Camera', 'Trending Tech', 22549),
('GamingConsole', 'Gaming experience', 499),
('Router', 'High-speed wireless connectivity', 99),
('Keyboard', 'RGB lighting', 149),
('Mouse', 'Gaming', 49);

INSERT into Orders (CustomerID, OrderDate, Totalamount)
values
(1, '2025-04-01', 1499),
(2, '2025-04-02', 699),
(3, '2025-04-03', 1249),
(4, '2025-04-04', 399),
(5, '2025-04-05', 1049),
(6, '2025-04-06', 499),
(7, '2025-04-07', 149),
(8, '2025-04-08', 1249),
(9, '2025-04-09', 699),
(10, '2025-04-10', 999);

INSERT into OrderDetails (OrderID, CustomerID, Quantity)
values 
(1, 1, 2),
(2, 3, 1),
(3, 6, 1),
(4, 4, 2),
(5, 2, 1),
(6, 8, 1),
(7, 10, 2),
(8, 9, 1),
(9, 5, 1),
(10, 7, 1);

INSERT into Inventory (ProductID, Quantityinstock, Laststockupdate)
values 
(1, 50, '2025-04-01'),
(2, 40, '2025-04-01'),
(3, 30, '2025-04-01'),
(4, 60, '2025-04-01'),
(5, 70, '2025-04-01'),
(6, 20, '2025-04-01'),
(7, 25, '2025-04-01'),
(8, 80, '2025-04-01'),
(9, 55, '2025-04-01'),
(10, 100, '2025-04-01');

select * from customers;
select * from Products;
select * from Orders;
select * from OrderDetails;
select * from Inventory;
 use classicmodels;











