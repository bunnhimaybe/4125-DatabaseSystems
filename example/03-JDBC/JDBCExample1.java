// Documentation & Tutorial
// https://docs.oracle.com/javase/tutorial/jdbc/basics/index.html

// Step 1 - Import the Java classes 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCExample1{
	public static void main(String args[]){
		try{
			// Step 2 - Load the driver class
			Class.forName("oracle.jdbc.driver.OracleDriver"); //This is only used when connecting to an Oracle DBMS
			
			// Step 3 - Create the connection object
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:Oracle21c", "[user name]", "[password]"); //Change these to your user/pass	

			// Step 4 - Create the Statement Object
			Statement stmt = conn.createStatement();

			// Step 5 - Execute Query
			ResultSet queryResult = stmt.executeQuery("SELECT * FROM Animal");
			
			while(queryResult.next())
				System.out.println(queryResult.getInt(1) + " " + queryResult.getString(2) + " " + queryResult.getString(3));
			
			// Step 6 - Close the Database Connection
			conn.close();
		} 
		catch(Exception e){
			System.out.println(e);
		}
	}	
}

