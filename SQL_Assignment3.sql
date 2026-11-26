CREATE DATABASE IF NOT EXISTS Sunrise_University;
USE Sunrise_University;

DROP VIEW IF EXISTS College_C_View;
DROP PROCEDURE IF EXISTS GetProfessorByID;
DROP TABLE IF EXISTS Student_Table;
DROP TABLE IF EXISTS Professor_Table;
DROP TABLE IF EXISTS College_Table;
DROP TABLE IF EXISTS Department_Table;

-- Relationship columns are added so the requested foreign keys and
-- four-table INNER JOIN are possible.
CREATE TABLE Department_Table (
  Dept_ID INT PRIMARY KEY,
  Dept_Name VARCHAR(100) NOT NULL,
  Dept_Facility VARCHAR(150) NOT NULL
);

CREATE TABLE College_Table (
  College_ID INT PRIMARY KEY,
  College_Name VARCHAR(120) NOT NULL,
  College_Area VARCHAR(100) NOT NULL,
  Dept_ID INT NOT NULL,
  FOREIGN KEY (Dept_ID) REFERENCES Department_Table(Dept_ID)
);

CREATE TABLE Professor_Table (
  Professor_ID INT PRIMARY KEY,
  Professor_Name VARCHAR(100) NOT NULL,
  Professor_Subject VARCHAR(100) NOT NULL,
  Dept_ID INT NOT NULL,
  FOREIGN KEY (Dept_ID) REFERENCES Department_Table(Dept_ID)
);

CREATE TABLE Student_Table (
  Student_ID INT PRIMARY KEY,
  Student_Name VARCHAR(100) NOT NULL,
  Student_Stream VARCHAR(80) NOT NULL,
  Professor_ID INT NOT NULL,
  FOREIGN KEY (Professor_ID) REFERENCES Professor_Table(Professor_ID)
);

INSERT INTO Department_Table VALUES
(1,'Computer Science','Computer Labs'),(2,'Information Technology','Networking Lab'),
(3,'Mechanical Engineering','Workshop'),(4,'Civil Engineering','Survey Lab'),
(5,'Electrical Engineering','Electrical Lab'),(6,'Business Administration','Management Lab'),
(7,'Commerce','Accounting Lab'),(8,'Physics','Science Laboratory'),
(9,'Mathematics','Research Centre'),(10,'Arts and Humanities','Language Centre');

INSERT INTO College_Table VALUES
(1,'Central College of Technology','Mumbai',1),
(2,'City College of Information','Pune',2),
(3,'Crescent Engineering College','Nashik',3),
(4,'Western Civil College','Nagpur',4),
(5,'Eastern Electrical College','Thane',5),
(6,'Sunrise Business College','Mumbai',6),
(7,'Commerce College of Excellence','Pune',7),
(8,'National College of Physics','Aurangabad',8),
(9,'Modern Mathematics College','Kolhapur',9),
(10,'Arts College of Maharashtra','Navi Mumbai',10);

INSERT INTO Professor_Table (Professor_ID,Professor_Name,Professor_Subject,Dept_ID) VALUES
(1,'Amit Sharma','Database Management',1),(2,'Neha Patil','Computer Networks',2),
(3,'Rahul Verma','Thermodynamics',3),(4,'Priya Desai','Structural Engineering',4),
(5,'Karan Mehta','Power Systems',5),(6,'Sneha Joshi','Business Management',6),
(7,'Rohit Kulkarni','Financial Accounting',7),(8,'Pooja Shah','Quantum Physics',8),
(9,'Arjun Rao','Applied Mathematics',9),(10,'Meera Nair','English Literature',10);

INSERT INTO Student_Table VALUES
(1,'Aarav Patil','Computer Science',1),(2,'Ananya Shah','Information Technology',2),
(3,'Rohan Joshi','Mechanical Engineering',3),(4,'Aditi Desai','Civil Engineering',4),
(5,'Kabir Mehta','Electrical Engineering',5),(6,'Isha Kulkarni','Business Administration',6),
(7,'Vihaan Rao','Commerce',7),(8,'Saanvi Nair','Physics',8),
(9,'Advait Sharma','Mathematics',9),(10,'Anika Verma','Arts and Humanities',10);

-- TASK 2
-- 1. College ID and name
SELECT College_ID, College_Name FROM College_Table;

-- 2. First five students (MySQL uses LIMIT, not TOP)
SELECT * FROM Student_Table ORDER BY Student_ID LIMIT 5;

-- 3. Professor name for ID 5
SELECT Professor_Name FROM Professor_Table WHERE Professor_ID=5;

-- 4. Professor names in uppercase
SELECT UPPER(Professor_Name) AS Professor_Name_Uppercase FROM Professor_Table;

