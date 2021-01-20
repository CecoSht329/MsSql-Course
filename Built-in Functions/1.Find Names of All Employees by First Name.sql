/****** Script for SelectTopNRows command from SSMS  ******/
USE SoftUni

SELECT FirstName, LastName 
	FROM Employees 
	WHERE FirstName LIKE 'SA%'
