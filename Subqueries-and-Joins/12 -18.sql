USE Geography

GO 

--12. Highest Peaks in Bulgaria
SELECT c.CountryCode,
	m.MountainRange,
	p.PeakName,
	p.Elevation
	FROM MountainsCountries AS mc
	JOIN Countries AS c
	ON mc.CountryCode = c.CountryCode
	JOIN Mountains AS m
	ON mc.MountainId = m.Id
	JOIN Peaks AS p
	ON p.MountainId = m.Id
	WHERE c.CountryCode = 'BG' AND p.Elevation > 2835
	ORDER BY p.Elevation DESC

--13. Count Mountain Ranges
SELECT CountryCode,
	COUNT(MountainId) AS MountainRanges
	FROM MountainsCountries
	WHERE CountryCode IN ('BG', 'RU', 'US')
	GROUP BY CountryCode

--14. Countries With or Without Rivers
SELECT TOP(5) c.CountryName,
	r.RiverName
	FROM Countries AS  c
	LEFT OUTER JOIN CountriesRivers AS cr
	ON c.CountryCode = cr.CountryCode
	LEFT OUTER JOIN Rivers AS r
	ON cr.RiverId = r.Id
	WHERE c.ContinentCode = 'AF'
	ORDER BY c.CountryName ASC

--15. Continents and Currencies
  SELECT ContinentCode,  CurrencyCode, CurrencyCount AS CurrencyUsage FROM(
			SELECT ContinentCode,
                CurrencyCode,
                CurrencyCount,
         	   DENSE_RANK() OVER(PARTITION BY ContinentCode ORDER BY CurrencyCount DESC) AS CurrencyRank
         	   FROM(SELECT  ContinentCode,
         			 CurrencyCode,
         			 COUNT(*) AS CurrencyCount
         	          FROM Countries
         	GROUP BY ContinentCode, CurrencyCode) 
         	AS CurrencyCountQuery
         	WHERE CurrencyCount > 1
			) AS CurrencyRankingQuery
			WHERE CurrencyRank = 1

--16. Countries Without any Mountains
SELECT COUNT(CountryName) AS [Count]
	FROM Countries AS c
	LEFT OUTER JOIN MountainsCountries AS mc
	ON c.CountryCode = mc.CountryCode
	WHERE mc.MountainId IS NULL

--17. Highest Peak and Longest River by Country
SELECT TOP(5) CountryName,
MAX(p.Elevation) AS HighestPeakElevation,
MAX(r.Length) AS LongestRiverLength FROM Countries AS c
LEFT OUTER JOIN CountriesRivers AS cr
ON cr.CountryCode = c.CountryCode
LEFT OUTER JOIN Rivers AS r
ON cr.RiverId = r.Id
LEFT OUTER JOIN MountainsCountries AS mc
ON c.CountryCode = mc.CountryCode
LEFT OUTER JOIN Mountains AS m
ON mc.MountainId = m.Id
LEFT OUTER JOIN Peaks AS p
ON p.MountainId = m.Id
GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, CountryName ASC

--18. Highest Peak Name and Elevation by Country
SELECT TOP(5) Country,
       CASE 
	     WHEN PeakName IS NULL THEN 'no highest peak'
		 ELSE PeakName
		END AS [Highest Peak Name],
	    CASE 
		   WHEN Elevation IS NULL THEN 0
		   ELSE Elevation 
		END AS [[Highest Peak Elevation], 
       CASE 
			WHEN MountainRange IS NULL THEN '(no mountain)'
			ELSE MountainRange
		END AS Mountain
       FROM (SELECT * ,
              DENSE_RANK()  OVER	
	          (PARTITION BY [Country] ORDER BY Elevation DESC) AS PeakRank
              FROM(
              SELECT CountryName AS Country,
			            p.PeakName,
						p.Elevation,
						m.MountainRange
			  FROM Countries AS c
              LEFT OUTER JOIN MountainsCountries AS mc
              ON c.CountryCode = mc.CountryCode
              LEFT OUTER JOIN Mountains AS m
              ON mc.MountainId = m.Id
              LEFT OUTER JOIN Peaks AS p
              ON p.MountainId = m.Id
			  ) AS [FullInfoQuery]
			  ) AS [PeakRankingsQuery]
WHERE PeakRank = 1 
ORDER BY Country ASC, [Highest Peak Name] ASC