import java.io.*;
import java.util.*;


public class JavaReview {
	public static void main(String[] args) {
		try {
			//Create a file to write results to
			FileWriter outfile = new FileWriter("reviews_output.txt");

			//Read an input file 	
			File infile = new File("Hotel_Reviews.csv");
			Scanner input = new Scanner(infile);

			//Read the file line by line. 
			while (input.hasNextLine()) { //while there's a line to read
				
				String line = input.nextLine(); //store that line in a String variable
				if (line.length() == 0) { //if the line doesn't have any data, skip it. Shouldn't need this for the project.
					outfile.write("\n");
				}
				else {
					outfile.write(processLine(line)); //write our data processing to the outfile
					outfile.write("\n");
				}
			}
			outfile.close(); // close the outfile
			input.close(); // close the input file
		} catch (FileNotFoundException e) { 
			//Need to catch FNFE for FileWriter and Scanner
			System.out.println(e.getMessage());
		} catch (IOException e) {
			//Need to catch IOE for FileWriter and Scanner
			System.out.println(e.getMessage());			
		}
	}

	public static String processLine(String line) {
		String output; //this will be the "clean" data that's returned
		
		ArrayList<String> cleanValues = new ArrayList<String>(); // I will break the line into a series of values. I'll store these values in a list.
		
		
		String[] values = line.split(","); // Break the line into values that are divided by a comma.
		
		for (String value : values) { // I can iterate through the values, do some additional cleaning/manipulation if I want, and then add to my list.
			String newValue = value.trim(); //Remove leading or trailing whitespace
			newValue = countryLookup(newValue);
			cleanValues.add(newValue); 			
		}

		output = String.join("|", cleanValues); // Produce my output string by joining my clean values on the pipe character. I could use another character if I wanted to.
		return output;
	}
		
	public static String countryLookup(String value) {
		//Using a Hashmap here would be more efficient, but this example relates more to the project.
		
		if (value.equals("United Kingdom")) {
			return "UK";
		}		
		else if (value.equals("United States of America")) {
			return "USA";
		}
		else if (value.equals("Canada")) {
			return "CAN";
		}
		else if (value.equals("Australia")) {
			return "AUS";
		}
		else if (value.equals("Germany")) {
			return "GER";
		}
		else if (value.equals("Russia")) {
			return "RUS";
		}
		else if (value.equals("Ireland")) {
			return "IRE";
		}		
		else
			return value;		
	}	
}