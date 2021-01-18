USE TableRelations

CREATE TABLE Manufacturers(
	ManufacturerID INT PRIMARY KEY IDENTITY NOT NULL,
	Name NVARCHAR(50) NOT NULL,
	EstablishedOn DATETIME2
)

CREATE TABLE Models(
	ModelID INT PRIMARY KEY IDENTITY NOT NULL,
	Name NVARCHAR(50),
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)