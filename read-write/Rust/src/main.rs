use std::fs::File;
use std::io::{self, Read, Write};

fn copy_file_char_by_char(src: &str, dst: &str) -> io::Result<()> {
    // Open the source file for reading
    let mut src_file = File::open(src)?;

    // Create the destination file for writing
    let mut dst_file = File::create(dst)?;

    // Buffer to hold the character read from the source file
    let mut buffer = [0; 1];

    // Read each character from the source file and write to the destination file
    while let Ok(bytes_read) = src_file.read(&mut buffer) {
        if bytes_read == 0 {
            // End of file reached
            break;
        }
        // Write the character to the destination file
        dst_file.write_all(&buffer)?;
    }

    Ok(())
}

fn main() {
    let src_path = "/workspaces/ISA-486S-Research-Paper/read-write/source.txt";
    let dst_path = "/workspaces/ISA-486S-Research-Paper/read-write/destination.txt";

    match copy_file_char_by_char(src_path, dst_path) {
        Ok(_) => (),
        Err(e) => eprintln!("Failed to copy file: {}", e),
    }
}
