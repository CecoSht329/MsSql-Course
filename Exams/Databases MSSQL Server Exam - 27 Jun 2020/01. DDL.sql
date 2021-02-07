CREATE DATABASE WMS

USE WMS
GO

CREATE TABLE Clients(
	ClientId INT PRIMARY KEY IDENTITY NOT NULL, 
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Phone VARCHAR(12) CHECK(LEN(Phone) = 12) NOT NULL
)


CREATE TABLE Mechanics(
	MechanicId INT PRIMARY KEY IDENTITY NOT NULL, 
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	[Address] VARCHAR(255) NOT NULL
)

CREATE TABLE Models(
	ModelId INT PRIMARY KEY IDENTITY NOT NULL, 
	[Name] VARCHAR(50) UNIQUE
)

CREATE TABLE Jobs(
	JobId INT PRIMARY KEY IDENTITY NOT NULL, 
	ModelId INT FOREIGN KEY REFERENCES Models(ModelId),
	[Status] VARCHAR(11) DEFAULT('Pending') 
	CHECK([Status] = 'Pending' OR [Status] = 'In Progress' OR [Status] =  'Finished' ),
	ClientId INT FOREIGN KEY REFERENCES Clients(ClientId),
	MechanicId INT FOREIGN KEY REFERENCES Mechanics(MechanicId),
	IssueDate DATE NOT NULL,
	FinishDate DATE
)

CREATE TABLE Orders(
	OrderId INT PRIMARY KEY IDENTITY NOT NULL, 
	JobId INT FOREIGN KEY REFERENCES Jobs(JobId),
	IssueDate DATE,
	Delivered BIT DEFAULT 0 CHECK(Delivered = 0 OR Delivered = 1)
)

CREATE TABLE Vendors(
	VendorId INT PRIMARY KEY IDENTITY NOT NULL, 
	[Name] VARCHAR(50) UNIQUE
)

CREATE TABLE Parts(
	PartId INT PRIMARY KEY IDENTITY NOT NULL, 
	SerialNumber VARCHAR(50) UNIQUE,
	[Description] VARCHAR(255),
	Price DECIMAL CHECK(Price > 0 OR Price <= 9999.99),
	VendorId INT FOREIGN KEY REFERENCES Vendors(VendorId),
	StockQty INT DEFAULT 0 CHECK(StockQty >= 0)
)

CREATE TABLE OrderParts(
	OrderId INT FOREIGN KEY REFERENCES Orders(OrderId)  NOT NULL, 
	PartId  INT FOREIGN KEY REFERENCES Parts(PartId) NOT NULL, 
	Quantity INT DEFAULT 1 CHECK(Quantity > 0)
	CONSTRAINT PK_OrderPartsId PRIMARY KEY (OrderId, PartId)
)

CREATE TABLE PartsNeeded(
	JobId INT FOREIGN KEY REFERENCES Jobs(JobId),
	PartId INT FOREIGN KEY REFERENCES Parts(PartId),
	Quantity INT DEFAULT 1 CHECK(Quantity > 0)
	CONSTRAINT PK_PartsNeededId PRIMARY KEY (JobId, PartId)
)

EXEC sp_changedbowner 'sa'