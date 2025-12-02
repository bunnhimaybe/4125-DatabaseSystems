//Step 1 Load the Java classes 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCExample1{
	public static void main(String args[]){
		try{
			//Step 2 Load the driver class
			Class.forName("oracle.jdbc.driver.OracleDriver"); //This is only used when connecting to an Oracle DBMS
			
			//Step 3 Create the connection object
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:Oracle21c", "[user name]", "[password]"); //Change these to your user/pass	
						

			//Step 4 Create the Statement Object
			Statement state = conn.createStatement();
			
			//Step 5 Execute Query
			ResultSet result = state.executeQuery("SELECT * FROM Animal");
						
			while(result.next())
				System.out.println(result.getInt(1) + " " + result.getString(2) + " " + result.getString(3));
			
			//Step 6 Close the Database Connection
			conn.close();
		} 
		catch(Exception e){
			System.out.println(e);
		}
	}	
}

