CREATE TABLE People(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	Birthdate DATETIME2 NOT NULL
)


INSERT INTO People([Name], Birthdate)
	VALUES 
		('Victor', '2000-12-07 00:00:00.000'),
		('Steven', '1992-09-10 00:00:00.000'),
		('Stephen', '1910-09-19 00:00:00.000'),
		('John', '2010-01-06 00:00:00.000')


SELECT [Name], 
(YEAR(GETDATE()) - YEAR(Birthdate)) AS [Age in Years],
((YEAR(GETDATE()) - YEAR(Birthdate)) * 12) AS [Age in Months],
CAST(((YEAR(GETDATE()) - YEAR(Birthdate)) * 365.25) AS INT) AS [Age in Days],
((YEAR(GETDATE()) - YEAR(Birthdate)) * 525960) AS [Age in Minutes]
FROM People
