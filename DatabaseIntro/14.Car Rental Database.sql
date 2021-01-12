CREATE DATABASE CarRental

USE CarRental
CREATE TABLE Categories(
       Id INT PRIMARY KEY IDENTITY NOT NULL,
       CategoryName NVARCHAR(50) NOT NULL,
       DailyRate INT,
       WeeklyRate INT,
       MonthlyRate INT,
       WeekendRate INT
)

INSERT INTO Categories(CategoryName,DailyRate,WeeklyRate,MonthlyRate,WeekendRate)
   VALUES
        ('JEEP',NULL,NULL,NULL,NULL),
		 ('COMBY',NULL,NULL,NULL,NULL),
		  ('SEDAN',NULL,NULL,NULL,NULL)

CREATE TABLE Cars(
       Id INT PRIMARY KEY IDENTITY NOT NULL,
       PlateNumber NVARCHAR(10) NOT NULL,
       Manufacturer NVARCHAR(50) NOT NULL,
       Model NVARCHAR(50) NOT NULL,
       CarYear INT NOT NULL,
       CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
	   Doors SMALLINT,
	   Picture VARBINARY(MAX)
	   CHECK(DATALENGTH(Picture) <= 2 * 1048576),
	   Condition NVARCHAR(10) NOT NULL,
	   Available BIT NOT NULL
)

INSERT INTO Cars(PlateNumber,Manufacturer,Model,CarYear,CategoryId,Doors,Picture,Condition,Available)
   VALUES
        ('AE23456','TOYOTA','TOZIMODEL',2016,2,NULL,NULL,'BASHSHUKAR',1),
		 ('CO4928672','LADA','SEDAN',1974,3,5,NULL,'BASHSHUKAR',0),
		  ('BT18489912','MOSKVICH','PATLAJAN',1958,1,NULL,NULL,'BASHSHUKAR',1)

CREATE TABLE Employees (
      Id INT PRIMARY KEY IDENTITY NOT NULL,
	  FirstName NVARCHAR(50) NOT NULL,
	  LastName NVARCHAR(50) NOT NULL,
	  Title NVARCHAR(50) NOT NULL,
	  Notes NVARCHAR(MAX)
)

INSERT INTO Employees(FirstName,LastName,Title,Notes)
   VALUES
        ('CVETAN', 'CVETANOV', 'MECHANIC', 'SIMPLY THE BEST'),
		    ('PESHO', 'PESHEV', 'JUNIOR MECHANIC', 'NO SO GOOD'),
			    ('GOSHO', 'GOSHEV', 'SENIOR MECHANIC', NULL)
		 

CREATE TABLE Customers (
      Id INT PRIMARY KEY IDENTITY NOT NULL,
	  DriverLicenceNumber NVARCHAR(8) NOT NULL,
	  FullName NVARCHAR(50) NOT NULL,
	  [Address] NVARCHAR(50) NOT NULL,
	  City NVARCHAR(50) NOT NULL,
	  ZIPCode NVARCHAR(10),
	  Notes NVARCHAR(MAX)
)

INSERT INTO Customers(DriverLicenceNumber,FullName,[Address],City,ZIPCode,Notes)
   VALUES
        ('604506', 'BASHAR RAHAL ', 'OVHA KUPEL 15', 'SOFIA', NULL, NULL),
		('604306', 'LUBEN LUBENOV ', 'REDUTA 15', 'SOFIA', NULL, NULL),
		('6045406', 'ONZI ONZEV', 'OVHA KUPEL 125', 'SOFIA', 'G4352', 'TEtrt')
		

CREATE TABLE RentalOrders (
     Id INT PRIMARY KEY IDENTITY NOT NULL,
	 EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	 CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
	 CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
	 TankLevel FLOAT NOT NULL,
	 KilometrageStart INT,
	 KilometrageEnd INT,
	 TotalKilometrage INT,
	 StartDate DATETIME2,
	 EndDate DATETIME2,
	 TotalDays SMALLINT,
	 RateApplied FLOAT,
	 TaxRate DEC,
	 OrderStatus BIT NOT NULL,
	 Notes NVARCHAR(250)
)

INSERT INTO RentalOrders(EmployeeId,CustomerId,CarId,TankLevel,KilometrageStart,KilometrageEnd,
TotalKilometrage,StartDate,EndDate,TotalDays,RateApplied,TaxRate,OrderStatus,Notes)
   VALUES
        (1,2, 3, 2.5, NULL, NULL,NULL, NULL,NULL, NULL,NULL, NULL,0,NULL),
		(2,3, 1, 4.5, NULL, NULL,NULL, NULL,NULL, NULL,NULL, NULL,1,NULL),
		(3,1, 2, 3.5, NULL, NULL,NULL, NULL,NULL, NULL,NULL, NULL,0,NULL)
		
SELECT * FROM Categories
SELECT * FROM Cars
SELECT * FROM Employees
SELECT * FROM Customers
SELECT * FROM RentalOrders
