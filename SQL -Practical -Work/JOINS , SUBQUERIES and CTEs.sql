
------ JOINS -------
CREATE DATABASE ecommerce_db; 
USE ecommerce_db; 
 
CREATE TABLE Customers ( 
    customer_id INT PRIMARY KEY, 
    customer_name VARCHAR(100), 
    email VARCHAR(100), 
    phone VARCHAR(15), 
    city VARCHAR(50) 
); 
 
CREATE TABLE Categories ( 
    category_id INT PRIMARY KEY, 
    category_name VARCHAR(100) 
); 
 
CREATE TABLE Suppliers ( 
    supplier_id INT PRIMARY KEY, 
    supplier_name VARCHAR(100), 
    phone VARCHAR(15), 
    city VARCHAR(50) 
); 
 
CREATE TABLE Products ( 
    product_id INT PRIMARY KEY, 
    product_name VARCHAR(100), 
    category_id INT, 
    supplier_id INT, 
    price DECIMAL(10,2), 
    FOREIGN KEY (category_id) REFERENCES Categories(category_id), 
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) 
); 
 
 
CREATE TABLE Employees ( 
    employee_id INT PRIMARY KEY, 
    employee_name VARCHAR(100), 
    job_title VARCHAR(50) 
); 
 
CREATE TABLE Shippers ( 
    shipper_id INT PRIMARY KEY, 
    shipper_name VARCHAR(100), 
    phone VARCHAR(15) 
); 
 
CREATE TABLE Orders ( 
    order_id INT PRIMARY KEY, 
    customer_id INT, 
    employee_id INT, 
    shipper_id INT, 
    order_date DATE, 
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id), 
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id), 
    FOREIGN KEY (shipper_id) REFERENCES Shippers(shipper_id) 
); 
 
CREATE TABLE Order_Items ( 
    order_item_id INT PRIMARY KEY, 
    order_id INT, 
    product_id INT, 
    quantity INT, 
    FOREIGN KEY (order_id) REFERENCES Orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES Products(product_id) 
); 
 
----------- inserting values----------- 
INSERT INTO Customers VALUES 
(1,'Arun','arun@gmail.com','9876543210','Chennai'), 
(2,'bala','bala@gmail.com','9876543211','Coimbatore'), 
(3,'Divya','divya@gmail.com','9876543212','Madurai'), 
(4,'Keerthi','keerthi@gmail.com','9876543213','Salem'), 
(5,'Rahul','rahul@gmail.com','9876543214','Trichy'); 
 
INSERT INTO Categories VALUES 
(1,'Electronics'), 
(2,'Clothing'), 
(3,'Books'), 
(4,'Home Appliances'), 
(5,'Sports'); 
 
INSERT INTO Suppliers VALUES 
(1,'ABC Suppliers','9000000001','Chennai'), 
(2,'XYZ Traders','9000000002','Coimbatore'), 
(3,'Prime Distributors','9000000003','Madurai'), 
(4,'Best Supply','9000000004','Salem'), 
(5,'Global Traders','9000000005','Trichy'); 
 
INSERT INTO Products VALUES 
(1,'Laptop',1,1,55000), 
(2,'Mobile',1,2,25000), 
(3,'T-Shirt',2,3,800), 
(4,'Novel',3,4,500), 
(5,'Mixer',4,5,3500), 
(6,'Football',5,1,1200), 
(7,'Headphones',1,2,2000), 
(8,'Jeans',2,3,1500); 
 
INSERT INTO Employees VALUES 
(1,'Kumar','Manager'), 
(2,'Priya','Sales Executive'), 
(3,'Suresh','Sales Executive'), 
(4,'Anitha','Manager'), 
(5,'Vijay','Sales Executive'); 
 
INSERT INTO Shippers VALUES 
(1,'BlueDart','8888881111'), 
(2,'DTDC','8888882222'), 
(3,'Delhivery','8888883333'), 
(4,'India Post','8888884444'), 
(5,'XpressBees','8888885555'); 
 
INSERT INTO Orders VALUES 
(101,1,1,1,'2026-01-10'), 
(102,2,2,2,'2026-01-12'), 
(103,3,3,3,'2026-02-05'), 
(104,1,2,4,'2026-02-15'), 
(105,4,4,5,'2026-03-01'), 
(106,5,5,1,'2026-03-10'), 
(107,2,3,2,'2026-04-08'), 
(108,3,1,3,'2026-05-18'); 
 
INSERT INTO Order_Items VALUES 
(1,101,1,1), 
(2,101,7,2), 
(3,102,2,1), 
(4,102,3,3), 
(5,103,4,2), 
(6,103,6,1), 
(7,104,5,1), 
(8,104,8,2), 
(9,105,2,2), 
(10,105,6,1), 
(11,106,1,1), 
(12,106,3,4), 
(13,107,7,3), 
(14,107,8,2), 
(15,108,5,1), 
(16,108,4,5); 
 
------------ display all customers with orders---------- 
SELECT c.customer_name ,o. order_id 
from customers c 
LEFT JOIN orders o ON c.customer_id =o.customer_id; 
 
---------- display orders details with customer name---------- 
SELECT c.customer_name, o.* 
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id; 
 
