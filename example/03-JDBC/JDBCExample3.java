//Example3: Create table example

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCExample3{
	public static void main(String args[]){
		try{
			//Step 2 Load the driver class
			Class.forName("oracle.jdbc.driver.OracleDriver"); //This is only used when connecting to an Oracle DBMS
			
			//Step 3 Create the connection object
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:Oracle21c", "[user name]", "[password]"); //Change these to your user/pass	

			//Step 4 Create the Statement Object
			Statement state = conn.createStatement();
			
			String dropTable = "DROP TABLE City";
			String createTable = "CREATE TABLE City(ID NUMBER PRIMARY KEY, Name VARCHAR(25), Population NUMBER)";

			//Step 5 Execute Query			
			try{
				state.executeUpdate(dropTable); //All non-SELECT queries use executeUpdate				
			} catch (Exception e){
				System.out.println("Drop table failed:\n" + e);
			}
			
			try{
				state.executeUpdate(createTable); //All non-SELECT queries use executeUpdate 
			} catch (Exception e){
				System.out.println("Create table failed:\n" + e);
			}
			
			try{
				//All non-SELECT queries use executeUpdate
				state.executeUpdate("INSERT INTO City VALUES(1, 'Albany',  200000)");
				state.executeUpdate("INSERT INTO City VALUES(2, 'Boston',  800000)");
				state.executeUpdate("INSERT INTO City VALUES(3, 'Chicago', 3000000)");
				state.executeUpdate("INSERT INTO City VALUES(4, 'Detroit',  400000)");				
			} catch (Exception e){
				System.out.println("Inserts failed:\n" + e);
			}
			//conn.commit(); //auto-commit is set on by default
			
			System.out.println("Finished loading!");			
			
			ResultSet result = state.executeQuery("SELECT * FROM City"); //Access the results through a cursor
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