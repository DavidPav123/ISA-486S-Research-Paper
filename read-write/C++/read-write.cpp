#include <fstream>
#include <iostream>

void copyFileCharacterByCharacter(const std::string& sourcePath, const std::string& destinationPath) {
    // Open the source file for reading
    std::ifstream sourceFile(sourcePath, std::ifstream::in);
    // Open the destination file for writing
    std::ofstream destinationFile(destinationPath, std::ofstream::out);

    if (!sourceFile.is_open() || !destinationFile.is_open()) {
        std::cerr << "Error opening files!" << std::endl;
        return;
    }

    char character;
    // Read from the source file one character at a time and write to the destination file
    while (sourceFile.get(character)) {
        destinationFile << character;
    }

    // Close the files
    sourceFile.close();
    destinationFile.close();
}

int main() {
    std::string sourcePath = "/workspaces/ISA-486S-Research-Paper/read-write/source.txt";
    std::string destinationPath = "/workspaces/ISA-486S-Research-Paper/read-write/destination.txt";

    copyFileCharacterByCharacter(sourcePath, destinationPath);

    return 0;
}
