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
import java.io.*;
import java.lang.StringBuilder;

public class Phase2_Task2 {

    public static void main(String[] args) {

        // accept command-line argument 
        if (args.length < 1) {
            System.err.println("Please specify the table in the command line.");
            System.err.println("Usage: $java Phase2_Task2 tablename");
            return;
        }

        String tableName = args[0]; 
        ArrayList<String> lineValues = new ArrayList<>(); 

        try {

            // read input file
            File dataFile = new File( String.format("%s.txt", tableName));
            BufferedReader input = new BufferedReader(new FileReader(dataFile));
            String line = input.readLine(); 
            
            // create output file 
            File outputFile = new File(String.format("%s.sql", tableName) );
            if (outputFile.exists()) {
                outputFile.delete();
            }
            
            try (FileWriter writer = new FileWriter(outputFile, true) ) {
             
                // build SQL statement (process input line by line)
                while (line != null) {

                    String[] lineSplit = line.split(",");
                    
                    // determine data type & format values
                    for (String split : lineSplit) {
                        split = split.trim(); 

                        try { // number
                            Float.parseFloat(split);
                            lineValues.add(split);

                        } catch (NumberFormatException notDecimal) { // string

                            if (split.equalsIgnoreCase("NULL")) {
                                lineValues.add("NULL");

                            } else {
                                if (split.contains("'")) {
                                    split = split.replace("'", "''"); // escape ' char
                                }
                                lineValues.add(String.format( "\'%s\'", split) );
                            }
                        }
                    }
                    
                    // template: INSERT INTO [tableName] VALUES(value, value);
                    StringBuilder statement = new StringBuilder("INSERT INTO ");
                    statement.append( String.format("%s VALUES(", tableName) );
                    statement.append( String.join(", ", lineValues) );
                    statement.append( ");\n" );

                    // write to output file
                    writer.write(statement.toString());

                    lineValues.clear();
                    
                    line = input.readLine(); 
                } 

                // end of output file
                writer.write("commit;");
                writer.close();
   
            } catch (IOException e) {
                System.out.println("Error writing output file.");
                System.err.println(e.getMessage());
            }

            input.close();

        } catch (FileNotFoundException e) { // input file does not exist
            System.out.println("Error: File not found. Please check the filename and try again.");
            return;
        } catch (IOException e) {
            System.out.println("An I/O error occurred.");
            System.err.println(e.getMessage());
            return;
        }
    }
}