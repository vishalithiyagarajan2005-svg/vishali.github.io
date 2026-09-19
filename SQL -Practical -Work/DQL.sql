CREATE DATABASE employee_db;
USE employee_db;

CREATE TABLE employee(
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50),
  gender VARCHAR(10),
  department VARCHAR(50),
  salary DECIMAL(10,2),
  hire_date DATE,
  city VARCHAR(50)
  );
  
  INSERT INTO employee VALUES
  (101, 'John', 'Male', 'IT',65000,'2021-01-15','Chennai'),
  (102, 'Sarah', 'Female', 'HR',45000,'2020-03-10','Bangalore'),
  (103, 'David', 'Male', 'Finance',70000,'2019-07-20','Mumbai'),
  (104, 'Priya', 'Female', 'IT',80000,'2022-02-18','Chennai'),
  (105, 'Ahmed', 'Male', 'Sales',55000,'2021-09-25','Hyderabad'),
  (106, 'Meena', 'Female', 'HR',50000,'2023-01-05','Delhi'),
  (107, 'Raj', 'Male', 'IT',90000,'2018-11-12','Bangalore'),
  (108, 'Anita', 'Female', 'Finance',75000,'2020-08-30','Mumbai'),
  (109, 'Kumar', 'Male', 'Sales',60000,'2022-04-15','Chennai'),
  (110, 'Fathima','Female', 'IT',85000,'2019-06-22','Hyderabad');
  
  SELECT * FROM employee;          -- Display all records
  
  SELECT emp_name , salary FROM employee;     -- Display employee name and salary
  
  SELECT * FROM employee WHERE department ='IT';  -- Display the employees whose department is IT
  
  SELECT * FROM employee WHERE salary > 60000;    -- Display the employee salary more than 60000
  
  SELECT * FROM employee WHERE city = 'Chennai';   -- Display the employees from chennai
  
  SELECT * FROM employee WHERE hire_date > '2021-12-31';  -- Display employees hired after 2021
  
  SELECT * FROM employee ORDER BY salary;
  
  SELECT * FROM employee ORDER BY salary DESC limit 1;
                                                                                         -- Display highest salary
  SELECT  emp_name , salary FROM employee WHERE salary = (SELECT MAX(salary) FROM employee);
  
  SELECT AVG(salary) FROM employee;               -- Display average salary
  
  SELECT department, Count(*) FROM employee GROUP BY department;       -- employee count for each department
  
  SELECT department FROM employee GROUP BY department HAVING count(*) > 2;
  
  SELECT distinct city FROM employee;
  
  SELECT * FROM employee WHERE emp_name LIKE 'a%';                  -- employees name start with 'a'
  
  SELECT * FROM employee WHERE salary BETWEEN 50000 AND 80000;        -- employee salary bwen 50000 and 80000
  
  SELECT * FROM employee ORDER BY salary DESC limit 3;
  
   
    
  
  
  
  
  
