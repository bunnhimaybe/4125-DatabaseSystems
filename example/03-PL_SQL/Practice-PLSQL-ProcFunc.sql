-- 1. Write a PL/SQL function that given a score, returns a letter grade 
--  (A >= 90, B >= 80, C >= 70, D >= 60, F < 60).

CREATE OR REPLACE FUNCTION GradeMessage(score Test.Score%TYPE)
RETURN Test.ID%TYPE
AS 
    grade CHAR(1);

DECLARE
    score INTEGER := 85;
    grade CHAR(1);
BEGIN
    IF (score >= 90) THEN
        grade := 'A';
    ELSIF (score >= 80) THEN
        grade := 'B';
    ELSIF (score >= 70) THEN
        grade := 'C';
    ELSIF (score >= 60) THEN
        grade := 'D';
    ELSIF (score <  50) THEN
        grade := 'F';
    ELSE
        grade := 'X';
    END IF;

    -- DBMS_OUTPUT.PUT_LINE(grade);

    RETURN grade;
END;
/

-- QUERY
SELECT Exam, Score, GradeMessage(Score)
FROM Test;

-- 2. Write a PL/SQL procedure that prints the Student ID, Name, and Major for a given student ID. 

-- FUNCTION
DECLARE
    targetID student.ID%TYPE := '2804';
    targetName student.Name%TYPE;
    targetMajor student.Major%TYPE;
BEGIN
    SELECT Name, Major INTO targetName, targetMajor
    FROM Student
    WHERE ID = targetID;

    DBMS_OUTPUT.PUT_LINE('ID: ' || targetID || ', Name: ' || targetName || ', Major: ' || targetMajor)
END;
/

-- PROCEDURE
CREATE OR REPLACE PROCEDURE StudentData(targetID student.ID %TYPE)
AS
    targetName student.Name%TYPE;
    targetMajor student.Major%TYPE;
BEGIN
    SELECT Name, Major INTO targetName, targetMajor
    FROM Student
    WHERE ID = targetID;

    DBMS_OUTPUT.PUT_LINE('ID: ' || targetID || ', Name: ' || targetName || ', Major: ' || targetMajor);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Student ID' || targetID || ' does not exist.');
END;
/

call StudentData('1716');

-- 3. Write a PL/SQL block that prints the all students and their score for a given test (e.g., Midterm, Final).
