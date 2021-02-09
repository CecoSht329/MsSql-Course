--Section 3. Querying 

--5.	Select all military journeys
SELECT ID, FORMAT(JourneyStart, 'dd/MM/yyyy') AS JourneyStart, FORMAT(JourneyEnd, 'dd/MM/yyyy') AS JourneyEnd FROM Journeys
WHERE Purpose = 'Military'
ORDER BY JourneyStart ASC

--6.	Select all pilots
SELECT c.Id, CONCAT(FirstName, ' ', LastName) AS full_name FROM Colonists AS c
JOIN TravelCards AS tc ON tc.ColonistId = c.Id
WHERE tc.JobDuringJourney = 'Pilot'
ORDER BY c.Id

--7.	Count colonists

SELECT COUNT(ColonistId) AS [count] FROM Journeys AS j
JOIN TravelCards AS tc ON tc.JourneyId = j.Id
JOIN Colonists AS c ON c.Id = tc.ColonistId
WHERE j.Purpose = 'Technical'

--8.	Select spaceships with pilots younger than 30 years
SELECT s.[Name], s.Manufacturer FROM Spaceships AS s
JOIN Journeys AS j ON j.SpaceshipId = s.Id
JOIN TravelCards AS tc ON tc.JourneyId = j.Id
JOIN Colonists AS c ON c.Id = tc.ColonistId
WHERE tc.JobDuringJourney = 'Pilot' AND DATEDIFF(YEAR, c.BirthDate, '2019/01/01') < 30
ORDER BY s.[Name] ASC


--9.	Select all planets and their journey count
SELECT p.[Name] AS PlanetName, COUNT(j.Id) AS JourneysCount  FROM Planets AS p
JOIN Spaceports AS s ON p.Id = s.PlanetId
JOIN Journeys AS j ON s.Id = j.DestinationSpaceportId
GROUP BY p.[Name]
ORDER BY JourneysCount DESC, PlanetName ASC

--10.	Select Second Oldest Important Colonist
SELECT JobDuringJourney, FullName, JobRank FROM(
		SELECT tc.JobDuringJourney,
		CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
		DENSE_RANK() OVER(
		PARTITION BY tc.JobDuringJourney ORDER BY c.BirthDate) AS JobRank
		FROM TravelCards AS tc 
		JOIN Colonists AS c ON c.Id = tc.ColonistId
		) AS MainQuery
		WHERE JobRank = 2 


