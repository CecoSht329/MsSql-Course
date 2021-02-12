--11. Exam Grades
CREATE FUNCTION udf_ExamGradesToUpdate(@studentId INT, @grade DECIMAL(3,2))
RETURNS NVARCHAR(150)
AS 
BEGIN 

	IF(NOT EXISTS(SELECT * FROM Students WHERE Id = @studentId))
		RETURN 'The student with provided id does not exist in the school!';
	ELSE IF(@grade > 6.00)
		RETURN 'Grade cannot be above 6.00!';
	 

	DECLARE @examGradeCount INT	= (SELECT COUNT(*) FROM Students AS s
					JOIN StudentsExams AS se ON s.Id = se.StudentId
					WHERE s.Id = @studentId AND se.Grade BETWEEN @grade AND @grade + 0.50)

	DECLARE @studentFirstName NVARCHAR(30) = (SELECT FirstName FROM Students WHERE Id = @studentId);

	RETURN 'You have to update' + ' ' + CAST(@examGradeCount AS NVARCHAR(50)) + ' ' + 'grades for the student' + ' ' + @studentFirstName;
END

GO
SELECT dbo.udf_ExamGradesToUpdate(121, 5.50)

--12. Exclude from school
GO
CREATE PROCEDURE usp_ExcludeFromSchool(@StudentId INT)
AS 
BEGIN
	  IF(NOT EXISTS (SELECT Id FROM Students WHERE Id = @StudentId))
		THROW 50001, 'This school has no student with the provided id!', 1;

	  DELETE FROM StudentsExams WHERE StudentId = @StudentId;
	  DELETE FROM StudentsSubjects WHERE StudentId = @StudentId;
	   DELETE FROM StudentsTeachers WHERE StudentId = @StudentId;
	  DELETE FROM Students WHERE Id = @StudentId;
END
GO
EXEC usp_ExcludeFromSchool 1
SELECT COUNT(*) FROM Students