---------- show every product with its category--------- 
SELECT p.product_id, p.product_name, c.category_id , c.category_name 
FROM products p 
JOIN categories c ON c.category_id = p.category_id; 
 
---------- display product with suplier name--------- 
SELECT s.supplier_name , p.* 
FROM suppliers s 
JOIN products p ON s.supplier_id =p.supplier_id; 
 
----------- show orders handled by each employee-------- 
SELECT e.employee_id , e.employee_name, o.order_id 
FROM employees e 
JOIN orders o ON e.employee_id = e.employee_id; 
 
-------- display orders with shippers name-------- 
SELECT s.shipper_name, o.order_id  
FrOM shippers s 
JOIN orders o ON s.shipper_id = o.shipper_id; 
 
---------- show customers who place atleast one order---------- 
SELECT c.customer_name, c.customer_id ,o.order_id 
FROM customers c 
INNER JOIN orders o ON o.customer_id = c.customer_id; 
 
--------- display products purchase in each order------- 
SELECT p.product_name, p.product_id ,o.order_id 
FROM products p 
JOIN order_items ot ON ot.product_id =p.product_id 
JOIN orders o ON ot.order_id = o.order_id; 
 
----------- display product name and quantity ordered---------- 
SELECT p.product_name ,p.product_id , SUM(ot.quantity) 
FROM products p 
JOIN order_items ot ON ot.product_id = p.product_id 
GROUP BY p.product_name, product_id ; 
 
------------- display employee names with customer names--------- 
SELECT e.employee_name , c.customer_name 
FROM customers c 
JOIN orders o ON o.customer_id = c.customer_id 
JOIN employees e ON o.employee_id = e.employee_id; 
 
------------- display orders, customers product, quantity and price---------- 
SELECT c.customer_name, o.order_id, p.product_name, ot.quantity, p.price 
FROM products p 
JOIN  order_items ot ON ot.product_id = p.product_id 
JOIN orders o ON o.order_id = ot.order_id 
JOIN customers c ON o.customer_id = c.customer_id; 
 
---------- display suppliers name with products sold--------- 
SELECT s.supplier_name, p.product_name 
FROM Suppliers s 
JOIN Products p ON s.supplier_id = p.supplier_id; 
 
---------- display category-wise product count--------- 
SELECT  c.category_name , COUNT(*) 
FROM products p 
JOIN categories c ON c.category_id = p.category_id 
GROUP BY c.category_name; 
 
------------- find total orders for each customers------- 
SELECT c.customer_name , COUNT(*) 
FROM orders o 
JOIN customers c ON c.customer_id = o.customer_id 
GROUP BY c.customer_id; 
 
---------- find total sales by employee----- 
SELECT e.employee_name, SUM(p.price * ot.quantity) AS total_sales 
FROM Employees e 
JOIN Orders o ON e.employee_id = o.employee_id 
JOIN Order_Items ot ON o.order_id = ot.order_id 
JOIN Products p ON ot.product_id = p.product_id 
GROUP BY e.employee_id; 
 
---------- find total revenue by category------ 
SELECT c.category_name, SUM(p.price * oi.quantity) AS total_revenue 
FROM categories c 
JOIN products p ON p.category_id = c.category_id 
JOIN order_items oi ON oi.product_id = p.product_id 
GROUP BY category_name; 
 
------------ display most expensive product in every category------- 
SELECT c.category_name, p.product_name, p.price 
FROM Products p 
JOIN Categories c ON p.category_id = c.category_id 
WHERE p.price = (SELECT MAX(price) FROM Products 
    WHERE category_id = p.category_id 
); 
 
------------ find products that never ordered--------- 
SELECT p.product_id, p.product_name 
FROM Products p 
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id 
WHERE oi.product_id IS NULL; 
 
------------ find customers who never place orders--------- 
SELECT c.customer_id , c.customer_name 
FROM customers c 
LEFT JOIN orders o ON o.customer_id = c.customer_id 
WHERE o.order_id IS NULL; 
 
----------- display suppliers without products------- 
SELECT s.supplier_name  
FROM suppliers s 
 LEFT JOIN products p ON p.supplier_id = s.supplier_id 
 WHERE p.supplier_id IS NULL; 
 
----------- find top five customers by spending------ 
SELECT c.customer_name, SUM(p.price * oi.quantity) AS total_spending 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
JOIN Order_Items oi ON o.order_id = oi.order_id 
JOIN Products p ON oi.product_id = p.product_id 
GROUP BY c.customer_id 
ORDER BY total_spending DESC LIMIT 5; 
 
---------- display monthly sales by employee----- 
SELECT e.employee_name, MONTH(o.order_date) , SUM(p.price * oi.quantity) AS monthly_sales 
FROM Employees e 
JOIN Orders o ON e.employee_id = o.employee_id 
JOIN Order_Items oi ON o.order_id = oi.order_id 
JOIN Products p ON oi.product_id = p.product_id 
GROUP BY e.employee_name,MONTH(o.order_date); 
 
------------ find best selling products---------- 
SELECT p.product_name, SUM(oi.quantity) AS total_sold 
FROM Products p 
JOIN Order_Items oi ON p.product_id = oi.product_id 
GROUP BY p.product_id 
ORDER BY total_sold DESC; 
 
