import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class readwrite {
    public static void main(String[] args) {
        String sourceFile = "/workspaces/ISA-486S-Research-Paper/read-write/source.txt"; // Source file path
        String destinationFile = "/workspaces/ISA-486S-Research-Paper/read-write/destination.txt"; // Destination file
                                                                                                   // path

        FileInputStream inputStream = null;
        FileOutputStream outputStream = null;
        byte[] buffer = new byte[4096]; // Buffer of 4096 bytes

        try {
            inputStream = new FileInputStream(sourceFile);
            outputStream = new FileOutputStream(destinationFile);

            int bytesRead;

            // Read from source and write to destination in chunks of 4096 bytes
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // Close the streams to release system resources
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (outputStream != null) {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
