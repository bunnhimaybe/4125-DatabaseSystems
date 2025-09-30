import java.util.ArrayList;
import java.util.Scanner;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.NumberFormat;

public class Main {
    public static void main(String[] args) {       

        String inputFile = "phase1.txt";
        String outputFile = "phase1_output.txt";
        String inputLine, outputLine, dataTypes[];
        
        Scanner reader = new Scanner(inputFile); // reads input from file
        File output = new File(outputFile); // initialize output file
        ArrayList<String> outputData = new ArrayList<>(); // holds lines of data
        
        // process input file, line by line
        while (reader.hasNextLine()){
            
            // split lines on commas
            inputLine = reader.nextLine();
            dataTypes = inputLine.split(",");

            for (String val : dataTypes){
                val.trim(); // remove whitespace
                
                try { // check for Integer
                    Integer.parseInt(val);                        
                    outputData.add("Integer");
                } catch (NumberFormatException notInt) {
                    try { // check for Float
                        Float.parseFloat(val);
                        outputData.add("Float");
                    } catch (NumberFormatException notFloat) {
                        outputData.add("String"); 
                    }
                }

                // join values in line into String
                outputLine = String.join(",", outputData);

                try { // write output to file
                    FileWriter writer = new FileWriter(output);
                    writer.write(outputLine + "\n");
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                    System.out.println("Failed to write to output file.");
                } 

                outputData.clear(); // clear values in line
            }
        }

        reader.close();
    }
}
