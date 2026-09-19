CREATE DATABASE myDB;
USE myDB;
CREATE TABLE Student (    -- Creating a table
  stu_id INT PRIMARY KEY,
  stu_name VARCHAR(50),
  Dept VARCHAR(35),
  Gender VARCHAR(10),
  Email_id VARCHAR(50)
);

RENAME TABLE Student TO STUDENTS;   -- Renaming student table to students

ALTER TABLE STUDENTS                -- adding new column
ADD COLUMN ph_no VARCHAR(15);     

INSERT INTO Students VALUES    -- Inserting Values in the student table
(1011, 'Raj', 'BCA', 'Male', 'raj232@gmail.com', '9003220974'),
(1012, 'Priya', 'Computer Science', 'Female', 'pri32ya@gmail.com', '8363478681'),
(1013, 'Jerlin','B.tech', 'Female', 'jerlin657@gamil.com', '979198190'),
(1014, 'Anand', 'Cyber Security', 'Male', 'anandraj@gmail.com', '7871004278'),
(1015, 'joseph', 'MBA', 'Male', 'Joelash@gmail.com','7301616716');

ALTER TABLE STUDENTS                     -- Rename column dept to student_department
RENAME COLUMN Dept To student_Department ;

ALTER TABLE STUDENTS                     
MODIFY COLUMN Email_id VARCHAR(75);

ALTER TABLE STUDENTS                 -- Changing column position
MODIFY COLUMN Email_id VARCHAR(75)
AFTER Student_Department;

ALTER TABLE STUDENTS           -- Permanently deleting the ph_no column
DROP COLUMN Ph_no;

UPDATE STUDENTS
SET Student_department = 'MBA(Finance)'
WHERE stu_id = 1015;

SELECT * FROM STUDENTS;

TRUNCATE TABLE STUDENTS;

SELECT * FROM STUDENTS;













