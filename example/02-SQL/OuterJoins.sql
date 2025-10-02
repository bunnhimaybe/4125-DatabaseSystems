-- Find all students that do not have a pet
SELECT *
FROM Student4 LEFT OUTER JOIN Pet
ON S_ID = P_OwnerID 
WHERE P_Name IS NULL;

-- Find all pets that do not have an owner
SELECT * 
FROM Pet 
WHERE P_OwneerID IS NULL;

-- Find all students that do not have a pet and pets that do not have an owner
SELECT * 
FROM Student4 FULL OUTER JOIN Pet 
ON S_ID = P_OwnerID
WHERE (P_Name IS NULL) OR (P_OwnerID IS NULL);

-- Find all students that do have a pet
SELECT * 
FROM Student4, Pet
WHERE S_ID = P_OwnerID;

SELECT * 
FROM Student4 INNER JOIN Pet
ON S_ID = P_OwnerID;