create database Employeedatabase;
use employeedatabase;

CREATE TABLE EmployeeDetail
(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(12,2),
    JoiningDate DATETIME,
    Department VARCHAR(50),
    Gender VARCHAR(10)
);


INSERT INTO EmployeeDetail
(EmployeeID, FirstName, LastName, Salary, JoiningDate, Department, Gender)
VALUES
(1, 'Vikas',  'Ahlawat',  600000, '2013-02-12T11:16:00', 'IT',     'Male'),
(2, 'nikita', 'Jain',     530000, '2013-02-14T11:16:00', 'HR',     'Female'),
(3, 'Ashish', 'Kumar',   1000000, '2013-02-14T11:16:00', 'IT',     'Male'),
(4, 'Nikhil', 'Sharma',   480000, '2013-02-15T11:16:00', 'HR',     'Male'),
(5, 'anish',  'kadian',   500000, '2013-02-16T11:16:00', 'Paroll', 'Male');


CREATE TABLE ProjectDetail
(
    ProjectDetailID INT PRIMARY KEY,
    EmployeeDetailID INT NULL,
    ProjectName VARCHAR(100)
    -- No FK is added because the assignment asks for unmatched project IDs
    -- (for example EmployeeDetailID = 6) to demonstrate outer joins.
);


INSERT INTO ProjectDetail
(ProjectDetailID, EmployeeDetailID, ProjectName)
VALUES
(1, 1, 'Task Track'),
(2, 1, 'CLP'),
(3, 1, 'Survey Managment'),
(4, 2, 'HR Managment'),
(5, 3, 'Task Track'),
(6, 3, 'GRS'),
(7, 3, 'DDS'),
(8, 4, 'HR Managment'),
(9, 6, 'GL Managment');


-- Verify the supplied data
SELECT * FROM EmployeeDetail ORDER BY EmployeeID;
SELECT * FROM ProjectDetail ORDER BY ProjectDetailID;


-- =========================================================
-- PART B: EMPLOYEEDETAIL QUESTIONS 1-35
-- =========================================================

-- 1. Get all employee details
SELECT * FROM EmployeeDetail;

-- 2. Get only FirstName
SELECT FirstName FROM EmployeeDetail;

-- 3. FirstName in upper case, alias First Name
SELECT UPPER(FirstName) AS [First Name]
FROM EmployeeDetail;

-- 4. Same requirement is repeated in the assignment
SELECT UPPER(FirstName) AS [First Name]
FROM EmployeeDetail;

-- 5. Combine FirstName and LastName with a space
SELECT CONCAT(FirstName, ' ', LastName) AS [Name]
FROM EmployeeDetail;

-- 5(i). Employee whose name is Vikas
SELECT *
FROM EmployeeDetail
WHERE FirstName = 'Vikas';

-- 5(ii) / 5(iii). FirstName starts with 'a' (case-insensitive)
SELECT *
FROM EmployeeDetail
WHERE LOWER(FirstName) LIKE 'a%';

-- 5(iv). FirstName ends with 'h'
SELECT *
FROM EmployeeDetail
WHERE FirstName LIKE '%h';

-- 6. FirstName starts with any letter from a through p
SELECT *
FROM EmployeeDetail
WHERE LOWER(FirstName) LIKE '[a-p]%';

-- 7. FirstName does not start with any letter from a through p
SELECT *
FROM EmployeeDetail
WHERE LOWER(FirstName) NOT LIKE '[a-p]%';

-- 8. Gender ends with 'le' and contains exactly 4 characters
SELECT *
FROM EmployeeDetail
WHERE Gender LIKE '__le';

-- 9. FirstName starts with A and contains exactly 5 letters
SELECT *
FROM EmployeeDetail
WHERE FirstName LIKE 'A____';

-- 10. FirstName contains a literal percent sign (%)
-- The ESCAPE character makes % literal instead of a wildcard.
SELECT *
FROM EmployeeDetail
WHERE FirstName LIKE '%!%%' ESCAPE '!';

-- 11. Unique departments
SELECT DISTINCT Department
FROM EmployeeDetail;

-- 12. Highest salary
SELECT MAX(Salary) AS HighestSalary
FROM EmployeeDetail;

-- 13. Lowest salary
SELECT MIN(Salary) AS LowestSalary
FROM EmployeeDetail;

-- 14. JoiningDate as dd mmm yyyy (example: 15 Feb 2013)
SELECT FORMAT(JoiningDate, 'dd MMM yyyy', 'en-US') AS JoiningDateFormatted
FROM EmployeeDetail;

