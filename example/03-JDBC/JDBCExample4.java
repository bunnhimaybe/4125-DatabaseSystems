//Example4: Prepared Statement A

import java.sql.*; 

public class JDBCExample4{
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
			
			//Create the prepared statement 
			String insertString = "INSERT INTO City VALUES(?, ?, ?)";
			PreparedStatement insertCity = conn.prepareStatement(insertString);	
			
			insertCity.setInt(1, 1); //Set the i-th ? value
			insertCity.setString(2, "Albany");
			insertCity.setInt(3, 200000);
			insertCity.executeUpdate();	//Execute the prepared statement	
			
			insertCity.setInt(1, 2);
			insertCity.setString(2, "Boston");
			insertCity.setInt(3, 800000);
			insertCity.executeUpdate();
		
			insertCity.setInt(1, 3);
			insertCity.setString(2, "Chicago");
			insertCity.setInt(3, 3000000);
			insertCity.executeUpdate();
		
			insertCity.setInt(1, 4);
			insertCity.setString(2, "Detroit");
			insertCity.setInt(3, 400000);
			insertCity.executeUpdate();
						
			System.out.println("Finished loading!");			
			
			ResultSet result = state.executeQuery("SELECT * FROM City"); //Access the results through a cursor
			while(result.next())
				System.out.println(result.getInt(1) + " " + result.getString(2) + " " + result.getString(3));
			
			conn.close();
		} 
		catch(Exception e){
			System.out.println(e);
		}
	}	
}