CREATE DATABASE Movies 


USE Movies
CREATE TABLE Directors(
       Id INT PRIMARY KEY IDENTITY NOT NULL,
	   DirectorName NVARCHAR(50) NOT NULL, 
	   Notes NVARCHAR(MAX) 
)

INSERT INTO Directors(DirectorName,Notes)
     VALUES
	      ('PeshoDirektora', 'ttwwt	we'),
		  ('PeshoZamDirektora' , NULL),
		  ('GoshoZamDirektora' , NULL),
		  ('HasanZamDirektora' , NULL),
		  ('PavelZamDirektora' , NULL)

CREATE TABLE Genres (
      Id INT PRIMARY KEY IDENTITY NOT NULL,
	  GenreName NVARCHAR(50) NOT NULL, 
	  Notes NVARCHAR(MAX) 
)

INSERT INTO Genres(GenreName,Notes)
     VALUES
	      ('Horror', 'nema'),
		  ('Comedy' , NULL),
		  ('Romatic' , NULL),
		  ('Adventure' , NULL),
		  ('Cartoon' , NULL)

CREATE TABLE Categories  (
      Id INT PRIMARY KEY IDENTITY NOT NULL,
	  CategoryName NVARCHAR(50) NOT NULL, 
	  Notes NVARCHAR(MAX) 
)

INSERT INTO Categories(CategoryName,Notes)
     VALUES
	      ('HorrorMovies', 'nema'),
		  ('ComedyMovies' , NULL),
		  ('RomaticMovies' , NULL),
		  ('AdventureMovies' , NULL),
		  ('CartoonMovies' , NULL)

CREATE TABLE Movies  (
      Id INT PRIMARY KEY IDENTITY NOT NULL,
	  Title NVARCHAR(20) NOT NULL , 
	  DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
	  CopyrightYear SMALLINT NOT NULL,
	  [Length] FLOAT NOT NULL,
	  GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
	  CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL, 
	  Rating FLOAT NOT NULL, 
	  Notes NVARCHAR(MAX)
)

INSERT INTO Movies(Title,DirectorId,CopyrightYear,[Length],GenreId,CategoryId,Rating,Notes)
     VALUES
	      ('ŒÚÌÂÒÂÌË ÓÚ ‚Ëı˙‡', 1,1978,2.50,3,3,2.8,'Õ≈Ã¿'),
		  ('ALIEN', 2,1988,1.50,2,2,5.8,NULL),
		  ('TOZI', 3,1908,2.25,3,3,2.2,'Õ≈Ã¿ lsjdbvljBDSF;Lvfb'),
		  ('I robot', 1,2078,1.50,4,4,2.8,'Õ≈Ã¿'),
		  ('WORLD WAR Z', 1,1560,2.50,3,3,2.8,'Õ≈Ã¿')

TRUNCATE TABLE 	Movies	  
DROP TABLE 	Movies

SELECT * FROM Directors
SELECT * FROM Genres
SELECT * FROM Categories
SELECT * FROM Movies