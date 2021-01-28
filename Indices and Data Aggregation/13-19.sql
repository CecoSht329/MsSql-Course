USE SoftUni
GO
--13. Departments Total Salaries
SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--14. Employees Minimum Salaries
SELECT DepartmentID, MIN(Salary) AS MinimumSalary FROM Employees
WHERE DepartmentID IN (2, 5, 7) AND HireDate > '01/01/2000'
GROUP BY DepartmentID

--15. Employees Average Salaries
SELECT * INTO EmplyeesWithHighSalaries FROM Employees
WHERE Salary > 30000 

DELETE FROM EmplyeesWithHighSalaries 
WHERE ManagerID = 42

UPDATE EmplyeesWithHighSalaries 
SET Salary += 5000
WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM EmplyeesWithHighSalaries
GROUP BY DepartmentID

--16. Employees Maximum Salaries
SELECT DepartmentID,MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--17. Employees Count Salaries
SELECT COUNT(Salary) AS [Count] FROM Employees
WHERE ManagerID IS NULL

--18. *3rd Highest Salary
SELECT DepartmentID, Salary AS ThirdHighestSalary FROM
(SELECT DepartmentID,
	Salary,
	DENSE_RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC)  AS SalaryRank
	FROM Employees
	GROUP BY DepartmentID, Salary) AS SalaryRankings
	WHERE SalaryRank = 3

--19. **Salary Challenge
SELECT TOP(10) e1.FirstName, 
       e1.LastName,
       e1.DepartmentID 
FROM Employees AS e1
WHERE e1.Salary > (SELECT 
						  AVG(Salary) AS AverageSalary FROM Employees AS e2
						  WHERE e2.DepartmentID = e1.DepartmentID
                         GROUP BY DepartmentID) 
						 ORDER BY DepartmentID 