package phase2;

/* 
 * Nhi Pham 
 * CSCI 4125 Database Systems
 * Phase 2 - Data Loading
 * Fall 2025
 * 
 * Takes a command-line argument to convert data 
 * from a text file into SQL statements. 
*/

import java.util.ArrayList;
import java.util.Scanner;
import java.io.*;
import java.io.FileNotFoundException;
import java.io.IOException;

public class Phase2_Task2 {

    public static void main(String[] args) {

        // accept command-line argument 
        if (args.length < 1) {
            System.err.println("Please specify the table in the command line.");
            System.err.println("Usage: $java Phase2_Task2 tablename");
            return;
        }

        String tableName = args[0]; 

        try {

            // read input file, line by line
            File dataFile = new File( String.format("%s.txt", tableName)) ;
            BufferedReader input = new BufferedReader(new FileReader(dataFile));
            
            while (!input.readLine().equals(null)) {

                String line = input.readLine(); 
                String[] lineValues = line.split(",");
                ArrayList<String> dataTypes = new ArrayList<>(); 
                
                // classify data type
                for (String str : lineValues){
                    str = str.trim(); 

                    try { // decimal
                        Float.parseFloat(str);
                        dataTypes.add("Float");
                    } catch (NumberFormatException notDecimal) {
                    try { // integer
                        Integer.parseInt(str); 
                        dataTypes.add("NUMBER");
                    } catch (NumberFormatException notInt) {

                        if (str.toUpperCase().equals("NULL")) {
                            
                        }
                        try {
                            Float.parseFloat(str);
                            dataTypes.add("Float");
                        } catch (NumberFormatException notDecimal) {
                            dataTypes.add("VARCHAR2()");
                        }
                    }
                }


                // complete statement

                // join array elements into one line
                String lineDataTypes = String.join(",", dataTypes);
                
                // write to output file 
                File scriptFile = new File( String.format("%s.sql", tableName) );

                if (scriptFile.exists()) {
                    scriptFile.delete();
                }
                
                // append results to output file
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
            } 

            input.close();

        } catch (FileNotFoundException exception) { // input file does not exist
            System.out.println("Invalid file.");
            exception.printStackTrace();
        }
    }
}