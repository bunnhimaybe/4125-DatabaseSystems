import java.util.Scanner;
import java.sql.*;

class Phase3_Task1 {
	public static void main(String[] args) {
		/* SCHEMA: Nurse
			nurse_id VARCHAR2(4),
			nurse_name VARCHAR2(25),
			nurse_salary NUMBER,
			nurse_supervisor_id VARCHAR2(4)
		*/ 
		
		/* String text block
			String query = """
				SELECT n.nurse_name,
					   COUNT(s.nurse_id) AS num_supervised,
					   COALESCE(SUM(s.nurse_salary), 0) AS total_salaries
				FROM Nurses n
				LEFT OUTER JOIN Nurses s
					ON s.nurse_supervisor_id = n.nurse_id
				WHERE n.nurse_id = ?
				GROUP BY n.nurse_name
			"""; 
		*/
		
		PreparedStatement stmt = null;
		ResultSet queryResult = null;
		// queries
		String idName = "SELECT nurse_name FROM Nurses WHERE nurse_ID = ?";
		String idSupervisingCnt = "SELECT COUNT(*) FROM Nurses WHERE nurse_supervisor_id = ?";
		String idSupervisingSalaries= "SELECT COALESCE(SUM(nurse_salary), 0) FROM Nurses "
			+ "WHERE nurse_supervisor_id = ?";
					
		try {
			
			Scanner sc = new Scanner(System.in);
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:Oracle21c", "lapham", "funData");
			Class.forName("oracle.jdbc.driver.OracleDriver");		

			// read input argument (nurse_ID) 
			System.out.println("Enter nurse_ID: ");				
			String nurseID = sc.next();


			/* NAME */
			stmt = conn.prepareStatement(idName);			
			stmt.setString(1, nurseID);
			queryResult = stmt.executeQuery();
			
			if (!queryResult.next()) {
				System.out.println("No nurse found for the given ID!");
				return;
			} 
			
			String nurseName = queryResult.getString(1);
			queryResult.close();
            stmt.close();
			
			
			/* SUPERVISING COUNT */
			stmt = conn.prepareStatement(idSupervisingCnt);
			stmt.setString(1, nurseID);
			queryResult = stmt.executeQuery();
			queryResult.next();
			
			int supervisingCnt = queryResult.getInt(1);
			queryResult.close();
            stmt.close();
			
			
			/* SUPERVISED TOTAL SALARY */
			stmt = conn.prepareStatement(idSupervisingSalaries);
			stmt.setString(1, nurseID);
			queryResult = stmt.executeQuery();
			queryResult.next();
			
			long supervisingSalaries = queryResult.getLong(1);
			queryResult.close();
            stmt.close();			
			
			// print report
			System.out.println("SUPERVISOR REPORT\n");
			System.out.printf("%-25s %-5s %-15s%n", "Name", "Count", "Total Salaries");
			System.out.printf("%-25s %-5s %-15s%n", "-".repeat(25), "-".repeat(5), "-".repeat(15));
			System.out.printf("%-25s %-5d %-15d%n", nurseName, supervisingCnt, supervisingSalaries);
			
			if (queryResult != null) queryResult.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
			sc.close();


		} catch (ClassNotFoundException jdbcException) {
			jdbcException.printStackTrace();	
		} catch (SQLException sqlExcept) {
			sqlExcept.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
		
		/*
			List all of the nurses directly supervised. Include the nurse ID, name, and the total number of beds that they are monitoring.
		*/
	}
}