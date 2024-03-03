with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

procedure readwrite is
    Input_File  : File_Type;
    Output_File : File_Type;
    Line        : String(1..200);
    Last        : Natural;
begin
    -- Open the input file in read-mode. Adjust "input.txt" to your file's name.
    Open (File => Input_File, Mode => In_File, Name => "input.txt");
    
    -- Open the output file in write-mode. Adjust "output.txt" to your desired file's name.
    Create (File => Output_File, Mode => Out_File, Name => "output.txt");
    
    -- Read from the input file and write to the output file line by line.
    while not End_Of_File(Input_File) loop
        Get_Line (File => Input_File, Item => Line, Last => Last);
        Put_Line (File => Output_File, Item => Line(1..Last));
    end loop;
    
    -- Close both files.
    Close (File => Input_File);
    Close (File => Output_File);
exception
    -- Handle exceptions, such as file not found.
    when E : others =>
        Put_Line ("An error occurred: " & Exception_Message(E));
end readwrite;