-- 5. Student names starting with A
SELECT Student_Name FROM Student_Table WHERE Student_Name LIKE 'A%';

-- 6. College names ending with a
SELECT College_Name FROM College_Table WHERE College_Name LIKE '%a';

-- 7. Add salary and populate illustrative values
ALTER TABLE Professor_Table ADD COLUMN Salary DECIMAL(12,2) NOT NULL DEFAULT 30000.00;
UPDATE Professor_Table SET Salary = CASE Professor_ID
 WHEN 1 THEN 65000 WHEN 2 THEN 62000 WHEN 3 THEN 70000 WHEN 4 THEN 68000
 WHEN 5 THEN 75000 WHEN 6 THEN 72000 WHEN 7 THEN 61000 WHEN 8 THEN 73000
 WHEN 9 THEN 69000 WHEN 10 THEN 64000 ELSE Salary END;

-- 8. Add student contact column
ALTER TABLE Student_Table ADD COLUMN Contact VARCHAR(20);
UPDATE Student_Table SET Contact=CONCAT('900000000',Student_ID);

-- 9. Total professor salary
SELECT SUM(Salary) AS Total_Professor_Salary FROM Professor_Table;

-- 10. Change datatype of College_Area
ALTER TABLE College_Table MODIFY COLUMN College_Area VARCHAR(150) NOT NULL;

-- TASK 3
-- 1. First five students combined with their professors
SELECT s.Student_ID,s.Student_Name,s.Student_Stream,
       p.Professor_ID,p.Professor_Name,p.Professor_Subject
FROM Student_Table s
INNER JOIN Professor_Table p ON s.Professor_ID=p.Professor_ID
ORDER BY s.Student_ID LIMIT 5;

-- 2. INNER JOIN all four tables
SELECT c.College_ID,c.College_Name,c.College_Area,
       d.Dept_ID,d.Dept_Name,d.Dept_Facility,
       p.Professor_ID,p.Professor_Name,p.Professor_Subject,p.Salary,
       s.Student_ID,s.Student_Name,s.Student_Stream,s.Contact
FROM College_Table c
INNER JOIN Department_Table d ON c.Dept_ID=d.Dept_ID
INNER JOIN Professor_Table p ON p.Dept_ID=d.Dept_ID
INNER JOIN Student_Table s ON s.Professor_ID=p.Professor_ID
ORDER BY c.College_ID,s.Student_ID;

-- 3. Find NULL values (these return zero rows in the supplied clean data)
SELECT * FROM Department_Table WHERE Dept_Name IS NULL OR Dept_Facility IS NULL;
SELECT * FROM Professor_Table WHERE Professor_Name IS NULL OR Professor_Subject IS NULL;

-- Optional NULL demonstration; temporary rows are rolled back
START TRANSACTION;
INSERT INTO Department_Table VALUES (99,'Temporary Department',NULL);
INSERT INTO Professor_Table (Professor_ID,Professor_Name,Professor_Subject,Dept_ID,Salary)
VALUES (99,'Temporary Professor',NULL,99,0);
SELECT * FROM Department_Table WHERE Dept_Facility IS NULL;
SELECT * FROM Professor_Table WHERE Professor_Subject IS NULL;
ROLLBACK;

-- 4. View: college names starting with C
CREATE OR REPLACE VIEW College_C_View AS
SELECT College_ID,College_Name,College_Area,Dept_ID
FROM College_Table WHERE College_Name LIKE 'C%';
SELECT * FROM College_C_View;

-- 5. Stored procedure: user supplies professor ID
DELIMITER //
CREATE PROCEDURE GetProfessorByID(IN p_Professor_ID INT)
BEGIN
  SELECT * FROM Professor_Table WHERE Professor_ID=p_Professor_ID;
END //
DELIMITER ;
CALL GetProfessorByID(5); -- change 5 to another ID when required

-- 6. Rename College_Table
RENAME TABLE College_Table TO College_Tables_Data;

-- Recreate the view after table rename
CREATE OR REPLACE VIEW College_C_View AS
SELECT College_ID,College_Name,College_Area,Dept_ID
FROM College_Tables_Data WHERE College_Name LIKE 'C%';
SELECT * FROM College_C_View;

-- Final four-table join using renamed college table
SELECT c.College_ID,c.College_Name,d.Dept_Name,p.Professor_Name,s.Student_Name
FROM College_Tables_Data c
INNER JOIN Department_Table d ON c.Dept_ID=d.Dept_ID
INNER JOIN Professor_Table p ON p.Dept_ID=d.Dept_ID
INNER JOIN Student_Table s ON s.Professor_ID=p.Professor_ID;
