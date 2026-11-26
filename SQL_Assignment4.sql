-- SQL ASSIGNMENT 4 

Create Database EmployeeManagement;

Use EmployeeManagement;

DROP TABLE IF EXISTS EmployeeSalary;
DROP TABLE IF EXISTS EmployeeDetails;

CREATE TABLE EmployeeDetails (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(100),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(100)
);

CREATE TABLE EmployeeSalary (
    EmpId INT,
    Project VARCHAR(50),
    Salary DECIMAL(10,2),
    `Variable` DECIMAL(10,2),
    FOREIGN KEY (EmpId) REFERENCES EmployeeDetails(EmpId)
);

INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City) VALUES
(101, 'Alice Johnson', 321, '2022-05-15', 'New York'),
(102, 'Bob Smith', 876, '2020-03-12', 'Los Angeles'),
(103, 'Charlie Brown', 986, '2021-08-23', 'Chicago'),
(104, 'David Williams', 876, '2019-11-05', 'Houston'),
(105, 'Eve Davis', 321, '2023-01-07', 'Phoenix'),
(106, 'Frank Miller', 986, '2018-12-19', 'Philadelphia'),
(107, 'Grace Wilson', 876, '2022-03-28', 'San Antonio'),
(108, 'Hank Moore', 321, '2021-09-14', 'San Diego'),
(109, 'Ivy Taylor', 986, '2020-02-11', 'Dallas'),
(110, 'Jack Anderson', 876, '2022-11-30', 'San Jose'),
(111, 'Karen Thomas', 321, '2021-07-16', 'Austin'),
(112, 'Liam Jackson', 986, '2023-04-21', 'Fort Worth'),
(113, 'Mia White', 876, '2019-06-03', 'Columbus'),
(114, 'Noah Harris', 321, '2020-12-10', 'Charlotte'),
(115, 'Olivia Martin', 986, '2021-10-25', 'San Francisco'),
(116, 'Paul Garcia', 876, '2023-07-18', 'Indianapolis'),
(117, 'Quinn Martinez', 321, '2022-09-07', 'Seattle'),
(118, 'Rachel Rodriguez', 986, '2020-01-15', 'Denver'),
(119, 'Steve Clark', 876, '2021-03-19', 'Washington'),
(120, 'Tina Lewis', 321, '2019-08-31', 'Boston');

INSERT INTO EmployeeSalary (EmpId, Project, Salary, `Variable`) VALUES
(101, 'P1', 7500, 500),
(102, 'P2', 9200, 700),
(103, 'P1', 6700, 600),
(104, 'P3', 8300, 900),
(105, 'P2', 7800, 800),
(106, 'P3', 9100, 1000),
(107, 'P1', 6200, 400),
(108, 'P2', 8800, 750),
(109, 'P3', 9500, 1100),
(110, 'P1', 7200, 650),
(111, 'P2', 8700, 850),
(112, 'P3', 9300, 1200),
(113, 'P1', 7900, 550),
(114, 'P2', 6800, 450),
(115, 'P3', 8400, 900),
(116, 'P1', 7600, 500),
(117, 'P2', 8900, 1000),
(118, 'P3', 9200, 1100),
(119, 'P1', 8100, 600),
(120, 'P2', 8300, 750);

-- =========================
-- PART 1 - BASIC / INTERMEDIATE
-- =========================

-- Q1. Records in one table but not the other (EmployeeDetails absent from EmployeeSalary)
SELECT d.*
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON s.EmpId = d.EmpId
WHERE s.EmpId IS NULL;

-- Q1 (reverse direction): EmployeeSalary records absent from EmployeeDetails
SELECT s.*
FROM EmployeeSalary s
LEFT JOIN EmployeeDetails d ON d.EmpId = s.EmpId
WHERE d.EmpId IS NULL;

-- Q2. Employees not assigned to any project
SELECT d.*
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON s.EmpId = d.EmpId
WHERE s.EmpId IS NULL OR s.Project IS NULL;

-- Q3. Employees who joined in 2020
SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

-- Q4. Employees having a salary record
SELECT d.*
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON s.EmpId = d.EmpId;

-- Q5. Project-wise employee count
SELECT Project, COUNT(*) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project;

-- Q6. Employee names and salary, including employees without salary record
SELECT d.FullName, s.Salary
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON s.EmpId = d.EmpId;