----------- find average order value per customer------- 
SELECT c.customer_name, AVG(p.price * oi.quantity) AS avg_order_value 
FROM Customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
JOIN Order_Items oi ON o.order_id = oi.order_id 
JOIN Products p ON oi.product_id = p.product_id 
GROUP BY c.customer_id; 
 
--------- find orders with more than three products----- 
SELECT p.product_name, COUNT(oi.order_id) AS total_orders 
FROM Products p 
JOIN Order_Items oi ON p.product_id = oi.product_id 
GROUP BY p.product_id 
HAVING COUNT(oi.order_id) > 3; 
 
----------- find customers ordering from multiple categories------------ 
SELECT c.customer_name, COUNT(DISTINCT p.category_id) AS total_categories 
FROM Customers c  
JOIN Orders o ON c.customer_id = o.customer_id 
JOIN Order_Items oi ON o.order_id = oi.order_id 
JOIN Products p ON oi.product_id = p.product_id 
GROUP BY c.customer_id 
HAVING COUNT(DISTINCT p.category_id) > 1; 
 
----------- display categories with no sales--- 
SELECT c.category_name 
FROM Categories c 
LEFT JOIN Products p ON c.category_id = p.category_id 
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id 
WHERE oi.product_id IS NULL; 
 
----------- display the highest value order------- 
SELECT o.order_id, MAX(p.price * oi.quantity) AS highest_value 
FROM order_items oi 
JOIN orders o ON oi.order_id = o.order_id 
JOIN  products p ON oi.product_id = p.product_id 
GROUP BY o.order_id 
ORDER BY highest_value DESC LIMIT 1; 
 
---------- generate complete invoice using all tables------ 
SELECT o.order_id, o.order_date, c.customer_name, e.employee_name, s.shipper_name, p.product_name, 
cat.category_name,sup.supplier_name, 
oi.quantity, p.price, (oi.quantity * p.price) AS total_amount 
FROM Orders o  
JOIN Customers c ON o.customer_id = c.customer_id 
JOIN Employees e ON o.employee_id = e.employee_id 
JOIN Shippers s ON o.shipper_id = s.shipper_id 
JOIN Order_Items oi ON o.order_id = oi.order_id 
JOIN Products p ON oi.product_id = p.product_id 
JOIN Categories cat ON p.category_id = cat.category_id 
JOIN Suppliers sup ON p.supplier_id = sup.supplier_id; 
 
---------- SUBQURIES---------- 
CREATE DATABASE banking_db; 
USE banking_db; 
 
--------- creating table------------ 
CREATE TABLE Branches ( 
    branch_id VARCHAR(10) PRIMARY KEY, 
    branch_name VARCHAR(100), 
    city VARCHAR(50) 
); 
 
CREATE TABLE Customers ( 
    customer_id VARCHAR(10) PRIMARY KEY, 
    customer_name VARCHAR(100), 
    city VARCHAR(50) 
); 
 
CREATE TABLE Accounts ( 
    account_no VARCHAR(10) PRIMARY KEY, 
    customer_id VARCHAR(10), 
    branch_id VARCHAR(10), 
    account_type VARCHAR(20), 
    balance DECIMAL(12,2), 
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id), 
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) 
); 
 
CREATE TABLE Transactions ( 
    transaction_id VARCHAR(10) PRIMARY KEY, 
    account_no VARCHAR(10), 
    transaction_type VARCHAR(20), 
    amount DECIMAL(12,2), 
    transaction_date DATE, 
    FOREIGN KEY (account_no) REFERENCES Accounts(account_no) 
); 
 
CREATE TABLE Loans ( 
    loan_id VARCHAR(10) PRIMARY KEY, 
    customer_id VARCHAR(10), 
    loan_type VARCHAR(50), 
    loan_amount DECIMAL(12,2), 
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) 
); 
 
CREATE TABLE Loan_Payments ( 
    payment_id VARCHAR(10) PRIMARY KEY, 
    loan_id VARCHAR(10), 
    payment_amount DECIMAL(12,2), 
    payment_date DATE, 
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id) 
); 
 
--------- inserting values ---------- 
INSERT INTO Branches VALUES 
('BR001','Chennai Main','Chennai'), 
('BR002','Anna Nagar','Chennai'), 
('BR003','Bangalore Central','Bangalore'), 
('BR004','Hyderabad City','Hyderabad'), 
('BR005','Mumbai West','Mumbai'); 
 
INSERT INTO Customers VALUES 
('CUS001','Ahmed','Chennai'), 
('CUS002','John','Bangalore'), 
('CUS003','Sarah','Hyderabad'), 
('CUS004','David','Mumbai'), 
('CUS005','Priya','Chennai'), 
('CUS006','Rahul','Coimbatore'), 
('CUS007','Fatima','Delhi'), 
('CUS008','Meena','Salem'), 
('CUS009','Kumar','Madurai'), 
('CUS010','Anita','Pune'), 
('CUS011','Ravi','Trichy'), 
('CUS012','Ayesha','Kochi'); 
 
