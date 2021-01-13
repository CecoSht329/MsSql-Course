CREATE DATABASE Hotel

USE Hotel
CREATE TABLE Employees(
         Id INT PRIMARY KEY IDENTITY NOT NULL, 
		 FirstName NVARCHAR(50) NOT NULL,
		 LastName NVARCHAR(50) NOT NULL,
		 Title NVARCHAR(20) NOT NULL,
		 Notes NVARCHAR(250)
)

INSERT INTO Employees(FirstName,LastName,Title)
    VALUES
        ('PESHO','PESHEV','BELL'),
		  ('PESHO0','PESHEV0','BELL1'),
		    ('PESHO1','PESHEV1','BELL2')


CREATE TABLE Customers (
       AccountNumber NVARCHAR(15) PRIMARY KEY NOT NULL,
	   FirstName NVARCHAR(50) NOT NULL, 
	   LastName NVARCHAR(50) NOT NULL, 
	   PhoneNumber NVARCHAR(10) NOT NULL,
	   EmergencyName NVARCHAR(50),
	   EmergencyNumber NVARCHAR(10),
	   Notes NVARCHAR(250)
)

INSERT INTO Customers(AccountNumber,FirstName,LastName,PhoneNumber)
    VALUES
        ('BGN1234567','GOSHO','GESHEV','0123456789'),
		  ('BGN1234576','GOSHO0','GESHEV0','0223456789'),
		    ('BGN1234579','GOSHO1','GESHEV1','0223456781')

CREATE TABLE RoomStatus(
      RoomStatus NVARCHAR(10) PRIMARY KEY NOT NULL,
      Notes NVARCHAR(250)
)

INSERT INTO RoomStatus(RoomStatus)
    VALUES
        ('TAKEN'),
		  ('AVAILABLE'),
		    ('OCCUPIED')

CREATE TABLE RoomTypes(
      RoomType NVARCHAR(10) PRIMARY KEY NOT NULL,
      Notes NVARCHAR(250)
)
INSERT INTO RoomTypes(RoomType)
    VALUES
        ('GOOD'),
		  ('BAD'),
		    ('UGLY')

CREATE TABLE BedTypes(
      BedType NVARCHAR(10) PRIMARY KEY NOT NULL,
      Notes NVARCHAR(250)
)

INSERT INTO BedTypes(BedType)
    VALUES
        ('NICE'),
		  ('VERY NICE'),
		    ('NOT NICE')


CREATE TABLE Rooms(
    RoomNumber NVARCHAR(4) NOT NULL,
	RoomType NVARCHAR(10) FOREIGN KEY REFERENCES RoomTypes(RoomType)  NOT NULL,
	BedType NVARCHAR(10) FOREIGN KEY REFERENCES BedTypes(BedType)  NOT NULL,
	Rate INT, 
	RoomStatus NVARCHAR(10) FOREIGN KEY REFERENCES RoomStatus(RoomStatus)  NOT NULL,
	Notes NVARCHAR(250)
)

INSERT INTO Rooms(RoomNumber,RoomType,BedType,RoomStatus)
    VALUES
        ('0102','BAD', 'NOT NICE','OCCUPIED'),
		  ('0103', 'GOOD', 'VERY NICE', 'TAKEN'),
		    ('0104', 'UGLY', 'NICE', 'AVAILABLE')

CREATE TABLE Payments(
    Id INT PRIMARY KEY IDENTITY NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
	PaymentDate DATETIME2 NOT NULL,
	AccountNumber NVARCHAR(15) NOT NULL,
	FirstDateOccupied DATETIME2,
	LastDateOccupied DATETIME2,
	TotalDays INT,
	AmountCharged DEC(4,2),
	TaxRate DEC(4,2),
	TaxAmount DEC(4,2),
	PaymentTotal DEC(4,2), 
	Notes NVARCHAR(250)
)

INSERT INTO Payments(EmployeeId,PaymentDate,AccountNumber, TaxRate)
    VALUES
        (1,'01/13/2021', 'TOZINUMBER1',12.05),
		  (2,'01/12/2021', 'TOZINUMBER2',13.05),
		    (3,'01/15/2021', 'TOZINUMBER4',14.05)



SELECT * FROM Payments


CREATE TABLE Occupancies(
    Id INT PRIMARY KEY IDENTITY NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id), 
	DateOccupied DATETIME2, 
	AccountNumber NVARCHAR(15), 
	RoomNumber NVARCHAR(4),
	RateApplied DEC(4,2), 
	PhoneCharge DEC(4,2), 
	Notes NVARCHAR(250)
)


INSERT INTO Occupancies(EmployeeId,DateOccupied,AccountNumber)
    VALUES
        (1,'01/13/2021', 'TOZINUMBER1'),
		  (2,'01/12/2021', 'TOZINUMBER2'),
		    (3,'01/15/2021', 'TOZINUMBER4')

SELECT * FROM Occupancies



--23.Decrease Tax Rate
UPDATE Payments
SET TaxRate -= TaxRate * 0.03

SELECT TaxRate FROM Payments

--24.Delete All Records
DELETE FROM Occupancies