-- Q7. Employees who are managers (their EmpId appears as someone's ManagerId)
SELECT DISTINCT m.*
FROM EmployeeDetails m
INNER JOIN EmployeeDetails e ON e.ManagerId = m.EmpId;

-- Q8. Duplicate records in EmployeeDetails (group all columns)
SELECT EmpId, FullName, ManagerId, DateOfJoining, City, COUNT(*) AS DuplicateCount
FROM EmployeeDetails
GROUP BY EmpId, FullName, ManagerId, DateOfJoining, City
HAVING COUNT(*) > 1;

-- Q9. Odd-numbered rows (using ROW_NUMBER)
SELECT *
FROM (
    SELECT d.*, ROW_NUMBER() OVER (ORDER BY EmpId) AS RowNum
    FROM EmployeeDetails d
) numbered
WHERE RowNum % 2 = 1;

-- Q10. Third-highest distinct salary (without TOP or LIMIT)
SELECT DISTINCT Salary
FROM EmployeeSalary
WHERE Salary = (
    SELECT MAX(Salary)
    FROM EmployeeSalary
    WHERE Salary < (
        SELECT MAX(Salary)
        FROM EmployeeSalary
        WHERE Salary < (SELECT MAX(Salary) FROM EmployeeSalary)
    )
);

-- =========================
-- PART 2
-- =========================

-- Q1. Employees under ManagerId 986
SELECT EmpId, FullName
FROM EmployeeDetails
WHERE ManagerId = 986;

-- Q2. Different projects
SELECT DISTINCT Project
FROM EmployeeSalary;

-- Q3. Count employees working on P1
SELECT COUNT(*) AS P1EmployeeCount
FROM EmployeeSalary
WHERE Project = 'P1';

-- Q4. Maximum, minimum, average salary
SELECT MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AverageSalary
FROM EmployeeSalary;

-- Q5. Employee IDs with salary between 9000 and 15000 (inclusive)
SELECT EmpId
FROM EmployeeSalary
WHERE Salary BETWEEN 9000 AND 15000;

-- Q6. Employees in Toronto and ManagerId 321
SELECT *
FROM EmployeeDetails
WHERE City = 'Toronto' AND ManagerId = 321;

-- Q7. Employees in California OR ManagerId 321
-- The provided City data contains city names, not 'California'; this query follows the question literally.
SELECT *
FROM EmployeeDetails
WHERE City = 'California' OR ManagerId = 321;

-- Q8. Employees working on projects other than P1
SELECT *
FROM EmployeeSalary
WHERE Project <> 'P1';

-- Q9. Total salary (Salary + Variable)
SELECT EmpId, Salary, `Variable`, Salary + `Variable` AS TotalSalary
FROM EmployeeSalary;

-- Q10. Names with any 2 characters, then 'hn', then any characters
SELECT *
FROM EmployeeDetails
WHERE FullName LIKE '__hn%';

-- =========================
-- PART 3
-- =========================

-- Q1. EmpIds present in either table
SELECT EmpId FROM EmployeeDetails
UNION
SELECT EmpId FROM EmployeeSalary;

-- Q2. Common records (employee details and salary records) by EmpId
SELECT d.*, s.Project, s.Salary, s.`Variable`
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON s.EmpId = d.EmpId;

-- Q3. Records in one table but not the other (Details not in Salary)
SELECT d.*
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON s.EmpId = d.EmpId
WHERE s.EmpId IS NULL;

-- Q4. EmpIds present in both tables
SELECT d.EmpId
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON s.EmpId = d.EmpId;

-- Q5. EmpIds in EmployeeDetails but not EmployeeSalary
SELECT d.EmpId
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON s.EmpId = d.EmpId
WHERE s.EmpId IS NULL;

-- Q6. Full names with spaces replaced by underscores
SELECT REPLACE(FullName, ' ', '_') AS NameWithUnderscores
FROM EmployeeDetails;

-- Q7. Position of character 'a' in employee name (MySQL INSTR)
SELECT FullName, INSTR(FullName, 'a') AS CharacterPosition
FROM EmployeeDetails;

-- Q8. EmpId and ManagerId together
SELECT CONCAT(EmpId, ' - Manager: ', ManagerId) AS EmployeeAndManager
FROM EmployeeDetails;

-- Q9. First name (text before first space)
SELECT SUBSTRING_INDEX(FullName, ' ', 1) AS FirstName
FROM EmployeeDetails;

-- Q10. Uppercase employee name and lowercase city
SELECT UPPER(FullName) AS UpperName, LOWER(City) AS LowerCity
FROM EmployeeDetails;

-- =========================
-- PART 4
-- =========================

-- Q1. Count occurrences of letter 'n' in each employee full name
SELECT FullName,
       LENGTH(FullName) - LENGTH(REPLACE(LOWER(FullName), 'n', '')) AS N_Count
FROM EmployeeDetails;

-- Q2. Remove leading/trailing whitespace from names (UPDATE)
-- Preview before applying update:
SELECT FullName, TRIM(FullName) AS TrimmedName
FROM EmployeeDetails;
-- Uncomment to perform the update:
-- UPDATE EmployeeDetails SET FullName = TRIM(FullName);

-- Q3. Employees not working on any project
SELECT d.*
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON s.EmpId = d.EmpId
WHERE s.EmpId IS NULL OR s.Project IS NULL;

-- Q4. Employees with salary between 5000 and 10000 inclusive
SELECT d.FullName, s.Salary
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON s.EmpId = d.EmpId
WHERE s.Salary BETWEEN 5000 AND 10000;

-- Q5. Current date and time
SELECT NOW() AS CurrentDateTime;

-- Q6. Employee details for joining year 2020
SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

-- Q7. Employee records with salary record
SELECT d.*
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON s.EmpId = d.EmpId;

-- Q8. Project-wise employee counts, descending
SELECT Project, COUNT(*) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project
ORDER BY COUNT(*) DESC;

-- Q9. Employee names and salary details, include employees with no salary record
SELECT d.FullName, s.Project, s.Salary, s.`Variable`
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON s.EmpId = d.EmpId;

-- Q10. Join 3 table references: employee, salary, and manager (self-join)
-- ManagerId in the supplied data is not a matching EmpId, so Manager columns will be NULL.
SELECT e.EmpId, e.FullName, e.ManagerId,
       m.FullName AS ManagerName,
       s.Project, s.Salary, s.`Variable`
FROM EmployeeDetails e
LEFT JOIN EmployeeDetails m ON e.ManagerId = m.EmpId
LEFT JOIN EmployeeSalary s ON e.EmpId = s.EmpId;
