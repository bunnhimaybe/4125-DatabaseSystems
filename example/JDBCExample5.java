//Example5: Prepared Statements B 

import java.sql.*; 
import java.util.ArrayList;
import java.util.*;


class City {    
	int id;    
	String name;    
	int population;    
	
	public City(int id, String name, int population) {    
		this.id = id;    
		this.name = name;    
		this.population = population;    
	}    
} 

public class JDBCExample5{
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
			
			//Collect the data into a list
			City city1 = new City(1, "Albany",  200000);
			City city2 = new City(2, "Boston",  800000);
			City city3 = new City(3, "Chicago", 3000000);
			City city4 = new City(4, "Detroit",  400000);
			
			ArrayList<City> cityList = new ArrayList<City>();
						
			cityList.add(city1);
			cityList.add(city2);
			cityList.add(city3);
			cityList.add(city4);			
			
			//Create the prepared statement 
			String insertString = "INSERT INTO City VALUES(?, ?, ?)";
			PreparedStatement insertCity = conn.prepareStatement(insertString);	

			//Iterate through the list of cities and populate the prepared statement values.
			for (int cnt = 0; cnt < cityList.size(); cnt++) {
				City myCity = cityList.get(cnt);
				insertCity.setInt(1, myCity.id);
				insertCity.setString(2, myCity.name);
				insertCity.setInt(3, myCity.population);
				insertCity.executeUpdate();
			}
				
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