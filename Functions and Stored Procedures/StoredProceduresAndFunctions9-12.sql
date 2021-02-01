USE Bank
--09. Find Full Name
GO

CREATE PROCEDURE usp_GetHoldersFullName
AS
BEGIN
	SELECT CONCAT(FirstName, ' ', LastName) AS [Full Name]
	FROM AccountHolders 
END

EXEC usp_GetHoldersFullName

--10. People with Balance Higher Than
GO

CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan(@number DECIMAL(18,2))
AS 
BEGIN
	   SELECT FirstName, LastName FROM (
	                   SELECT ah.FirstName AS FirstName, ah.LastName AS LastName, SUM(a.Balance) AS [Total Balance]
	                   FROM AccountHolders AS ah
	                   JOIN Accounts AS a ON ah.Id = a.AccountHolderId
	                   GROUP BY ah.FirstName, ah.LastName
				     ) AS NamesAndBalances
	   WHERE [Total Balance] > @number
	   ORDER BY FirstName ASC, LastName
END

EXEC usp_GetHoldersWithBalanceHigherThan 100

--11. Future Value Function
GO

CREATE FUNCTION ufn_CalculateFutureValue(@sum DECIMAL(18,4), @yir FLOAT, @yearsCount INT)
RETURNS DECIMAL(18,4)
AS
BEGIN
	DECLARE @futureValue DECIMAL(18,4)

	SET @futureValue = @sum * (POWER((1 + @yir), @yearsCount));

	RETURN @futureValue;
END 

SELECT [dbo].[ufn_CalculateFutureValue](1000, 0.1, 5)