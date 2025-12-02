/*
>javac SqlInjection.java

>java -classpath "ojdbc8.jar;" SqlInjection

*/

//Step 1 Load the Java classes 
import java.sql.*;
import java.util.Scanner;

class SqlInjection{
	public static void main(String args[]){
		try{
			//Step 2 Load the driver class
			Class.forName("oracle.jdbc.driver.OracleDriver"); //This is only used when connecting to an Oracle DBMS
			
			//Step 3 Create the connection object
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:Oracle21c", "[user name]", "[password]"); //Change these to your user/pass	

			//Collect some user input			
			Scanner input = new Scanner(System.in);		
			System.out.println("Enter your id:");
			String userInput = input.nextLine();
			

			//Step 4 Create the Prepared Statement Object
			//Step 5 Execute Query w/ Prepared Statement
			//String query1 = "SELECT * FROM Animal WHERE AID = ?";
			//PreparedStatement prepQuery = conn.prepareStatement(query1);	
			//prepQuery.setString(1, userInput); //Set the i-th ? value
			//ResultSet result = prepQuery.executeQuery();

			//Step 4 Create the Statement Object
			//Step 5 Execute Query w/out Prepared Statement. Example 1
			Statement state = conn.createStatement();
			ResultSet result = state.executeQuery("SELECT * FROM Animal WHERE AID = " + userInput);
						
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

