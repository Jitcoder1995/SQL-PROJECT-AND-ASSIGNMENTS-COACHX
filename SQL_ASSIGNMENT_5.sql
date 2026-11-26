-- SQL ASSIGNMENT 5 
Create Database Student;

Use Student;


DROP TABLE IF EXISTS Borrows;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Types;

CREATE TABLE Students (
    studentId INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    birthdate DATE NULL,
    gender CHAR(1) NOT NULL,
    class VARCHAR(20) NOT NULL,
    point INT NOT NULL
);

CREATE TABLE Authors (
    authorId INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL
);

CREATE TABLE Types (
    typeId INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Books (
    bookId INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    pagecount INT NOT NULL,
    point INT NOT NULL,
    authorId INT NOT NULL,
    typeId INT NOT NULL,
    FOREIGN KEY (authorId) REFERENCES Authors(authorId),
    FOREIGN KEY (typeId) REFERENCES Types(typeId)
);

CREATE TABLE Borrows (
    borrowId INT IDENTITY(1,1) PRIMARY KEY,
    studentId INT NOT NULL,
    bookId INT NOT NULL,
    takenDate DATE NOT NULL,
    broughtDate DATE NULL,
    FOREIGN KEY (studentId) REFERENCES Students(studentId),
    FOREIGN KEY (bookId) REFERENCES Books(bookId)
);

-- Seed Students: includes assignment example names/classes for practice
SET IDENTITY_INSERT Students ON;
INSERT INTO Students (studentId, name, surname, birthdate, gender, class, point) VALUES
(1,'John','Doe','2005-01-15','M','10A',85),
(2,'Jane','Smith','2006-03-22','F','10B',90),
(3,'Alice','Johnson','2005-07-12','F','10Bio',88),
(4,'Bob','Brown','2006-11-30','M','10C',76),
(5,'Charlie','Davis','2005-05-05','M','10B',92),
(6,'Diana','Miller','2006-06-25','F','10C',81),
(7,'Eve','Wilson','2005-09-18','F','10A',87),
(8,'Frank','Moore','2006-12-02','M','10B',80),
(9,'Grace','Taylor','2005-04-17','F','10C',83),
(10,'Hank','Anderson','2006-10-20','M','10A',78),
(11,'Emma','Stone','1989-02-11','F','10Math',91),
(12,'Sophia','Turner','1990-05-24','F','10Math',95),
(13,'Robert','King','1989-07-09','M','9Math',72),
(14,'Thomas','Nelson','1991-01-18','M','10Math',84),
(15,'Sally','Allen','1992-03-02','F','9Bio',89),
(16,'Linda','Sandra','1993-04-21','F','11His',93),
(17,'Adam','Baker','1989-12-30','M','10Bio',79),
(18,'Daniel','Clark','1994-06-14','M','10Math',86),
(19,'Kevin','Young','1995-08-19','M','10Bio',77),
(20,'Kelly','Adams','1996-10-01','F','9His',88);
SET IDENTITY_INSERT Students OFF;

-- Seed Authors (10)
SET IDENTITY_INSERT Authors ON;
INSERT INTO Authors (authorId,name,surname) VALUES
(1,'F. Scott','Fitzgerald'),
(2,'Harper','Lee'),
(3,'George','Orwell'),
(4,'Jane','Austen'),
(5,'J.D.','Salinger'),
(6,'J.R.R.','Tolkien'),
(7,'Herman','Melville'),
(8,'Leo','Tolstoy'),
(9,'James','Joyce'),
(10,'Homer','');
SET IDENTITY_INSERT Authors OFF;

-- Seed Types (10)
SET IDENTITY_INSERT Types ON;
INSERT INTO Types (typeId,name) VALUES
(1,'Fiction'),(2,'Classic'),(3,'Dystopian'),(4,'Literature'),
(5,'Fantasy'),(6,'Adventure'),(7,'Historical Fiction'),
(8,'Science Fiction'),(9,'Mythology'),(10,'Philosophy');
SET IDENTITY_INSERT Types OFF;

-- Seed Books (10)
SET IDENTITY_INSERT Books ON;
INSERT INTO Books (bookId,name,pagecount,point,authorId,typeId) VALUES
(1,'The Great Gatsby',180,95,1,1),
(2,'To Kill a Mockingbird',281,90,2,2),
(3,'1984',328,88,3,3),
(4,'Pride and Prejudice',279,93,4,4),
(5,'The Catcher in the Rye',214,85,5,1),
(6,'The Hobbit',310,91,6,5),
(7,'Moby-Dick',635,80,7,6),
(8,'War and Peace',1225,92,8,7),
(9,'Ulysses',730,89,9,4),
(10,'The Odyssey',541,87,10,9);
SET IDENTITY_INSERT Books OFF;

-- Seed Borrows (10)
SET IDENTITY_INSERT Borrows ON;
INSERT INTO Borrows (borrowId,studentId,bookId,takenDate,broughtDate) VALUES
(1,1,3,'2024-01-10','2024-01-20'),
(2,2,5,'2024-01-12','2024-01-22'),
(3,3,7,'2024-01-15','2024-01-25'),
(4,4,2,'2024-01-18','2024-01-28'),
(5,5,1,'2024-01-20','2024-01-30'),
(6,6,4,'2024-01-22','2024-02-01'),
(7,7,6,'2024-01-24','2024-02-03'),
(8,8,8,'2024-01-26','2024-02-05'),
(9,9,10,'2024-01-28','2024-02-07'),
(10,10,9,'2024-01-30','2024-02-09');
SET IDENTITY_INSERT Borrows OFF;

-- ==================== SELECT EXAMPLES 1-29 ====================

-- Example 1: All student records
SELECT * FROM Students;

-- Example 2: Student name, surname and class
SELECT name, surname, class FROM Students;

-- Example 3: Female students
SELECT * FROM Students WHERE gender = 'F';

-- Example 4: Classes shown only once
SELECT DISTINCT class FROM Students;

-- Example 5: Female students in 10Math
SELECT * FROM Students WHERE gender='F' AND class='10Math';

-- Example 6: Students in 10Math or 10Sci (names, surnames, classes)
SELECT name, surname, class FROM Students WHERE class IN ('10Math','10Sci');

-- Example 7: Student name, surname and student number
SELECT name, surname, studentId FROM Students;

-- Example 8: Name and surname combined
SELECT CONCAT(name,' ',surname) AS FullName FROM Students;

-- Example 9: Names starting with A
SELECT * FROM Students WHERE name LIKE 'A%';

-- Example 10: Books with 50-200 pages
SELECT name, pagecount FROM Books WHERE pagecount BETWEEN 50 AND 200;

-- Example 11: Students named Emma, Sophia or Robert
SELECT * FROM Students WHERE name IN ('Emma','Sophia','Robert');

-- Example 12: Names starting with A, D or K
SELECT * FROM Students WHERE name LIKE 'A%' OR name LIKE 'D%' OR name LIKE 'K%';

-- Example 13: Males in 9Math OR females in 9His
SELECT name, surname, class, gender
FROM Students
WHERE (gender='M' AND class='9Math') OR (gender='F' AND class='9His');

-- Example 14: Males whose classes are 10Math or 10Bio
SELECT * FROM Students WHERE gender='M' AND class IN ('10Math','10Bio');

-- Example 15: Students born in 1989
SELECT * FROM Students WHERE YEAR(birthdate)=1989;

-- Example 16: Female students with student numbers 30 to 50
SELECT * FROM Students WHERE gender='F' AND studentId BETWEEN 30 AND 50;

-- Example 17: Students ordered by name
SELECT * FROM Students ORDER BY name ASC;

-- Example 18: Students with same first names, ordered by surname
SELECT * FROM Students ORDER BY name ASC, surname ASC;

-- Example 19: Students in 10Math, student number descending
SELECT * FROM Students WHERE class='10Math' ORDER BY studentId DESC;

-- Example 20: First 10 student records
SELECT TOP (10) * FROM Students ORDER BY studentId;

-- Example 21: First 10 name, surname, birthdate records
SELECT TOP (10) name, surname, birthdate FROM Students ORDER BY studentId;

-- Example 22: Book with highest page count
SELECT TOP (1) * FROM Books ORDER BY pagecount DESC;

-- Example 23: Youngest student (most recent birthdate)
SELECT TOP (1) * FROM Students WHERE birthdate IS NOT NULL ORDER BY birthdate DESC;

-- Example 24: Oldest student in 10Math
SELECT TOP (1) * FROM Students WHERE class='10Math' AND birthdate IS NOT NULL ORDER BY birthdate ASC;

-- Example 25: Books whose second letter is N
SELECT * FROM Books WHERE name LIKE '_N%';

-- Example 26: Students grouped/listed by class
SELECT * FROM Students ORDER BY class, name, surname;

-- Example 27: Randomly ordered student list
SELECT * FROM Students ORDER BY NEWID();

-- Example 28: Pick one random student
SELECT TOP (1) * FROM Students ORDER BY NEWID();

-- Example 29: Random student name, surname, number from 10Math
SELECT TOP (1) name, surname, studentId FROM Students WHERE class='10Math' ORDER BY NEWID();

-- ==================== INSERT EXAMPLES 30-35 ====================

-- Example 30: Add author Smith Allen
INSERT INTO Authors (name,surname) VALUES ('Smith','Allen');

-- Example 31: Add biography type
INSERT INTO Types (name) VALUES ('Biography');

-- Example 32: Insert three students in one statement
INSERT INTO Students (name,surname,birthdate,gender,class,point) VALUES
('Thomas','Nelson','1991-01-18','M','10Math',84),
('Sally','Allen','1992-03-02','F','9Bio',89),
('Linda','Sandra','1993-04-21','F','11His',93);

-- Example 33: Add one random student as an author
INSERT INTO Authors (name,surname)
SELECT TOP (1) name,surname FROM Students ORDER BY NEWID();

-- Example 34: Add students with IDs between 10 and 30 as authors
INSERT INTO Authors (name,surname)
SELECT name,surname FROM Students WHERE studentId BETWEEN 10 AND 30;

-- Example 35: Add Cindy Brown and capture generated author ID (SQL Server identity)
INSERT INTO Authors (name,surname) VALUES ('Cindy','Brown');
SELECT SCOPE_IDENTITY() AS NewAuthorId;

-- ==================== UPDATE / DELETE / NULL / JOIN 36-41 ====================

-- Example 36: Change student ID 3 class to 10His (from 10Bio)
UPDATE Students SET class='10His' WHERE studentId=3;

-- Example 37: Change all 9Math students to 10Math
UPDATE Students SET class='10Math' WHERE class='9Math';

-- Example 38: Increase every student's score by 5
UPDATE Students SET point=point+5;

-- Example 39: Delete author #25 (if exists)
DELETE FROM Authors WHERE authorId=25;

-- Example 40: Students whose birthdate is NULL
SELECT * FROM Students WHERE birthdate IS NULL;

-- Example 41: Student name, surname and date books were taken
SELECT s.name, s.surname, b.takenDate
FROM Students s
INNER JOIN Borrows b ON b.studentId=s.studentId;
