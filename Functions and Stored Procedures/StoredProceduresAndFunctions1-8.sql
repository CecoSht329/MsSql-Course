USE SoftUni

GO
--01. Employees with Salary Above 35000
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS 
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary > 35000
END

EXEC usp_GetEmployeesSalaryAbove35000

--02. Employees with Salary Above Number
GO

CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber(@number DECIMAL(18,4))
AS
BEGIN
	SELECT FirstName ,LastName 
	FROM Employees
	WHERE Salary >= @number
END

EXEC usp_GetEmployeesSalaryAboveNumber 48100

--03. Town Names Starting With
GO

CREATE PROCEDURE usp_GetTownsStartingWith(@StartLetter VARCHAR(50))
AS
BEGIN
	SELECT [Name] 
	FROM Towns
	WHERE [Name] LIKE @StartLetter + '%'
END

EXEC usp_GetTownsStartingWith 'DU'

--04. Employees from Town
GO

CREATE PROCEDURE usp_GetEmployeesFromTown(@townName VARCHAR(50))
AS
BEGIN
	SELECT e.FirstName, e.LastName 
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	WHERE t.[Name] = @townName
END

EXEC usp_GetEmployeesFromTown 'Sofia'

--05. Salary Level Function
GO

CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(7) 
AS 
BEGIN
	DECLARE @salaryLevel VARCHAR(7);

	IF (@salary < 30000) 
	BEGIN 
		SET @salaryLevel = 'Low';
	END
	ELSE IF (@salary >= 30000 AND @salary <= 50000)
	BEGIN
		SET @salaryLevel = 'Average'; 
	END
	ELSE
	BEGIN
		SET @salaryLevel = 'High';
	END

	RETURN @salaryLevel;
END


GO 

SELECT  Salary,
dbo.ufn_GetSalaryLevel(Salary) AS [Salary Level]
FROM Employees

--06. Employees by Salary Level
GO

CREATE PROCEDURE usp_EmployeesBySalaryLevel(@salaryLevel VARCHAR(7))
AS
BEGIN 
	SELECT FirstName, LastName FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @salaryLevel
END

EXEC usp_EmployeesBySalaryLevel 'High'

--07. Define Function
GO

CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX))
RETURNS BIT
AS 
BEGIN
	DECLARE @i INT = 1;

	WHILE(@i <= LEN(@word))
	BEGIN 
		DECLARE @currentChar CHAR = SUBSTRING(@word, @i, 1);
		DECLARE @charIndex INT = CHARINDEX(@currentChar, @setOfLetters);

		IF	(@charIndex = 0)
		BEGIN 
			RETURN 0;
		END

		SET @i = @i + 1;
	END

	RETURN 1;
END

GO 

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'halves')

--08. Delete Employees and Departments

CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
BEGIN
	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN (
							SELECT EmployeeID FROM Employees
							WHERE DepartmentID = @departmentId
						)

	UPDATE Employees 
	SET ManagerID = NULL
	WHERE ManagerID IN (
							SELECT EmployeeID FROM Employees
							WHERE DepartmentID = @departmentId
						)

	ALTER TABLE Departments
	ALTER COLUMN ManagerId INT 


	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN (
							SELECT EmployeeID FROM Employees
							WHERE DepartmentID = @departmentId
						)

	DELETE FROM Employees 
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId

	SELECT COUNT(*) FROM Employees
	WHERE DepartmentID = @departmentId
END