-- 15. JoiningDate as yyyy/mm/dd
SELECT CONVERT(VARCHAR(10), JoiningDate, 111) AS JoiningDateFormatted
FROM EmployeeDetail;

-- 16. Time part only
SELECT CONVERT(TIME, JoiningDate) AS JoiningTime
FROM EmployeeDetail;

-- 17. Year part
SELECT YEAR(JoiningDate) AS JoiningYear
FROM EmployeeDetail;

-- 18. Month part
SELECT MONTH(JoiningDate) AS JoiningMonth
FROM EmployeeDetail;

-- 19. Current system date/time
SELECT GETDATE() AS SystemDateTime;

-- 20. Current UTC date/time
SELECT GETUTCDATE() AS UTCDateTime;

-- 20(a). FirstName, current date, joining date, difference in months
SELECT FirstName, GETDATE() AS CurrentDate, JoiningDate,
       DATEDIFF(MONTH, JoiningDate, GETDATE()) AS MonthsSinceJoining
FROM EmployeeDetail;

-- 21. FirstName, current date, joining date, difference in days
SELECT FirstName, GETDATE() AS CurrentDate, JoiningDate,
       DATEDIFF(DAY, JoiningDate, GETDATE()) AS DaysSinceJoining
FROM EmployeeDetail;

-- 22. Employees who joined in 2013
SELECT *
FROM EmployeeDetail
WHERE JoiningDate >= '2013-01-01'
  AND JoiningDate <  '2014-01-01';

-- 23. Employees who joined in January
SELECT *
FROM EmployeeDetail
WHERE MONTH(JoiningDate) = 1;

-- 24. Same January requirement is repeated in the assignment
SELECT *
FROM EmployeeDetail
WHERE MONTH(JoiningDate) = 1;

-- 25. Number of employees
SELECT COUNT(*) AS TotalEmployees
FROM EmployeeDetail;

-- 26. Top 1 record (stable selection using EmployeeID)
SELECT TOP (1) *
FROM EmployeeDetail
ORDER BY EmployeeID;

-- 27. Employees named Vikas, Ashish and Nikhil
SELECT *
FROM EmployeeDetail
WHERE FirstName IN ('Vikas', 'Ashish', 'Nikhil');

-- 28. Employees whose first name is not Vikas, Ashish or Nikhil
SELECT *
FROM EmployeeDetail
WHERE FirstName NOT IN ('Vikas', 'Ashish', 'Nikhil');

-- 29. Remove spaces from right side of FirstName
SELECT RTRIM(FirstName) AS FirstName
FROM EmployeeDetail;

-- 30. Remove spaces from left side of FirstName
SELECT LTRIM(FirstName) AS FirstName
FROM EmployeeDetail;

-- 31. Display gender as M/F
SELECT FirstName,
       CASE WHEN Gender = 'Male' THEN 'M'
            WHEN Gender = 'Female' THEN 'F'
            ELSE NULL END AS Gender
FROM EmployeeDetail;

-- 32. Prefix FirstName with Hello
SELECT CONCAT('Hello ', FirstName) AS Greeting
FROM EmployeeDetail;

-- 33. Salary greater than 600000
SELECT *
FROM EmployeeDetail
WHERE Salary > 600000;

-- 34. Salary less than 700000
SELECT *
FROM EmployeeDetail
WHERE Salary < 700000;

-- 35. Salary between 500000 and 600000 (inclusive)
SELECT *
FROM EmployeeDetail
WHERE Salary BETWEEN 500000 AND 600000;
GO

-- =========================================================
-- PART C: ADVANCED PROJECTDETAIL QUESTIONS 1-20
-- =========================================================

-- 1. Get all ProjectDetail records
SELECT * FROM ProjectDetail;

-- 2. Department-wise total salary
SELECT Department, SUM(Salary) AS TotalSalary
FROM EmployeeDetail
GROUP BY Department;

-- 3. Department-wise total salary, ascending
SELECT Department, SUM(Salary) AS TotalSalary
FROM EmployeeDetail
GROUP BY Department
ORDER BY TotalSalary ASC;

-- 4. Department-wise total salary, descending
SELECT Department, SUM(Salary) AS TotalSalary
FROM EmployeeDetail
GROUP BY Department
ORDER BY TotalSalary DESC;

-- 5. Department, employee count and total salary
SELECT Department,
       COUNT(*) AS TotalEmployees,
       SUM(Salary) AS TotalSalary