INSERT INTO Accounts VALUES 
('ACC1001','CUS001','BR001','Savings',85000), 
('ACC1002','CUS002','BR003','Savings',45000), 
('ACC1003','CUS003','BR004','Current',120000), 
('ACC1004','CUS004','BR005','Savings',65000), 
('ACC1005','CUS005','BR002','Savings',98000), 
('ACC1006','CUS006','BR001','Current',150000), 
('ACC1007','CUS007','BR004','Savings',40000), 
('ACC1008','CUS008','BR001','Savings',76000), 
('ACC1009','CUS009','BR002','Current',110000), 
('ACC1010','CUS010','BR003','Savings',53000), 
('ACC1011','CUS011','BR005','Savings',30000), 
('ACC1012','CUS012','BR004','Current',170000); 
 
INSERT INTO Transactions VALUES 
('TX001','ACC1001','Deposit',10000,'2025-01-02'), 
('TX002','ACC1001','Withdrawal',5000,'2025-01-05'), 
('TX003','ACC1002','Deposit',20000,'2025-01-07'), 
('TX004','ACC1003','Withdrawal',15000,'2025-01-10'), 
('TX005','ACC1004','Deposit',8000,'2025-01-12'), 
('TX006','ACC1005','Withdrawal',3000,'2025-01-15'), 
('TX007','ACC1006','Deposit',25000,'2025-01-18'), 
('TX008','ACC1007','Deposit',12000,'2025-01-20'), 
('TX009','ACC1008','Withdrawal',7000,'2025-01-22'), 
('TX010','ACC1009','Deposit',50000,'2025-01-25'); 
 
INSERT INTO Loans VALUES 
('LN001','CUS001','Home Loan',2500000), 
('LN002','CUS003','Car Loan',800000), 
('LN003','CUS005','Education Loan',600000), 
('LN004','CUS007','Personal Loan',300000), 
('LN005','CUS010','Business Loan',1500000), 
('LN006','CUS012','Home Loan',3200000); 
 
INSERT INTO Loan_Payments VALUES 
('PAY001','LN001',50000,'2025-01-15'), 
('PAY002','LN001',50000,'2025-02-15'), 
('PAY003','LN002',25000,'2025-01-20'), 
('PAY004','LN003',20000,'2025-01-25'), 
('PAY005','LN004',15000,'2025-01-28'), 
('PAY006','LN005',60000,'2025-02-02'), 
('PAY007','LN006',70000,'2025-02-05'), 
('PAY008','LN006',70000,'2025-03-05'); 
 
----------- customer wih highest account balance---------- 
SELECT c.customer_name , a.balance 
FROM accounts a 
JOIN customers c ON a.customer_id = c.customer_id 
WHERE a.balance = (SELECT MAX(balance) FROM accounts); 
 
-------- account with minimum balance------ 
SELECT * FROM accounts 
WHERE balance = (SELECT MIN(balance) FROM accounts); 
 
-------- find customer whose balance is greater than average balance--------- 
SELECT c.customer_name, a.balance 
FROM accounts a 
JOIN customers c ON a.customer_id = c.customer_id 
WHERE a.balance > (SELECT AVG(balance) FROM accounts); 
 
--------- find customers whose balace is less than maximum balance------- 
SELECT c.customer_name, a.balance 
FROM accounts a 
JOIN customers c ON a.customer_id = c.customer_id 
WHERE a.balance < (SELECT MAX(balance) FROM accounts); 
 
---------- display account(s) having second highest balance --------- 
SELECT * FROM accounts 
WHERE balance = (SELECT MAX(balance) FROM accounts  
WHERE balance < (SELECT MAX(balance) FROM accounts) 
 ); 
 
----------- find customers who have taken a loan------- 
SELECT customer_id , customer_name 
FROM customers  
WHERE customer_id IN (SELECT customer_id FROM loans); 
 
----------- find customers who have not  taken a loan------- 
SELECT customer_id , customer_name 
FROM customers  
WHERE customer_id  NOT IN (SELECT customer_id FROM loans); 
 
--------  find accounts beloging to chennai branch--------- 
SELECT account_no , branch_id 
FROM accounts  
WHERE branch_id  IN  (select branch_id  FROM branches WHERE city = 'chennai'); 
 
--------  find customers whose accounts are in chennai branch--------- 
SELECT customer_id,account_no , branch_id 
FROM accounts 
WHERE branch_id IN (SELECT branch_id FROM branches WHERE city='chennai'); 
 
------ display customers who have transaction greater than 20,000 ---- 
SELECT c.customer_name, t.amount 
FROM transactions t 
JOIN accounts a ON t.account_no = a.account_no 
JOIN customers c ON a.customer_id = c.customer_id 
WHERE t.amount > 20000; 
 
----------- find customers whose balance is higher than the average balance of their branch--------- 
SELECT customer_id ,balance, branch_id 
FROM accounts 
WHERE balance > (SELECT AVG(balance) FROM accounts); 
 
