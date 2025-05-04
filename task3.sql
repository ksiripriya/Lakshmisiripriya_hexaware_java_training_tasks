CREATE DATABASE HMBank;
USE HMBank;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15) UNIQUE,
    address VARCHAR(255)
);

CREATE TABLE Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    account_type ENUM('Savings', 'Current', 'Zero_Balance') NOT NULL,
    balance DECIMAL(10,2) DEFAULT 0,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    transaction_type ENUM('Deposit', 'Withdrawal', 'Transfer') NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_account FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE CASCADE
);

INSERT INTO Customers (first_name, last_name, dob, email, phone_number, address) VALUES
('John', 'Doe', '1985-07-15', 'john.doe@email.com', '9876543210', 'New York'),
('Alice', 'Smith', '1990-04-10', 'alice.smith@email.com', '8765432109', 'Los Angeles'),
('Bob', 'Johnson', '1978-12-22', 'bob.johnson@email.com', '7654321098', 'Chicago'),
('Emma', 'Brown', '1995-03-05', 'emma.brown@email.com', '6543210987', 'Houston'),
('Michael', 'Davis', '1982-09-30', 'michael.davis@email.com', '5432109876', 'Phoenix'),
('Sophia', 'Wilson', '1998-06-17', 'sophia.wilson@email.com', '4321098765', 'Philadelphia'),
('Daniel', 'Martinez', '1987-01-25', 'daniel.martinez@email.com', '3210987654', 'San Antonio'),
('Olivia', 'Taylor', '1993-08-12', 'olivia.taylor@email.com', '2109876543', 'San Diego'),
('James', 'Anderson', '1980-11-07', 'james.anderson@email.com', '1098765432', 'Dallas'),
('Emily', 'Thomas', '1989-05-29', 'emily.thomas@email.com', '9988776655', 'San Jose');

INSERT INTO Accounts (customer_id, account_type, balance) VALUES
(1, 'Savings', 5000),
(2, 'Current', 12000),
(3, 'Savings', 8000),
(4, 'Current', 4500),
(5, 'Zero_Balance', 0),
(6, 'Savings', 15000),
(7, 'Current', 2500),
(8, 'Zero_Balance', 0),
(9, 'Savings', 10000),
(10, 'Current', 3000);

INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date) VALUES
(1, 'Deposit', 1000, '2025-04-01'),
(2, 'Withdrawal', 500, '2025-04-02'),
(3, 'Deposit', 2000, '2025-04-03'),
(4, 'Withdrawal', 300, '2025-04-04'),
(5, 'Deposit', 5000, '2025-04-05'),
(6, 'Withdrawal', 700, '2025-04-06'),
(7, 'Deposit', 4000, '2025-04-07'),
(8, 'Withdrawal', 600, '2025-04-08'),
(9, 'Deposit', 3000, '2025-04-09'),
(10, 'Withdrawal', 800, '2025-04-10');

select * from Transactions;

select avg(balance) as Average_bal from Accounts;

select account_id,customer_id,balance,account_type 
from Accounts
order by balance desc
limit 10;

select c.customer_id,c.first_name,c.last_name,sum(t.amount) 
from Customers c inner join Accounts a on c.customer_id = a.customer_id
inner join Transactions t on a.account_id = t.account_id
where t.transaction_date = "2025-04-05"
group by c.customer_id,c.first_name,c.last_name;

SELECT customer_id, first_name, last_name, dob AS oldest_customer
FROM Customers
WHERE dob = (SELECT MIN(dob) FROM Customers);

SELECT customer_id, first_name, last_name, dob AS newest_customer
FROM Customers
WHERE dob = (SELECT MAX(dob) FROM Customers);
-- Write a SQL query to Retrieve transaction details along with the account type.
select t.transaction_type, t.amount, t.transaction_date,a.account_id,a.account_type 
from Transactions t inner join Accounts a on t.account_id = a.account_id;

-- Write a SQL query to Get a list of customers along with their account details
select c.customer_id,c.first_name,c.last_name,a.account_type,a.balance 
from Customers c inner join Accounts a on c.customer_id = a.customer_id;

-- Write a SQL query to Retrieve transaction details along with customer information for a
-- specific account.
select a.account_type,t.transaction_type, t.amount, t.transaction_date, concat(c.first_name,' ',c.last_name) as customer_name,c.customer_id
from Transactions t inner join Accounts a on t.account_id = a.account_id
inner join Customers c on a.customer_id = c.customer_id
where a.account_type = "Savings"
group by account_type,t.transaction_type, t.amount, t.transaction_date,customer_name,c.customer_id;

-- Write a SQL query to Identify customers who have more than one account.
select c.customer_id,c.first_name,count(a.account_id) as total_acc
from Customers c inner join Accounts a on c.customer_id = a.customer_id 
group by c.customer_id,c.first_name
having count(a.account_id) > 1;













