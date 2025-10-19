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
        String line;
        ArrayList<String> lineValues = new ArrayList<>(); 

        try {

            // read input file
            File dataFile = new File( String.format("%s.txt", tableName));
            BufferedReader input = new BufferedReader(new FileReader(dataFile));
            
            // create output file 
            File outputFile = new File(String.format("%s.sql", tableName) );
            if (outputFile.exists()) {
                outputFile.delete();
            }
            
            // build SQL statement (process input line by line)
            while (!input.readLine().equals(null)) {

                line = input.readLine(); 
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
                try {
                    FileWriter writer = new FileWriter(outputFile, true);
                    writer.write(statement.toString());
                    writer.close();
                    System.out.println("WROTE " + statement.toString());
                } catch (IOException e) {
                    System.out.println("Error writing output file.");
                    e.printStackTrace();
                    System.out.println("WRITING ERROR "+ statement.toString());
                }

                lineValues.clear();
            } 

            input.close();

        } catch (FileNotFoundException exception) { // input file does not exist
            System.out.println("Invalid file.");
            exception.printStackTrace();
        } catch (IOException e) {
            System.err.println(e);
        }
    }
}