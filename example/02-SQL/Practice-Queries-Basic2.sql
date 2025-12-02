-- =========================================
-- OUTER JOINS
-- =========================================

-- 1. Find all students that do not have a pet
SELECT *
FROM Student4 LEFT OUTER JOIN Pet
ON S_ID = P_OwnerID 
WHERE P_Name IS NULL;



-- 2. Find all pets that do not have an owner
SELECT * 
FROM Student4, Pet
WHERE S_ID = P_OwnerID; 


-- Find all students that do have a pet
SELECT * 
FROM Student4, Pet
WHERE S_ID = P_OwnerID;

SELECT * 
FROM Student4 INNER JOIN Pet
ON S_ID = P_OwnerID;


-- Find all students with their pet names if they have one
SELECT * 
FROM Student4 LEFT OUTER JOIN Pet
ON S_ID = P_OwnerID;



-- 3. Find all students that do not have a pet and pets that do not have an owner

SELECT * 
FROM Student4 FULL OUTER JOIN Pet 
ON S_ID = P_OwnerID
WHERE (P_Name IS NULL) OR (P_OwnerID IS NULL);




-- =========================================
-- COMPLEX RETRIEVAL QUERIES
-- =========================================

-- 1. Find the number of customers for each city.
-- Order the output by the number of customers per city.

/* PSEUDO (word count = hashmap) 
    results = (key, value)
    for customer in customer_file:
        if customer.city in results.keys:
            results[customer, city += 1
        else
            results[customer, cit] = 1
*/

SELECT C_City, COUNT(*)
FROM Customer2
GROUP BY C_City
ORDER BY COUNT(*);



-- 2. Find cities with more than 2 customers

SELECT C_City, COUNT(*)
FROM Customer2
GROUP BY C_City
HAVING COUNT(*) > 2;



-- 3. Find the city with the most customers

SELECT C_City, COUNT(*)
FROM Customer2
GROUP BY C_City
HAVING COUNT(*) = (
                    SELECT MAX( COUNT(*) )
                    FROM Customer2
                    GROUP BY C_City
);



-- 4. Find the total price for all orders

/* PSEUDO
    for order in orders_file:
        for item in items_file;
            if order.itemID == item.ID:
                sum += 1
*/

SELECT SUM(I_Price)
FROM Orders2 INNER JOIN Item2
ON O_ItemID = I_ID;

SELECT SUM(I_Price)
FROM Orders2, Item2
WHERE O_ItemID = I_ID;



-- 5. Find all suppliers that live in a city that has customers

SELECT DISTINCT S_Name, S_City
FROM Supplier2 INNER JOIN Customer2
ON S_City = C_City;

SELECT DISTINCT S_Name, S_City
FROM Supplier2, Customer2
WHERE S_City = C_City;

SELECT S_Name, S_City
FROM Supplier2
WHERE S_City IN (
                    SELECT C_City FROM Customer2
);



-- 6. Find all suppliers that live in a city without customers

SELECT S_Name, S_City
FROM Supplier2 OUTER LEFT JOIN Customer2
ON S_City = C_City
WHERE C_City IS NULL
ORDER BY C_City;



-- 7. Find the average size and price for each item color

SELECT I_Color, AVG(I_Price)
FROM Item2
GROUP BY I_Color;



-- 8. Find the most common item color

SELECT I_Color
FROM Item2
GROUP BY I_Color
HAVING COUNT(*) = (
                    SELECT MAX(COUNT(*))
                    FROM Item2
                    GROUP BY I_Color
);



-- 9. Find all shipping modes for Gremlins
SELECT O_Shipmode
FROM Orders2, Item2
WHERE O_ItemID = I_ID
AND I_Name = 'Gremlin'
GROUP BY O_Shipmode;



-- 10. Find the most common shipping mode for Gremlins