-------- find branch with more accounts than the average branch------ 
SELECT branch_id , COUNT(*)AS total_acccount 
FROM accounts 
GROUP BY branch_id 
HAVING COUNT(*) > (SELECT AVG(account_count) 
 FROM ( SELECT COUNT(*) AS account_count FROM accounts 
 GROUP BY branch_id ) 
 AS avg_branch ); 
  
 ---------- find customers whose total transaction amount that exceeds their current balance---------- 
 SELECT customer_id , account_no , balance 
 FROM accounts 
 WHERE balance <( SELECT SUM(balance) FROM transactions 
 WHERE transactions.account_no = accounts.account_no); 
  
 ---------- display accounts with more transaction than the average accounts----------- 
 SELECT account_no, COUNT(*) FROM transactions 
 GROUP BY account_no 
 HAVING COUNT(*) > ( SELECT AVG(transaction_count)  
 FROM (SELECT COUNT(*) AS transaction_count FROM transactions 
 GROUP BY account_no ) 
AS  transactions); 
 
------- find the loan payments above the average payment for the same loan---------- 
SELECT * from loan_payments lp 
WHERE payment_amount >(SELECT AVG(payment_amount) FROM loan_payments 
WHERE loan_id = lp.loan_id); 
 
----------- find the customer who have transaction------- 
SELECT * FROM Customers c 
WHERE EXISTS (SELECT * FROM accounts a, transactions t 
WHERE a.customer_id =c.customer_id 
AND a.account_no = t.account_no); 
 
--------- find customers with no transaction----- 
SELECT * FROM Customers c 
WHERE  NOT EXISTS (SELECT * FROM accounts a, transactions t 
WHERE a.customer_id =c.customer_id 
AND a.account_no = t.account_no); 
 
---------- find branches with atleast one account---- 
SELECT branch_id FROM branches b 
WHERE EXISTS( SELECT 1 FROM accounts a 
WHERE b.branch_id = a.branch_id ); 
 
----------- find branches with no accounts------- 
SELECT branch_id FROM branches b 
WHERE NOT EXISTS( SELECT * FROM accounts a 
WHERE b.branch_id = a.branch_id ); 
 
--------- find loans that have received atleast one payment------ 
SELECT loan_id FROM loans l 
WHERE EXISTS (SELECT 1 FROM loan_payments lp 
WHERE l.loan_id = lp.loan_id); 
 
----------- find customers in chennai branch using IN------ 
SELECT customer_id , branch_id FROM accounts a 
WHERE branch_id IN (SELECT branch_id FROM branches  
WHERE city ='chennai') ; 
 
---------- find customers not having loan using NOT IN----------- 
SELECT customer_id FROM customers 
WHERE customer_id  NOT IN (SELECT customer_id FROM loans); 
 
--------- find account balances greater than any account in mumbai--------- 
SELECT * FROM accounts 
WHERE balance > ANY (SELECT  balance FROM accounts 
WHERE branch_id IN (SELECT branch_id FROM branches WHERE city ='chennai') 
); 
 
--------- find account balance greater than all savings account----- 
SELECT * FROM accounts 
WHERE balance > ALL( SELECT balance FROM accounts WHERE account_type = 'savings'); 
 
-------- find accounts whose  average balance exceeds all branch  averages--------- 
SELECT branch_id ,  AVG(balance) FROM accounts 
GROUP BY branch_id 
HAVING AVG(balance) > ALL (select AVG(balance) FROM accounts 
GROUP BY branch_id ); 
 
--------- find customer with the highest total transaction amount----- 
SELECT customer_id , customer_name FROM customers  
WHERE customer_id = (SELECT a.customer_id FROM accounts a 
JOIN transactions t ON a.account_no = t.account_no 
GROUP BY a.customer_id  
ORDER BY SUM(t.amount) DESC 
LIMIT 1); 
 
-------- find customer who have both account and loans----------- 
SELECT * FROM customers  
WHERE customer_id IN (SELECT customer_id FROM accounts ) 
AND customer_id IN (SELECT customer_id FROM loans); 
 
---------- display branch with highest total deposits------ 
SELECT branch_id FROM accounts  
WHERE branch_id =( SELECT a.branch_id FROM accounts a  
JOIN transactions t ON t.account_no = a.account_no 
WHERE t.transaction_type ='deposit' 
GROUP BY branch_id  
ORDER BY SUM(t.amount) DESC LIMIT 1); 
 
----- find customers whose loan amount is greater than the average loan amount------------ 
SELECT customer_id ,loan_amount 
FROM loans 
WHERE loan_amount  >(SELECT AVG(loan_amount) FROM loans); 
 
------ generate customer banking report using subqueries---- 
SELECT customer_id, customer_name, 
(SELECT COUNT(*) FROM Accounts a 
WHERE a.customer_id = c.customer_id) AS total_accounts, 
(SELECT IFNULL(SUM(balance),0) FROM Accounts a 
WHERE a.customer_id = c.customer_id) AS total_balance, 
(SELECT COUNT(*) FROM Loans l 
WHERE l.customer_id = c.customer_id) AS total_loans 
FROM Customers c; 
 
 ------ JOINS, SUBQUERIES, CTEs---------- 
CREATE DATABASE hospital_db; 
USE hospital_db; 
 
-------- Creating TABLES -------- 
CREATE TABLE departments( 
department_id VARCHAR(15) PRIMARY KEY, 
department_name VARCHAR(50) 
); 
 
CREATE TABLE Doctors( 
Doctor_id VARCHAR(15) PRIMARY KEY, 
doctor_name VARCHAR(50), 
department_id VARCHAR(15), 
specialization VARCHAR(50), 
FOREIGN KEY (department_id) REFERENCES departments (department_id) 
); 
 
