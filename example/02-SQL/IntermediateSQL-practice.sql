-- Find the number of customers for each city. 
-- Order the output by the number of customers per city.

SELECT C_City, COUNT(*)
FROM Customer2
GROUP BY C_City
ORDER BY COUNT(*);

/* PSEUDO (word count = hashmap) 
    results = (key, value)
    for customer in customer_file:
        if customer.city in results.keys:
            results[customer, city += 1
        else
            results[customer, cit] = 1
*/

-- Find cities with more than 3 customers
SELECT C_City, COUNT(*)
FROM Customer2
GROUP BY C_City
HAVING COUNT(*) >= 3;

-- Find the city with the most customers
SELECT C_City, COUNT(*)
FROM Customer2
GROUP BY C_City
HAVING COUNT(*) = (
                    SELECT MAX( COUNT(*) )
                    FROM Customer2
                    GROUP BY C_City
);

-- Find the total price for all orders
SELECT SUM(I_Price)
FROM Orders2 INNER JOIN Item2
ON O_ItemID = I_ID

SELECT SUM(I_Price)
FROM Orders2, Item2
WHERE O_ItemID = I_ID

/* PSEUDO
    for order in orders_file:
        for item in items_file;
            if order.itemID == item.ID:
                sum += 1
*/

-- Find all suppliers that live in a city that has customers
SELECT DISTINCT S_Name, S_City
FROM Supplier2 INNER JOIN Customer2
ON S_City = C_City;

SELECT DISTINCT S_Name, S_City
FROM Supplier2, Customer2
WHERE S_City = C_City;

SELECT S_ID, S_Name
FROM Supplier2
WHERE S_City IN (
                    SELECT C_City FROM Customer2
);

-- Find all suppliers that live in a city without customers
SELECT S_Name, S_City
FROM Supplier2 OUTER LEFT JOIN Customer2
ON S_City = C_City;

SELECT S_Name, S_City
FROM Supplier2 
WHERE S_City != (
                    SELECT C_City
                    FROM Customer2
                    ORDER BY C_City
)

-- Find the average size and price for each item color

-- Find the most common item color

-- Find all shipping modes for Gremlins

-- Find the supplier who has fulfilled the most orders