SELECT O_Shipmode
FROM Orders2, Item2
WHERE O_ItemID = I_ID
AND I_Name = 'Gremlin'
GROUP BY O_Shipmode
HAVING COUNT(*) = (
                    SELECT MAX(COUNT(*))
                    FROM Orders2, Item2
                    WHERE O_ItemID = I_ID
                    AND I_Name = 'Gremlin'
                    GROUP BY O_Shipmode 
);



-- 11. Find the customer who has ordered the most Gremlins
-- GROUP BY == HashMap 
SELECT C_Name, COUNT(*)
FROM Customer2, Item2, Orders2
WHERE C_ID = O_CustID
AND I_ID = O_ItemID
AND I_Name = 'Gremlin'
GROUP BY C_Name
HAVING COUNT(*) = 
                    (SELECT MAX(COUNT(*))
                    FROM Customer2, Item2, Orders2
                    WHERE C_ID = O_CustID
                    AND I_ID = O_ItemID
                    AND I_Name = 'Gremlin'
                    GROUP BY C_Name);
                    
                    



-- ** For each customer that ordered a Gremlin, 
-- ** list the number that they ordered and the total price

SELECT C_Name, COUNT(*)
FROM Customer2, Item2, Orders2
WHERE C_ID = O_CustID
AND I_ID = O_ItemID
AND I_Name = 'Gremlin'
GROUP BY C_Name;



-- 12. Find the supplier who has fulfilled the most orders

SELECT O_SuppID, S_Name, COUNT(*)
FROM Orders2, Supplier2
WHERE O_SuppID = S_ID
GROUP BY O_SuppID, S_Name
HAVING COUNT(*) = (
    SELECT MAX(COUNT(*))
    FROM Orders2
    GROUP BY O_SuppID
);



-- 13. Find the average part size for each shipping mode

SELECT O_Shipmode, AVG(I_Size)
FROM Orders, Item2
WHERE O_ItemID = I_ID
GROUP BY O_Shipmode;



-- 14. Find all customers who purchased a Gremlin

SELECT C_Name
FROM Customer2, Item2, Orders2
WHERE C_ID = O_CustID
AND I_ID = O_ItemID
AND I_Name = 'Gremlin';


-- 15. Find all parts with the same size

/* PSEUDO
    for item1 in items:
        for item2 in items:
            if item1.size = item2.size and item1.id != item2.id:
                print item1.name, item2.name
*/

SELECT *
FROM Item2 I1, Item2 Item2WHERE I1.I_Size = I2.I_Size
AND I1.I_ID < I2.I_ID
ORDER BY I1.I_Size;



/* Retrieve the names of all EMPLOYEE2s works on any project.

SELECT DISTINCT Fname ||  ' ' || Minit || ' ' || Lname AS name
FROM Employee2, Works_On
WHERE SSN = ESSN;

SELECT Fname ||  ' ' || Minit || ' ' || Lname AS name
FROM Employee2 
WHERE SSN IN (SELECT ESSN FROM Works_On); 
*/



/* Retrieve the names of all EMPLOYEE2s who do not work on any project.

SELECT Fname ||  ' ' || Minit || ' ' || Lname AS name
FROM Employee2 LEFT OUTER JOIN Works_On
ON SSN = ESSN
WHERE Works_On.ESSN IS NULL; 
*/



/* For each department whose average salary is greater than $42,000, 
retrieve the department name and the number of EMPLOYEE2s in that department.

SELECT Dname, COUNT(*) 
FROM Department, Employee2
WHERE Dnumber = Dno
GROUP BY Dname
HAVING AVG(Salary) > 42000
*/



/* 
SELECT * 
FROM Employees2
WHERE Dno NOT IN (
    SELECT Dnumber
    FROM DEPT_LOCATIONS
    WHERE Dlocation = 'Houston')
AND SSN IN (
    SELECT ESSN
    FROM Works_On
    WHERE Pno IN (SELECT Pnumber FROM Project WHERE Plocation = 'Houston'));
)
*/