CREATE TABLE patients( 
patient_id VARCHAR(15) PRIMARY KEY, 
patient_name VARCHAR(50), 
gender VARCHAR(10), 
city VARCHAR(50), 
age int 
); 
 
CREATE TABLE Appointments( 
appointment_id VARCHAR(15) PRIMARY KEY, 
patient_id VARCHAR(15), 
doctor_id VARCHAR(15), 
appointment_date DATE, 
FOREIGN KEY (patient_id) REFERENCES patients(patient_id), 
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)  
); 
 
CREATE TABLE treatments( 
treatment_id VARCHAR(15) PRIMARY KEY, 
appointment_id VARCHAR(15), 
treatment_name VARCHAR(15), 
cost int, 
FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) 
); 
 
CREATE TABLE medicines( 
medicine_id  VARCHAR(15) PRIMARY KEY, 
medicine_name VARCHAR(50), 
price int 
); 
 
CREATE TABLE prescriptions( 
prescription_id VARCHAR(15) PRIMARY KEY, 
appointment_id  VARCHAR(15), 
medicine_id VARCHAR(15), 
quantity INT, 
FOREIGN KEY(appointment_id) REFERENCES appointments(appointment_id), 
FOREIGN KEY(medicine_id) REFERENCES medicines(medicine_id) 
); 
 
CREATE TABLE billing( 
bill_id VARCHAR(15) PRIMARY KEY, 
appointment_id VARCHAR(15), 
total_amount INT, 
payment_status VARCHAR(30), 
FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) 
); 
 
-----------  INSERTING VALUES --------------- 
INSERT INTO departments VALUES 
('DEP01', 'Cardiology'), 
('DEP02', 'Neurology'), 
('DEP03', 'Orthopedics'), 
('DEP04', 'General medicine'), 
('DEP05', 'Pediatrics'); 
 
INSERT INTO doctors VALUES 
('DOC001', 'Dr.Arun', 'DEP01', 'Cardiologist'), 
('DOC002', 'Dr.Priya', 'DEP02', 'Neurologist'), 
('DOC003', 'Dr.David', 'DEP03', 'Orthopedic'), 
('DOC004', 'Dr.Meena', 'DEP04', 'Geeral physician'), 
('DOC005', 'Dr.Ahmed', 'DEP05', 'pediatrician'); 
 
INSERT INTO  patients VALUES 
('PAT001', 'john', 'male', 'Chennai', 35), 
('PAT002', 'Sarah', 'female', 'Hyderabad', 28), 
('PAT003', 'David', 'male', 'Mumbai', 45), 
('PAT004', 'Fatima', 'female', 'Chennai', 30), 
('PAT005', 'Rahul', 'male', 'Bangalore', 40), 
('PAT006', 'Anita', 'female', 'Delhi', 32), 
('PAT007', 'Kumar', 'male', 'Coimbatore', 29), 
('PAT008', 'Priya', 'female', 'Salem', 26), 
('PAT009', 'Ravi', 'male', 'Madurai', 38), 
('PAT010', 'Ayesha', 'female', 'Kochi', 34); 
 
INSERT INTO appointments VALUES 
('APP001', 'PAT001', 'DOC001', '2025-01-10'), 
('APP002', 'PAT002', 'DOC002', '2025-01-11'), 
('APP003', 'PAT003','DOC003', '2025-01-12'), 
('APP004', 'PAT004', 'DOC004', '2025-01-13'), 
('APP005', 'PAT005', 'DOC001', '2025-01-15'), 
('APP006', 'PAT006', 'DOC005', '2025-01-18'), 
('APP007', 'PAT007', 'DOC004', '2025-01-20'), 
('APP008', 'PAT008', 'DOC003', '2025-01-22'); 
 
INSERT INTO treatments VALUES 
('TR001', 'APP001', 'ECG', 2500), 
('TR002', 'APP002', 'Brain Scan', 8000), 
('TR003', 'APP003', 'Bone surgery', 55000), 
('TR004', 'APP004', 'General Checkup', 1200), 
('TR005', 'APP005', 'Heart Scan', 6000), 
('TR006', 'APP006', 'Vaccination', 1500), 
('TR007', 'APP007', 'Blood Test', 900), 
('TR008', 'APP008', 'X-Ray', 1800); 
 
INSERT INTO Medicines VALUES 
('MED001', 'Paracetamol', 50), 
('MED002', 'Amoxicillin', 120), 
('MED003', 'Vitamin C', 80), 
('MED004', 'Ibuprofen', 100), 
('MED005', 'Insulin', 500); 
 
INSERT INTO Prescriptions VALUES 
('PRE001', 'APP001', 'MED001', 10), 
('PRE002', 'APP002', 'MED002', 7), 
('PRE003', 'APP003', 'MED004', 15), 
('PRE004', 'APP004', 'MED003', 12), 
('PRE005', 'APP005', 'MED005', 5), 
('PRE006', 'APP006', 'MED001', 8), 
('PRE007', 'APP007', 'MED003', 6), 
('PRE008', 'APP008', 'MED004', 9); 
 
 
INSERT INTO Billing VALUES 
('B001', 'APP001', 3000, 'paid'), 
('B002', 'APP002', 9000, 'paid'), 
('B003', 'APP003', 60000, 'pending'), 
('B004', 'APP004', 1500, 'paid'), 
('B005', 'APP005', 7000, 'pending'), 
('B006', 'APP006', 1800, 'paid'), 
('B007', 'APP007', 1200, 'paid'), 
('B008', 'APP008', 2200, 'pending'); 
 
