#include <stdio.h>
#include <stdlib.h>

void copyFileCharacterByCharacter(const char* sourcePath, const char* destinationPath) {
    // Open the source file for reading
    FILE* sourceFile = fopen(sourcePath, "r");
    if (sourceFile == NULL) {
        perror("Error opening source file");
        exit(EXIT_FAILURE);
    }

    // Open the destination file for writing
    FILE* destinationFile = fopen(destinationPath, "w");
    if (destinationFile == NULL) {
        fclose(sourceFile); // Make sure to close sourceFile before exiting
        perror("Error opening destination file");
        exit(EXIT_FAILURE);
    }

    int ch; // To store each character read from the source file

    // Read from the source file character by character and write to the destination file
    while ((ch = fgetc(sourceFile)) != EOF) {
        fputc(ch, destinationFile);
    }

    // Close both files
    fclose(sourceFile);
    fclose(destinationFile);
}

int main() {
    const char* sourcePath = "/workspaces/ISA-486S-Research-Paper/read-write/source.txt";
    const char* destinationPath = "/workspaces/ISA-486S-Research-Paper/read-write/destination.txt";

    copyFileCharacterByCharacter(sourcePath, destinationPath);

    return 0;
}
