/* Database Systems Project - Phase 1 
** Nhi Pham - Fall 2025
*/

import java.util.ArrayList;
import java.util.Scanner;
import java.io.File;
import java.io.FileWriter;
import java.io.FileNotFoundException;
import java.io.IOException;

public class Main {

    public static void main(String[] args) {
        try {
            // 1. Specify input and output files
            File inputFile = new File("phase1.txt");
            Scanner input = new Scanner(inputFile);
            
            // clear output file if it already exists
            File outputFile = new File("phase1_output.txt");
            if (outputFile.exists()) {
                outputFile.delete();
            }
            
            // 2. Read line by line
            while (input.hasNextLine()) {  // check for data                
                String[] lineValues = new String[100]; // Array: values of lines
                ArrayList<String> dataTypes = new ArrayList<>(); // ArrayList: data types of the line
                
                String line = input.nextLine();
                lineValues = line.split(","); // separate line into values
                
                // Determine data type of each value in the line
                for (String str : lineValues){
                    str = str.trim(); // remove whitespace
                    
                    try {
                        Integer.parseInt(str); 
                        dataTypes.add("Integer");
                    } catch (NumberFormatException notInt) {
                        try {
                            Float.parseFloat(str);
                            dataTypes.add("Float");
                        } catch (NumberFormatException notDecimal) {
                            dataTypes.add("String");
                        }
                    }
                }

                // 3. Join array elements into one line (String)
                String lineDataTypes = String.join(",", dataTypes);
                
                // Append results to output file
                try {
                    FileWriter writer = new FileWriter(outputFile, true);
                    writer.write(lineDataTypes);
                    writer.write("\n");
                    writer.close();
                    System.out.println("WROTE " + lineDataTypes);
                } catch (IOException e) {
                    System.out.println("Error writing output file.");
                    e.printStackTrace();
                    System.out.println("WRITING ERROR "+ lineDataTypes);
                }
            } // end while (read input)
            input.close();
        } catch (FileNotFoundException exception) { // input file does not exist
            System.out.println("Invalid file.");
            exception.printStackTrace();
        }
    }
}