--------  Display all patient details using CTE----------- 
WITH patients_details AS ( 
SELECT * FROM patients) 
SELECT* FROM patients_details; 
 
-------- display the patients above the average age using CTE --------- 
WITH patients_details AS( 
SELECT *,  
(SELECT AVG(age) FROM patients) AS avg_age FROM patients 
) 
SELECT * FROM patients_details WHERE age > avg_age; 
 
----- display doctors who handled more than one appointments using CTE ---- 
WITH doctor_appointment AS( 
SELECT doctor_id , COUNT(appointment_id)  AS total_appointments 
FROM appointments 
GROUP BY doctor_id 
) 
SELECT * FROM doctor_appointment WHERE total_appointments > 1; 
 
-------- find   department_wise appointment count using CTE ------ 
WITH department_appointment AS( 
select department_id, COUNT(appointment_id)  AS appointment_count 
from appointments a 
JOIN doctors d ON a.doctor_id = d.doctor_id 
GROUP BY  department_id 
) 
SELECT * FROM department_appointment; 
 
 
-------- find top three treatment cost using CTE ------------- 
WITH treatment_cost AS( 
SELECT *FROM treatments 
ORDER BY cost DESC limit 3 
) 
SELECT* FROM treatment_cost; 
 
-------- findpatients who paid more that the average bill----- 
SELECT p.patient_name , b.total_amount 
FROM patients p 
JOIN appointments a ON a.patient_id = p.patient_id 
JOIN billing b ON b.appointment_id = a.appointment_id 
WHERE b.total_amount > (SELECT  AVG (total_amount) FROM billing); 
 
-------- total revenue generated by each department -------- 
SELECT de.department_name ,SUM(total_amount)AS total_revenue FROM billing b 
JOIN appointments a ON a.appointment_id = b.appointment_id 
JOIN doctors d ON a.doctor_id =d.doctor_id 
JOIN departments de ON d.department_id = de.department_id 
GROUP BY de.department_name; 
 
----------- find patients who visited multiple departments ----- 
SELECT p.patient_name , COUNT(d.department_id) 
FROM patients p 
JOIN appointments a ON p.patient_id = a.patient_id 
JOIN doctors d ON a.doctor_id = d.doctor_id 
GROUP BY p.patient_id  HAVING COUNT(d.department_id) >1; 
 
---------- find doctor wise treatment counts----------- 
SELECT d.doctor_name, COUNT(t.treatment_id) AS treatment_count 
FROM doctors d 
JOIN appointments a ON d.doctor_id = a.doctor_id 
JOIN treatments t ON a.appointment_id = t.appointment_id 
GROUP BY d. doctor_name; 
 
-------- find patients with pending bills------------ 
SELECT p.patient_name,b. payment_status 
FROM patients p 
JOIN appointments a ON p.patient_id = a.patient_id 
JOIN billing b ON a.appointment_id = b.appointment_id 
WHERE b.payment_status = 'pending';  
 
------------ display patient name, doctor name, and department------------------- 
SELECT p.patient_name ,d.doctor_name, de.department_name 
FROM patients p  
JOIN appointments a ON a.patient_id  =p.patient_id 
JOIN doctors d ON a.doctor_id = d.doctor_id 
JOIN departments de ON d.department_id = de.department_id; 
 
---------- patient name with treatment details------------- 
SELECT p.patient_name , t.treatment_name , t. * 
FROM patients p 
JOIN appointments a ON a.patient_id = p.patient_id 
JOIN treatments t ON t.appointment_id = a.appointment_id; 
 
-------------------- display patient name with medicine details----------------- 
SELECT p.patient_name , m. * 
FROM patients p 
JOIN appointments a ON p.patient_id = a.patient_id 
JOIN prescriptions pr ON a.appointment_id = pr.appointment_id 
JOIN medicines m ON pr.medicine_id = m.medicine_id; 
 
---------------- department wise total billing--------------- 
SELECT de.department_name , SUM(b.total_amount) AS total_billing 
FROM billing b 
JOIN appointments a ON b.appointment_id = a.appointment_id 
JOIN  doctors d ON a. doctor_id = d.doctor_id 
JOIN departments de ON d.department_id = de.department_id 
GROUP BY de.department_name; 
 
------------- find highest billed patient ----------  
SELECT p.patient_name, b.total_amount  
FROM billing b 
JOIN appointments a ON b.appointment_id = a.appointment_id 
JOIN patients p ON a.patient_id = p.patient_id 
WHERE b.total_amount = ( SELECT  MAX (total_amount) FROM billing ); 
 
