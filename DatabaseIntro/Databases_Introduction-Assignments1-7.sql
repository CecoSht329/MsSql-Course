--1.Create Database
CREATE DATABASE Minions

--2.Create Tables
USE Minions
CREATE TABLE Minions(
     Id INT NOT NULL PRIMARY KEY,
	 [Name] NVARCHAR(50) NOT NULL,
	 Age INT 
)

CREATE TABLE Towns(
     Id INT NOT NULL PRIMARY KEY,
	 [Name] NVARCHAR(50) NOT NULL,
)

--3.Alter Minions Table
USE Minions
ALTER TABLE Minions
ADD TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL

--4.Insert Records in Both Tables
INSERT INTO Towns(Id,[Name])
     VALUES
	       (1,'Sofia'),
		   (2,'Plovdiv'),
		   (3,'Varna')


INSERT INTO Minions(Id,[Name],Age,TownId)
     VALUES
	       (1,'Kevin',22,1),
		   (2,'Bob',15,3),
		   (3,'Steward',NULL,2)

SELECT * FROM Towns
SELECT * FROM Minions

--5.Truncate Table Minions
TRUNCATE TABLE Minions

--6.Drop All Tables
DROP TABLE Minions
DROP TABLE Towns

--7.Create Table People
USE Minions
CREATE TABLE People(
           Id BIGINT PRIMARY KEY IDENTITY NOT NULL,
		   [Name] NVARCHAR(200) NOT NULL,
		   Picture VARBINARY(MAX)
		   CHECK(DATALENGTH(Picture) <= 2 * 1048576),
		   Height FLOAT,
		   Weight FLOAT,
		   Gender CHAR(1) 
		   CONSTRAINT CHK_Person CHECK(Gender = 'm' OR Gender = 'f') NOT NULL,
		   Birthdate DATETIME2 NOT NULL,
		   Biography NVARCHAR(MAX)
)

INSERT INTO People([Name],Picture,Height,[Weight],Gender,Birthdate,Biography)
    VALUES
	     ('Pesho',NULL,1.80,98.22,'m','01.12.2001','asdasgfagfa'),
		  ('Milka',NULL,1.24,98.25,'f','01.12.2901',NULL),
		   ('BaiAmet',NULL,NULL,NULL,'m','01.12.1801','saglSLJFBlgbWJGLBrwglbWRGBrgBGR'),
		    ('Kuncho',NULL,1.50,105.15,'m','01.12.2066',NULL),
			 ('Petia',NULL,1.80,98.22,'f','01.12.2001',NULL)

SELECT * FROM People

TRUNCATE TABLE People