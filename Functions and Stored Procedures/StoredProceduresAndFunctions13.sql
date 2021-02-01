USE Diablo
--13. *Cash in User Games Odd Rows
GO

CREATE FUNCTION ufn_CashInUsersGames(@game VARCHAR(50))
RETURNS TABLE
AS 
RETURN SELECT SUM(Cash) AS [SumCash] FROM
				(SELECT g.[Name], 
				ug.Cash,
				ROW_NUMBER() OVER (PARTITION BY g.[Name] ORDER BY ug.Cash DESC) AS [RowNum]
				FROM Games AS g
				JOIN UsersGames AS ug ON g.Id = ug.GameId
				WHERE g.[Name] = @game) AS RowNumQuery
				WHERE RowNum % 2 <> 0




