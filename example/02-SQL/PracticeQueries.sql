-- Find the number of customers
SELECT COUNT(*) 
FROM Customer2;

-- Find all distinct customer names
SELECT DISTINCT C_Name 
FROM Customer2;

-- Find all items that have a price less than $500
SELECT *
FROM Item2
WHERE (I_Price < 500);

-- Find all magenta items that have a price less than $500
SELECT *
FROM Item2
WHERE LOWER(I_Color) = 'magenta'
AND I_Price < 500;

-- Find all items that do not have a color available
SELECT *
FROM Item2
WHERE I_Color IS NULL;
-- Find all supplier phone numbers with the area code 805
SELECT *
FROM Supplier2
WHERE S_Phone 
LIKE '219%';
-- Find the average price for all violet items
SELECT AVG(I_Price) 
FROM Item2
WHERE LOWER(I_Color) = 'violet';
-- Find all customers that live in a city with a supplier
SELECT (*) 
FROM Customer2
WHERE C_City 
IN (SELECT S_City FROM Supplier2);
-- Find all orders in the year 2020 that were shipped by boat
SELECT (*) 
FROM Orders2 
WHERE LOWER(O_Shipmode) = 'boat'
AND O_Date BETWEEN '01-JAN-2020' AND '31-DEC-2020';
-- AND O_Date LIKE '%2020';
-- Find all of the items that have a size less than 30 and order the output by color
SELECT (*) 
FROM Item2
WHERE I_Size < 30 
ORDER BY I_Color;
-- Find all items that are larger than the average size
SELECT (*) 
FROM Item 
WHERE I_Size > (SELECT AVG(I_Size) FROM Item);

-- Find the number of orders placed by customer 1
SELECT COUNT(O_ID) 
FROM Orders2
WHERE O_CustID = 1;
-- FETCH FIRST 1 ROWS ONLY

-- Find the maximum price among all violet items
SELECT MAX(I_Price) 
FROM Item2 
WHERE LOWER(I_Color) = 'violet';

-- Find the color for Reese's Pieces
SELECT I_Color 
FROM Item2
WHERE I_Name = 'Reese''s Pieces'; 

-- Find orders that have been repeated by the same supplier and customer pairs
SELECT O_ID AS "Order ID"
FROM Orders2 O1
WHERE (O_Supplier AND O_CustID) 
IN (SELECT (O_Supplier, O_CustID) 
	FROM Orders2 O2
	WHERE O1.O_ID != O2.O_ID)
ORDER BY O_CUSTID, O_SupplierID;

/*
for order in orders1:
	for order in orders2: 
		if orders1.(O_CustID, O_SupplierID) == orders2.(O_CustID, O_SupplierID)
			return order
*/