-------------- display doctor wise revenue----------------- 
SELECT d.doctor_name, SUM(b.total_amount) AS revenue 
FROM billing b 
JOIN appointments a ON b.appointment_id = a.appointment_id 
JOIN doctors d ON a.doctor_id = d.doctor_id 
GROUP BY d.doctor_name; 
 
---------------- display all appointments with billing status------------ 
SELECT a.  *  ,  b.payment_status 
FROM billing b 
JOIN appointments a ON b.appointment_id = a.appointment_id; 
 
------------------ display patients without prescription---------------- 
SELECT   p.patient_name 
FROM patients p 
LEFT JOIN appointments a ON p.patient_id = a.patient_id 
LEFT JOIN prescriptions pr ON a.appointment_id = pr.appointment_id 
WHERE pr.prescription_id IS NULL; 
 
------------ display doctors without appointments------------ 
SELECT   d.doctor_name 
FROM doctors d 
LEFT JOIN appointments a ON a.doctor_id = d.doctor_id 
WHERE a.appointment_id IS NULL; 
 
---------------display department wise patient count------------------- 
SELECT de.department_name  , COUNT(p.patient_id) 
FROM patients p 
JOIN appointments a ON p.patient_id = a.patient_id 
JOIN doctors d ON a.doctor_id = d.doctor_id 
JOIN departments de ON d.department_id = de.department_id 
GROUP BY de.department_name; 
 
------------ find patients whose bill is greater than the average bill------------- 
SELECT p.patient_name  
FROM patients p 
JOIN appointments a ON a.patient_id = p.patient_id 
JOIN billing b ON b.appointment_id = a.appointment_id 
WHERE b.total_amount > (SELECT  AVG (total_amount) FROM billing); 
 
------------ display doctors earning the highest department revenue------------ 
SELECT de.department_name, d.doctor_name, SUM(b.total_amount) AS revenue 
FROM departments de 
JOIN doctors d ON de.department_id = d.department_id 
JOIN appointments a ON d.doctor_id = a.doctor_id 
JOIN billing b ON a.appointment_id = b.appointment_id 
GROUP BY de.department_name, d.doctor_name 
ORDER BY revenue DESC; 
 
------------------- find the patient prescribed the most expensive medicine------------ 
SELECT p.patient_name ,m.medicine_id , m.price 
FROM patients p 
JOIN appointments a ON a.patient_id = p.patient_id 
JOIN Prescriptions pr ON a.appointment_id =pr.appointment_id 
JOIN medicines m ON pr.medicine_id =m.medicine_id 
WHERE m.price = (SELECT MAX (price) FROM medicines ); 
 
------------------ display department having above average revenue-------------- 
SELECT de.department_name, b.total_amount 
FROM billing b 
JOIN appointments a ON a.appointment_id = b.appointment_id 
JOIN doctors d ON a. doctor_id = d.doctor_id 
JOIN departments de ON d.department_id = de.department_id 
WHERE b.total_amount > ( SELECT  AVG (total_amount) FROM billing ); 
 
------------------ find Doctor Who handled the maximum appointments---------------- 
SELECT d.doctor_name,count(a.appointment_id) AS total_appointments 
FROM appointments a 
JOIN doctors d ON a.doctor_id = d.doctor_id 
WHERE a.appointment_id = (SELECT MAX(COUNT) FROM appointments) 
GROUP BY d.doctor_name HAVING COUNT(a.appointment_id);  
 
--------------- display patient with treatment cost greater than the average treatment cost------------ 
SELECT p.patient_name, t.cost 
FROM treatments t 
JOIN appointments a ON a.appointment_id = t.appointment_id 
JOIN patients p ON a.patient_id = p.patient_id 
WHERE t.cost > (SELECT AVG(cost) FROM treatments); 
 
---------------- find medicines prescribed more than average quantity----------------- 
SELECT m.medicine_id, p. * 
FROM prescriptions p 
JOIN medicines m ON p.medicine_id = m.medicine_id 
WHERE p.quantity > (SELECT AVG(quantity) FROM prescriptions); 
 
--------------- display patient wise total hospital expenditure---------------- 
SELECT p.patient_name , SUM (total_amount) AS total_expenditure  
FROM billing b 
JOIN appointments a ON a.appointment_id = b.appointment_id 
JOIN patients p ON a.patient_id = p.patient_id 
GROUP BY p.patient_name; 
 
 
------------------- find department with no pending payments-------------- 
SELECT de.department_name, b.payment_status 
FROM billing b 
JOIN appointments a ON a.appointment_id = b.appointment_id 
JOIN doctors d ON a.doctor_id = d.doctor_id 
JOIN departments de ON d.department_id = de.department_id 
WHERE b.payment_status != 'pending';  
 
----------------- complete hospital report using CTES, JOINS, and subqueries-------------- 
WITH PatientReport AS 
( 
    SELECT p.patient_id, p.patient_name, d.doctor_name, de.department_name, b.total_amount 
    FROM patients p 
    JOIN appointments a ON p.patient_id = a.patient_id 
    JOIN doctors d ON a.doctor_id = d.doctor_id 
    JOIN departments de ON d.department_id = de.department_id 
    JOIN billing b ON a.appointment_id = b.appointment_id 
) 
SELECT * FROM PatientReport 
WHERE patient_id  IN ( SELECT patient_id FROM billing 
); 
 
 

