with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Exceptions;

procedure spark is
   Buffer_Size : constant := 4096; -- Size of the buffer
   Input_File  : File_Type;
   Output_File : File_Type;
   Buffer      : String (1 .. Buffer_Size);
   Bytes_Read  : Natural;
begin
   -- Open the input file
   begin
      Open (File => Input_File,
            Mode => In_File,
            Name => "/workspaces/ISA-486S-Research-Paper/read-write/source.txt");
   exception
      when Ada.Text_IO.Name_Error =>
         Put_Line ("Error: File not found or path is incorrect.");
         return;
      when others =>
         Put_Line ("Error: Unable to open input file.");
         return;
   end;

   -- Open the output file
   begin
      Open (File => Output_File,
            Mode => Out_File,
            Name => "/workspaces/ISA-486S-Research-Paper/read-write/destination.txt");
   exception
      when others =>
         Put_Line ("Error: Unable to open output file.");
         return;
   end;

   -- Read from input file and write to output file using buffer
   loop
      begin
         -- Read from input file into buffer
         Ada.Text_IO.Get_Line (File => Input_File,
                               Item => Buffer,
                               Last => Bytes_Read);
      exception
         when End_Error =>
            exit; -- End of file reached
         when others =>
            Put_Line ("Error: Unable to read from input file.");
            return;
      end;

      -- Write buffer content to output file
      begin
         Ada.Text_IO.Put_Line (File => Output_File,
                                Item => Buffer (1 .. Bytes_Read));
      exception
         when others =>
            Put_Line ("Error: Unable to write to output file.");
            return;
      end;
   end loop;

   -- Close the files
   begin
      Close (File => Input_File);
   exception
      when others =>
         Put_Line ("Error: Unable to close input file.");
   end;

   begin
      Close (File => Output_File);
   exception
      when others =>
         Put_Line ("Error: Unable to close output file.");
   end;

   Put_Line ("File read and write operation completed successfully.");
end spark;
