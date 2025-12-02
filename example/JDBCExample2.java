//Example2: Retrieving Values

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCExample2{
	public static void main(String args[]){
		try{
			//Step 2 Load the driver class
			Class.forName("oracle.jdbc.driver.OracleDriver"); //This is only used when connecting to an Oracle DBMS
			
			//Step 3 Create the connection object
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:Oracle21c", "[user name]", "[password]"); //Change these to your user/pass	

			//Step 4 Create the Statement Object
			Statement state = conn.createStatement();
			
			//Step 5 Execute Query
			ResultSet result1 = state.executeQuery("SELECT * FROM Animal");
			
			System.out.println("Result Set 1");
			  
			while(result1.next()){
				//Values can be retrieved using the column name	
				int aid1 = result1.getInt("AID");
				String aname1 = result1.getString("AName");
				String acategory1 = result1.getString("ACategory");
				float timetofeed1 = result1.getFloat("TimeToFeed");
				System.out.println(aid1 + " " + aname1 + " " + acategory1 + " " + timetofeed1);
			}	
				
			//Step 5 Execute Query
			ResultSet result2 = state.executeQuery("SELECT * FROM Animal");
			
			System.out.println("\n\nResult Set 2");
			
			while(result2.next()){
				//Values can be retrieved using the column index number
				int aid2 = result2.getInt(1);
				String aname2 = result2.getString(2);
				String acategory2 = result2.getString(3);
				float timetofeed2 = result2.getFloat(4);
				System.out.println(aid2 + " " + aname2 + " " + acategory2 + " " + timetofeed2);
			}
						
			//Step 6 Close the Database Connection
			conn.close();
		} 
		catch(Exception e){
			System.out.println(e);
		}
	}	
}