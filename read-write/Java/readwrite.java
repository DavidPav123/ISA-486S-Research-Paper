import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class readwrite {
    public static void main(String[] args) {
        String sourceFile = "/workspaces/ISA-486S-Research-Paper/read-write/source.txt"; 
        String destinationFile = "/workspaces/ISA-486S-Research-Paper/read-write/destination.txt"; 

        FileReader reader = null;
        FileWriter writer = null;

        try {
            reader = new FileReader(sourceFile);
            writer = new FileWriter(destinationFile);

            int character;

            // Read and write one character at a time
            while ((character = reader.read()) != -1) {
                writer.write(character);
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // Close the resources in the finally block to ensure they are closed even if an exception occurs
            try {
                if (reader != null) {
                    reader.close();
                }
                if (writer != null) {
                    writer.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
}
