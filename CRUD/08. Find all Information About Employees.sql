SELECT EmployeeID, FirstName, LastName, MiddleName, JobTitle, DepartmentID, ManagerID, HireDate, Salary, AddressID
FROM Employees
WHERE(JobTitle = 'Sales Representative')