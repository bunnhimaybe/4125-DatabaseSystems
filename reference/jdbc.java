// Documentation & Tutorial
// https://docs.oracle.com/javase/tutorial/jdbc/basics/index.html

// 1. import classes 
import java.sql.*;

// 2. load classes
Class.forName(“oracle.jdbc.driver.OracleDriver”);

// 3. create database connection 
Connection c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:Oracle21c", “username”, “password”);

// 4. create statements
Statement s = c.createStatement();
PreparedStatement p = c.prepareStatement(String partialStatement);

// 5. issue SQL statements
// non-retrieval statements - return int
s.executeUpdate(statement);
// SELECT queries - return ResultSet 
s.executeQuery(query); // return ResultSet

// 6. close database connection
c.close();