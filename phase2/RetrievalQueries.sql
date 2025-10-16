/* 
 * Nhi Pham 
 * CSCI 4125 Database Systems
 * Phase 2 - (3) Retrieval Queries
 * Fall 2025
 * 
 * Takes a command-line argument to convert data 
 * from a text file into SQL statements. 
*/

-- =======================================
-- Queries 1 - 8 are worth 1 point each.
-- =======================================

--1. Find all the “surgery” (for the specialty) physicians and sort the query output by names (any direction).

--2. Find all physicians with medicine in their specialty name 
    -- (hint: remember the LIKE operator and case sensitivity).

--3. Find all nurses who do not have a supervisor.

--4. Find the names of all nurses with a salary between $70,000 and $80,000 (inclusive).

--5. Find the minimum and maximum salaries amongst all nurses. Use only one query that returns 
    -- a single row (ex. 50000, 100000).

--6. Find the average salary for all nurses.

--7. Find the name of the nurse that has the highest salary. Do not hardcode any salaries or other values 
    -- you must use SQL without assuming you know the current database snapshot.

--8. Find the nurses with a salary less than the average overall salary for all nurses + 20% 
    -- (i.e., less than 1.2 * average salary). Do not hardcode any salaries or other values 
    -- you must use SQL without assuming you know the current database snapshot.


-- =======================================
-- Queries 9 - 19 are worth 2 points each.
-- =======================================

--9. Retrieve the names of all nurses who monitor at least one bed. Make sure to remove duplicates.

--10. For each physician ID, list the total number of hours worked.

--11. Retrieve the names of all nurses who do not monitor any beds.

--12. Find the names of all nurses who are directly supervised by Chris Summa. 
    -- Note: You must use the string ‘Chris Summa’ and not hardcode the nurse ID.

--13. Retrieve the names of all physicians who specialize in dermatology and have work more than 22 hours.

--14. For each physician specialty, list the specialty, the number of physicians that have that specialty, 
    -- and the total number of hours worked by those physicians.

--15. Retrieve the names of all nurses whose supervisor’s supervisor has N01 for their ID.

--16. For each physician specialty, find the total number of patients whose physician has that specialty.

--17. Find the patient who is assigned to a bed that is monitored by the nurse with the lowest salary.

--18. Retrieve the average age of patients assigned to a bed.

--19. This problem requires (no points if you don’t) you to use the regular expression function that 
    -- we discussed in class. Find all beds that have a room number that end in an odd number 
    -- (e.g., return 101, but not 102).