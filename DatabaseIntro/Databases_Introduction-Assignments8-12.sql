--8.Create Table Users

USE Minions

CREATE TABLE Users(
      Id BIGINT PRIMARY KEY IDENTITY NOT NULL,
	  Username VARCHAR(30) UNIQUE NOT NULL,
	  [Password] VARCHAR(26) NOT NULL,
	  ProfilePicture VARBINARY(MAX)
	  CHECK(DATALENGTH(ProfilePicture) <= 900 * 1024),
	  LastLoginTime DATETIME2 NOT NULL,
	  IsDeleted BIT NOT NULL
)

INSERT INTO Users(Username,[Password],LastLoginTime,IsDeleted)
  VALUES
     ('PAPI',12345,'01.11.2021',0),
	 ('PAPICHA',12345,'01.12.2021',1),
	 ('PAPUNCHO',12345,'01.11.1563',0),
	 ('PONCHO',12345,'01.11.1234',1),
	 ('ONZI',12345,'01.11.2656',0)

SELECT * FROM Users

--9.Change Primary Key
ALTER TABLE Users
DROP CONSTRAINT [PK__Users__3214EC078A285833]

ALTER TABLE Users
ADD CONSTRAINT PK__Users__CompositeIdUsername
PRIMARY KEY(Id,Username)

--10.Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT CK__Users__PasswordLength
CHECK(LEN([Password]) >= 5)

--11.Set Default Value of a Field
ALTER TABLE Users
ADD CONSTRAINT DF__Users__LastLoginTime
DEFAULT GETDATE() FOR LastLoginTime

INSERT INTO Users(Username,[Password],IsDeleted)
  VALUES
     ('PAPIHANSVELIKOLEPNI',12345,0)

--12.Set Unique Field
ALTER TABLE Users
DROP CONSTRAINT PK__Users__CompositeIdUsername

ALTER TABLE Users
ADD CONSTRAINT PK__Users__Id
PRIMARY KEY(Id)