--11.	Get Colonists Count
CREATE FUNCTION udf_GetColonistsCount(@planetName VARCHAR (30))
RETURNS INT 
AS 
BEGIN 
RETURN(
	SELECT COUNT(*) FROM Planets as p
	JOIN Spaceports AS sp ON sp.PlanetId = p.Id
	JOIN Journeys AS j ON j.DestinationSpaceportId = sp.Id
	JOIN TravelCards AS tc ON tc.JourneyId = j.Id
	JOIN Colonists as c ON tc.ColonistId = c.Id
	WHERE p.Name = @planetName)
END

--12.	Change Journey Purpose
GO
CREATE PROCEDURE usp_ChangeJourneyPurpose(@JourneyId INT , @NewPurpose VARCHAR(11))
AS 
BEGIN
	IF(NOT EXISTS(SELECT * FROM Journeys WHERE Id = @JourneyId))
		THROW 50001, 'The journey does not exist!', 1

	DECLARE @currentPurpose VARCHAR(11) = (SELECT Purpose FROM Journeys WHERE Id = @JourneyId)

	IF(@currentPurpose = @NewPurpose)
		THROW 50002, 'You cannot change the purpose!', 1

	UPDATE Journeys 
		SET Purpose = @NewPurpose
		WHERE ID = @JourneyId
END