FROM EmployeeDetail
GROUP BY Department;

-- 6. Department-wise average salary, ascending
SELECT Department, AVG(Salary) AS AverageSalary
FROM EmployeeDetail
GROUP BY Department
ORDER BY AverageSalary ASC;

-- 7. Department-wise maximum salary, ascending
SELECT Department, MAX(Salary) AS MaximumSalary
FROM EmployeeDetail
GROUP BY Department
ORDER BY MaximumSalary ASC;

-- 8. Department-wise minimum salary, ascending
SELECT Department, MIN(Salary) AS MinimumSalary
FROM EmployeeDetail
GROUP BY Department
ORDER BY MinimumSalary ASC;

-- 9. The PDF repeats the minimum-salary question in item 9.
-- Repeated exactly as written:
SELECT Department, MIN(Salary) AS MinimumSalary
FROM EmployeeDetail
GROUP BY Department
ORDER BY MinimumSalary ASC;

-- 10. Join both tables on EmployeeID
SELECT e.EmployeeID, e.FirstName, e.LastName,
       p.ProjectDetailID, p.ProjectName
FROM EmployeeDetail AS e
INNER JOIN ProjectDetail AS p
    ON e.EmployeeID = p.EmployeeDetailID;

-- 11. Employee name and project for employees who have assigned projects
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       p.ProjectName
FROM EmployeeDetail AS e
INNER JOIN ProjectDetail AS p
    ON e.EmployeeID = p.EmployeeDetailID
ORDER BY e.FirstName;

-- 12. All employees, including those without an assigned project
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       p.ProjectName
FROM EmployeeDetail AS e
LEFT JOIN ProjectDetail AS p
    ON e.EmployeeID = p.EmployeeDetailID
ORDER BY e.FirstName;

-- 13. All employees; display a message if no project is assigned
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       COALESCE(p.ProjectName, '-No Project Assigned') AS ProjectName
FROM EmployeeDetail AS e
LEFT JOIN ProjectDetail AS p
    ON e.EmployeeID = p.EmployeeDetailID
ORDER BY e.FirstName;

-- 14. All projects, including projects whose EmployeeDetailID has no match
SELECT p.ProjectName, p.EmployeeDetailID,
       CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
FROM ProjectDetail AS p
LEFT JOIN EmployeeDetail AS e
    ON p.EmployeeDetailID = e.EmployeeID
ORDER BY p.ProjectName;

-- 15. Complete records from both tables, retaining unmatched rows (FULL OUTER JOIN)
SELECT e.EmployeeID, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       p.ProjectDetailID, p.ProjectName
FROM EmployeeDetail AS e
FULL OUTER JOIN ProjectDetail AS p
    ON e.EmployeeID = p.EmployeeDetailID;

-- 16. Same FULL OUTER JOIN requirement is repeated in the PDF
SELECT e.EmployeeID, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       p.ProjectDetailID, p.ProjectName
FROM EmployeeDetail AS e
FULL OUTER JOIN ProjectDetail AS p
    ON e.EmployeeID = p.EmployeeDetailID;

-- 17. Same FULL OUTER JOIN requirement is repeated again in the PDF
SELECT e.EmployeeID, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       p.ProjectDetailID, p.ProjectName
FROM EmployeeDetail AS e
FULL OUTER JOIN ProjectDetail AS p
    ON e.EmployeeID = p.EmployeeDetailID;

-- 18. Employee(s) assigned more than one project
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       COUNT(p.ProjectDetailID) AS ProjectCount
FROM EmployeeDetail AS e
INNER JOIN ProjectDetail AS p
    ON e.EmployeeID = p.EmployeeDetailID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(p.ProjectDetailID) > 1;

-- 19. Project name with more than one employee assigned, including employee names
SELECT p.ProjectName,
       STRING_AGG(CONCAT(e.FirstName, ' ', e.LastName), ', ') AS EmployeeNames,
       COUNT(DISTINCT e.EmployeeID) AS EmployeeCount
FROM ProjectDetail AS p
INNER JOIN EmployeeDetail AS e
    ON p.EmployeeDetailID = e.EmployeeID
GROUP BY p.ProjectName
HAVING COUNT(DISTINCT e.EmployeeID) > 1;

-- 20. CROSS JOIN: every employee paired with every project
SELECT e.EmployeeID,
       CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       p.ProjectDetailID, p.ProjectName
FROM EmployeeDetail AS e
CROSS JOIN ProjectDetail AS p;

