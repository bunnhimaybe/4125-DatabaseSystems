import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Map;
import java.util.TreeMap;
import java.util.HashMap;
public class Phase2_Task4_QueryProcessing {

    /* Retrieve the names of all nurses who monitor at least one bed. 
        SELECT DISTINCT name
        FROM nurse, bed
        WHERE nurse.ID = bed.nurse_id;
     */

    // INNER JOIN == nested for
    public static void Query09(){

        Map<String, String> nurseMap = new HashMap<>(); // nurse name lookup
        Map<String, String> nurseResults = new HashMap<>(); // nurses monitoring beds

        try {

            System.out.println("nurse_name");
            System.out.println("-------------------------");

            // Read Nurse data
            // Nurse(nurse_id, nurse_name, nurse_salary, nurse_supervisor_id)
            BufferedReader nurseData = new BufferedReader( new FileReader("nurse.txt") );
            String nurseEntry = nurseData.readLine();

            while (nurseEntry != null) {
                String[] nurseValues = nurseEntry.split(",");
                String nurseID = nurseValues[0].trim();
                String nurseName = nurseValues[1].trim();

                nurseMap.put(nurseID, nurseName);
                nurseEntry = nurseData.readLine();
            }

            // Bed(bed_num, bed_room_num, bed_unit, patient_num, nurse_id)
            BufferedReader bedData = new BufferedReader( new FileReader("bed.txt") );
            String bedEntry = bedData.readLine();

            while (bedEntry != null) {

                String[] bedAttributes = bedEntry.split(",");

                String bedNurse = bedAttributes[4].trim();
                String bedNum = bedAttributes[0].trim();

                if (!bedNurse.equalsIgnoreCase("NULL") 
                    && !nurseResults.containsKey(bedNurse)) {
                    nurseResults.put(bedNurse, nurseMap.get(bedNurse)); // add nurse_id and nurse_name
                }

                bedEntry = bedData.readLine();
            }

            // Print results
            for (Map.Entry<String, String> entry : nurseResults.entrySet()) {
                System.out.println(entry.getValue());
            }

            nurseData.close();
            bedData.close();

        } catch (FileNotFoundException e) {
            System.out.println("Error reading file.");
        } catch (IOException e) {
            System.out.println("I/O error.");
        }

        
    }


    /* For each physician ID, list the total number of hours worked.
        SELECT physician_id, SUM(hours)
        FROM timecard
        GROUP BY physician_id;
     */

    // GROUP BY == HashMap
    // word count == dictionary
    public static void Query10(){

        Map<String, Integer> physicianHours = new TreeMap<>();
        // Read data
        try {

            System.out.println("id\thours");
            System.out.println("----\t----");

            BufferedReader timecardData = new BufferedReader( new FileReader("timecard.txt") );
            // BufferedReader physicianData = new BufferedReader( new FileReader("physician.txt") );

            // Process the input to compute the query result
            // Physician(physician_id, physician_name, physician_specialty)
            // Timecard(physician_id, c_date, c_hours)

            // Compute the query

            String timecardEntry = timecardData.readLine();

            while (timecardEntry != null) {
                String[] timecardValues = timecardEntry.split(",");
                physicianHours.put( timecardValues[0].trim(), 
                    physicianHours.getOrDefault(timecardValues[0].trim(), 0) 
                    + Integer.parseInt(timecardValues[2].trim())); 
                timecardEntry = timecardData.readLine();
            }

            timecardData.close();

        } catch (FileNotFoundException e) {
            System.out.println("Error reading file.");
        } catch (IOException e) {
            System.out.println("I/O error.");
        }

        // Print the results
        for (Map.Entry<String, Integer> entry : physicianHours.entrySet()) {
            System.out.println(entry.getKey() + "\t" + entry.getValue());
        }
    }


    public static void main(String[] args) {

        System.out.println("Query 9: Retrieve the names of all nurses who monitor at least one bed.");
        System.out.println();
        Query09();
        System.out.println();
        System.out.println("Query 10: For each physician ID, list the total number of hours worked.");
        System.out.println();
        Query10();
        
    }
}
