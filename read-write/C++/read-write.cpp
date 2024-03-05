#include <iostream>
#include <fstream>

#define BUFFER_SIZE 4096

int main() {
    // Open the source file for reading in binary mode
    std::ifstream sourceFile("/workspaces/ISA-486S-Research-Paper/read-write/source.txt", std::ios::binary);
    if (!sourceFile) {
        std::cerr << "Error opening source file." << std::endl;
        return 1;
    }

    // Open the destination file for writing in binary mode
    std::ofstream destFile("/workspaces/ISA-486S-Research-Paper/read-write/destination.txt", std::ios::binary);
    if (!destFile) {
        std::cerr << "Error opening destination file." << std::endl;
        sourceFile.close();
        return 1;
    }

    // Buffer for reading and writing
    char buffer[BUFFER_SIZE];

    // Read from source and write to destination in chunks of BUFFER_SIZE
    while (sourceFile.read(buffer, BUFFER_SIZE) || sourceFile.gcount() != 0) {
        destFile.write(buffer, sourceFile.gcount());
        if (!destFile) {
            std::cerr << "Error writing to destination file." << std::endl;
            sourceFile.close();
            destFile.close();
            return 1;
        }
    }

    // Close the files
    sourceFile.close();
    destFile.close();

    return 0;
}
