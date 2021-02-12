--5. Teen Students
SELECT FirstName, LastName, Age FROM Students
WHERE Age >= 12 
ORDER BY FirstName, LastName

--6. Students Teachers
SELECT s.FirstName, s.LastName, COUNT(st.TeacherId) FROM Students AS s
JOIN StudentsTeachers AS st ON s.Id = st.StudentId
GROUP BY s.FirstName, s.LastName

--7. Students to Go
SELECT CONCAT(s.FirstName, ' ', s.LastName) AS [Full Name] FROM Students AS s
LEFT JOIN StudentsExams AS se ON s.Id = se.StudentId
WHERE se.ExamId IS NULL
ORDER BY [Full Name]

--8. Top Students
SELECT TOP(10) FirstName, LastName,Grade FROM
		(SELECT  FirstName, LastName, FORMAT(AVG(Grade),'N2') as Grade FROM Students AS s
		LEFT JOIN StudentsExams AS se ON s.Id = se.StudentId
		GROUP BY FirstName, LastName) AS AverageGradeQuery
ORDER BY Grade DESC, FirstName, LastName

--9. Not So In The Studying
SELECT s.FirstName +
	CASE 
		WHEN s.MiddleName IS NULL THEN ' '
		ELSE ' ' + s.MiddleName + ' '
	END +
	S.LastName AS [Full Name]
FROM Students AS s
LEFT JOIN StudentsSubjects AS ss ON s.Id = ss.StudentId
WHERE SubjectId IS NULL
ORDER BY [Full Name]

--10. Average Grade per Subject
SELECT [Name], Grade FROM
	(SELECT s.Id, s.[Name], AVG(Grade) AS Grade FROM Subjects AS s 
	JOIN StudentsSubjects AS ss ON s.Id = ss.SubjectId
	GROUP BY s.Id, s.[Name]
	) AS AverageGradeQuery
	ORDER BY Id