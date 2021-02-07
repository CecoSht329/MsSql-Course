CREATE PROCEDURE usp_PlaceOrder(@jobId INT, @serialNumber VARCHAR(50), @quantity INT)
AS 
BEGIN 
	DECLARE @status VARCHAR(10) = (SELECT [Status] FROM Jobs WHERE JobId = @jobId)
	DECLARE @partId VARCHAR(10) = (SELECT PartId FROM Parts WHERE SerialNumber = @serialNumber)

	IF(@quantity <= 0)
		THROW 50012, 'Part quantity must be more than zero!', 1
		ELSE IF(@status IS NULL)
		THROW 50013 , 'Job not found!', 1
	ELSE IF(@status = 'Finished')
		THROW 50011, 'This job is not active!', 1
	ELSE IF(@partId IS NULL)
		THROW 50014  , 'Part not found!', 1


	DECLARE @orderId INT = (SELECT o.OrderId FROM Orders AS o
										WHERE JobId = @jobId AND o.IssueDate IS NULL)

	IF(@orderId IS NULL)
	BEGIN
		INSERT INTO Orders (JobId, IssueDate) VALUES
		(@jobId, NULL)
	END
	   SET @orderId = (SELECT o.OrderId FROM Orders AS o
	   WHERE JobId = @jobId AND o.IssueDate  IS NULL  )
	   DECLARE @orderPartExists INT = (SELECT OrderId FROM OrderParts WHERE OrderId = @orderId
	   AND PartId = @partId)
	   
	 IF(@orderPartExists IS NULL)
	 BEGIN
	   INSERT INTO OrderParts(OrderId, PartId, Quantity) VALUES
	(@orderId, @partId, @quantity)
	 END
	
	ELSE 
	BEGIN
		
	    	UPDATE OrderParts
	    	SET Quantity += @quantity
	    	WHERE OrderId = @orderId AND PartId = @partId
	END
END




