----- Create department table----------
CREATE TABLE Department(
  Department_ID INT PRIMARY KEY,
  Department_Name VARCHAR(50) NOT NULL ,
  Location VARCHAR(30) DEFAULT('chennai')
);

---------- Create Employee Table-------------
CREATE TABLE Employee(
 Employee_ID INT PRIMARY KEY,
 Employee_Name VARCHAR(50) NOT NULL,
 Email VARCHAR(50) UNIQUE NOT NULL,
 PAN_NUMBER VARCHAR(15) UNIQUE NOT NULL,
 Gender VARCHAR (10),
 Salary DECIMAL(10,2) CHECK(Salary > 0),
 City VARCHAR(30) DEFAULT('Chennai'),
 Joining_Date DATE,
 Department_ID INT NOT NULL,
 FOREIGN KEY(Department_ID) REFERENCES Department(Department_ID)
);

---------- Create Project Table--------------
CREATE TABLE Project(
 Project_ID INT PRIMARY KEY,
 Project_Name VARCHAR(50) NOT NULL,
 Budget DECIMAL(10,2) CHECK (Budget > 0)
 );
 
--------- Create Employee_project table using Composite key-----------
 CREATE TABLE Employee_Project(
  Employee_ID INT,
  Project_ID INT,
  Assign_Date DATE,
  PRIMARY KEY(Employee_ID , Project_ID),
  FOREIGN KEY (Employee_ID) REFERENCES employee(Employee_ID),
  FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID)
  );
  
------------- Inserting values in employee table------------
INSERT INTO Employee VALUES
(1,'Arun','arun@gmail.com','ABCDE1234F','Male',35000,'Chennai','2024-01-10',101),
(2,'Priya','priya@gmail.com','BCDEF2345G','Female',42000,'Bangalore','2024-01-12',102),
(3,'Karthik','karthik@gmail.com','CDEFG3456H','Male',38000,'Chennai','2024-01-15',103),
(4,'Divya','divya@gmail.com','DEFGH4567J','Female',45000,'Madurai','2024-01-18',104),
(5,'Rahul','rahul@gmail.com','EFGHI5678K','Male',50000,'Coimbatore','2024-01-20',105),
(6,'Meena','meena@gmail.com','FGHIJ6789L','Female',36000,'Salem','2024-02-01',101),
(7,'Vijay','vijay@gmail.com','GHIJK7890M','Male',41000,'Trichy','2024-02-03',102),
(8,'Anitha','anitha@gmail.com','HIJKL8901N','Female',39000,'Erode','2024-02-05',103),
(9,'Suresh','suresh@gmail.com','IJKLM9012P','Male',52000,'Vellore','2024-02-08',104),
(10,'Keerthi','keerthi@gmail.com','JKLMN0123Q','Female',43000,'Chennai','2024-02-10',105),
(11,'Ramesh','ramesh@gmail.com','KLMNO1234R','Male',37000,'Madurai','2024-02-12',101),
(12,'Lakshmi','lakshmi@gmail.com','LMNOP2345S','Female',46000,'Bangalore','2024-02-15',102),
(13,'Ajay','ajay@gmail.com','MNOPQ3456T','Male',48000,'Coimbatore','2024-02-18',103),
(14,'Nisha','nisha@gmail.com','NOPQR4567U','Female',44000,'Salem','2024-02-20',104),
(15,'Hari','hari@gmail.com','OPQRS5678V','Male',39000,'Trichy','2024-02-22',105),
(16,'Deepa','deepa@gmail.com','PQRST6789W','Female',47000,'Erode','2024-02-25',101),
(17,'Manoj','manoj@gmail.com','QRSTU7890X','Male',53000,'Vellore','2024-02-27',102),
(18,'Swathi','swathi@gmail.com','RSTUV8901Y','Female',41000,'Chennai','2024-03-01',103),
(19,'Kumar','kumar@gmail.com','STUVW9012Z','Male',49000,'Madurai','2024-03-05',104),
(20,'Pooja','pooja@gmail.com','TUVWX0123A','Female',45000,'Bangalore','2024-03-08',105);
 
----------- Inserting value into department table-----------
INSERT INTO Department VALUES
(101,'HR','Chennai'),
(102,'IT','Bangalore'),
(103,'Finance','Hyderabad'),
(104,'Sales','Mumbai'),
(105,'Marketing','Pune');

 --------  Inserting value into project table----------
INSERT INTO Project VALUES
(201,'Payroll System',500000),
(202,'CRM',800000),
(203,'Website',300000),
(204,'ERP',1200000),
(205,'Mobile App',700000);

--------- Inserting value into employee_project table---------------
INSERT INTO Employee_Project VALUES
(1,201,'2024-04-01'),
(2,202,'2024-04-02'),
(4,204,'2024-04-04'),
(5,205,'2024-04-05'),
(6,201,'2024-04-06'),
(7,202,'2024-04-07'),
(8,203,'2024-04-08'),
(9,204,'2024-04-09'),
(10,205,'2024-04-10'),
(11,201,'2024-04-11'),
(12,202,'2024-04-12'),
(13,203,'2024-04-13'),
(14,204,'2024-04-14'),
(15,205,'2024-04-15'),
(16,201,'2024-04-16'),
(17,202,'2024-04-17'),
(18,203,'2024-04-18'),
(19,204,'2024-04-19'),
(20,205,'2024-04-20');

-------- Constraint Testing----------
---------- Insert duplicate primary key -----------
INSERT INTO Department VALUES
(105, 'HR', ' Chennai');

---------- Insert Duplicate Unique value--------
INSERT INTO Employee VALUES
(21,'Arunraj', 'arun@gmail.com', 'ABFGDE12904F', 'Male',45000, 'Chennai',' 2024-01-10',101);

---------- Insert null into NOT NULL column------------
INSERT INTO Project VALUES
(207,700000);

---------- Insert invalid foreign key----------
INSERT INTO Employee_project VALUES
 (3 ,210, '202-04-03');

------- Insert invalid Check value-------
INSERT INTO Employee_project VALUES
 (3 ,210,'202-04-03');
 
---------- Insert record without default column----------
INSERT INTO Department (Department_ID , Department_Name) VALUES
 (107, 'Testing')
