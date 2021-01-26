USE SoftUni

GO
--01. Employee Address
SELECT TOP(5) e.EmployeeId,
	   e.JobTitle,
	   e.AddressId,
	   a.AddressText
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	ORDER BY AddressID ASC

--02. Addresses with Towns
SELECT TOP(50) e.FirstName,
       e.LastName,
	   t.[Name],
	   a.AddressText
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	ORDER BY e.FirstName, e.LastName  ASC
	
--03. Sales Employees
SELECT e.EmployeeID,
	   e.FirstName,
       e.LastName,
	   d.[Name] AS DepartmentName
	FROM Employees AS e
	JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
	WHERE(d.[Name] = 'Sales')

	
--04. Employee Departments

SELECT TOP(5) e.EmployeeID,
	   e.FirstName,
	   e.Salary,
	   d.[Name] AS DepartmentName
	FROM Employees AS e
	JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
	WHERE  e.Salary > 15000 
	ORDER BY d.DepartmentID ASC

--05. Employees Without Projects
SELECT TOP(3) e.EmployeeID,
	e.FirstName
	FROM Employees AS e
	LEFT OUTER JOIN EmployeesProjects AS ep 
	ON ep.EmployeeID = e.EmployeeID
	WHERE ep.EmployeeID IS NULL

--06. Employees Hired After
SELECT e.FirstName,
	e.LastName,
	e.HireDate,
	d.[Name]
	FROM Employees AS e
	JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
	WHERE HireDate > '1.1.1999' AND (d.[Name] = 'Sales' OR d.[Name] = 'Finance')

--07. Employees With Project
SELECT TOP(5) e.EmployeeID,
	e.FirstName,
	p.[Name] AS ProjectName
	FROM Employees AS e
	JOIN EmployeesProjects AS ep 
	ON ep.EmployeeID = e.EmployeeID
	LEFT OUTER JOIN Projects AS p
	ON p.ProjectID = ep.ProjectID
	WHERE p.StartDate > '08.13.2002' AND p.EndDate IS NULL
	ORDER BY e.EmployeeID ASC

--08. Employee 24
SELECT e.EmployeeID,
	e.FirstName,
	CASE 
		WHEN 
		YEAR(p.StartDate) >= 2005 THEN NULL
		ELSE P.[Name] 
	END	AS ProjectName
	FROM Employees AS e
	JOIN EmployeesProjects AS ep
	ON e.EmployeeID = ep.EmployeeID
	JOIN Projects AS p
	ON p.ProjectID = ep.ProjectID
	WHERE e.EmployeeID = 24 
	

--09. Employee Manager
SELECT e1.EmployeeID,
	e1.FirstName,
	e1.ManagerID,
	e2.FirstName AS ManagerName
	FROM Employees AS e1
	LEFT OUTER JOIN Employees AS e2
	ON e1.ManagerID = e2.EmployeeID
	WHERE e1.ManagerID = 3 OR e1.ManagerID = 7
	ORDER BY e1.EmployeeID ASC

--10. Employees Summary
SELECT TOP(50) e1.EmployeeID,
	CONCAT(e1.FirstName, ' ', e1.LastName) AS EmployeeName,
	CONCAT(e2.FirstName, ' ', e2.LastName) AS ManagerName,
	d.[Name] AS DepartmentName
	FROM Employees AS e1
	LEFT OUTER JOIN Employees AS e2
	ON e1.ManagerID = e2.EmployeeID
	JOIN Departments AS d
	ON e1.DepartmentID = d.DepartmentID
	ORDER BY e1.EmployeeID


--11. Min Average Salary
SELECT TOP(1) AVG(Salary) AS MinAverageSalary FROM Employees 
GROUP BY DepartmentID
ORDER BY MinAverageSalary ASC
	