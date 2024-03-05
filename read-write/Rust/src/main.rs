use std::fs::File;
use std::io::{self, Read, Write};

fn copy_file(source_path: &str, destination_path: &str) -> io::Result<()> {
    let mut source_file = File::open(source_path)?;
    let mut destination_file = File::create(destination_path)?;

    let mut buffer = [0; 4096]; // Buffer of 4096 bytes

    // Read from source and write to destination in chunks of 4096 bytes
    while let Ok(bytes_read) = source_file.read(&mut buffer) {
        if bytes_read == 0 {
            break; // End of file reached
        }
        destination_file.write_all(&buffer[..bytes_read])?;
    }

    Ok(())
}

fn main() {
    let source = "/workspaces/ISA-486S-Research-Paper/read-write/source.txt";
    let destination = "/workspaces/ISA-486S-Research-Paper/read-write/destination.txt";

    match copy_file(source, destination) {
        Ok(_) => (),
        Err(e) => eprintln!("Error copying file: {}", e),
    }
}
