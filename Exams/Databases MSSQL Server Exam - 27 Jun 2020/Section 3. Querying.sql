SELECT 
CONCAT(FirstName, ' ', LastName) AS Mechanic,
j.[Status],
j.IssueDate
 FROM Mechanics AS m
JOIN Jobs AS j ON m.MechanicId = j.MechanicId
ORDER BY m.MechanicId, j.IssueDate, j.JobId


SELECT 
CONCAT(c.FirstName, ' ', c.LastName) AS Client,
DATEDIFF(DAY, IssueDate, '2017-04-24') AS [Days going],
j.[Status]
FROM Clients AS c
JOIN Jobs AS j ON c.ClientId = j.ClientId
WHERE j.[Status] <> 'Finished'


SELECT 
CONCAT(m.FirstName, ' ', LastName) AS Mechanic,
AVG(DATEDIFF(DAY, j.IssueDate, j.FinishDate)) AS [Average Days]
FROM Mechanics AS m
JOIN Jobs AS j ON m.MechanicId = j.MechanicId
GROUP BY m.MechanicId,FirstName, LastName
ORDER BY m.MechanicId

--8.	Available Mechanics
SELECT CONCAT(m.FirstName, ' ', LastName) AS Available
	FROM Mechanics AS m
	LEFT JOIN Jobs AS j ON j.MechanicId = m.MechanicId
	WHERE j.JobId IS NULL OR (	SELECT COUNT(JobId)
	FROM Jobs
	WHERE [Status] <> 'Finished' AND MechanicId = m.MechanicId	
	GROUP BY MechanicId, [Status]) IS NULL
	GROUP BY m.MechanicId, FirstName, LastName


	--9.	Past Expenses
SELECT j.JobId, ISNULL(SUM(p.Price * op.Quantity), 0) AS TotalPrice
FROM Jobs AS j
  LEFT JOIN Orders  AS o ON j.JobId = o.JobId
  LEFT JOIN OrderParts AS op ON op.OrderId = o.OrderId
  LEFT JOIN Parts AS p ON p.PartId = op.PartId
WHERE [Status] = 'Finished'
GROUP BY j.JobId
ORDER BY TotalPrice DESC, j.JobId

--10.	Missing Parts
SELECT p.PartId,
       p.[Description],
       pn.Quantity AS [Required],
       p.StockQty AS [In Stock],
	  IIF(o.Delivered = 0, op.Quantity, 0) AS Ordered
	FROM Parts AS p
	LEFT JOIN PartsNeeded AS pn ON pn.PartId = p.PartId
	LEFT JOIN OrderParts AS op ON op.PartId = p.PartId
	LEFT JOIN Jobs AS j ON j.JobId = pn.JobId
LEFT	JOIN Orders AS o ON o.JobId = j.JobId
WHERE j.[Status] != 'Finished'  AND		p.StockQty +   IIF(o.Delivered = 0, op.Quantity, 0) < pn.Quantity
ORDER BY p.PartId
