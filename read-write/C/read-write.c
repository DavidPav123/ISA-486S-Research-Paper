#include <stdio.h>
#include <stdlib.h>

#define BUFFER_SIZE 4096

int main() {
    char buffer[BUFFER_SIZE];
    size_t bytes;

    // Open the source file for reading
    FILE* sourceFile = fopen("/workspaces/ISA-486S-Research-Paper/read-write/source.txt", "rb");
    if (sourceFile == NULL) {
        perror("Error opening source file");
        return 1;
    }

    // Open the destination file for writing
    FILE* destFile = fopen("/workspaces/ISA-486S-Research-Paper/read-write/destination.txt", "wb");
    if (destFile == NULL) {
        perror("Error opening destination file");
        fclose(sourceFile); // Close the source file before exiting
        return 1;
    }

    // Read from source and write to destination in chunks of BUFFER_SIZE
    while ((bytes = fread(buffer, 1, BUFFER_SIZE, sourceFile)) > 0) {
        if (fwrite(buffer, 1, bytes, destFile) != bytes) {
            perror("Error writing to destination file");
            fclose(sourceFile);
            fclose(destFile);
            return 1;
        }
    }

    // Close the files
    fclose(sourceFile);
    fclose(destFile);

    return 0;
}
