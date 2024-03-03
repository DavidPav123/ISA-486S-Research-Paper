with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

procedure readwrite is
    Input_File  : File_Type;
    Output_File : File_Type;
    My_Character   : Character; -- Corrected declaration
begin
    Open (File => Input_File, Mode => In_File, Name => "input.txt");
    Create (File => Output_File, Mode => Out_File, Name => "output.txt");
    
    while not End_Of_File(Input_File) loop
        Get (File => Input_File, Item => My_Character);
        Put (File => Output_File, Item => My_Character);
    end loop;
    
    Close (File => Input_File);
    Close (File => Output_File);
exception
    when E : others =>
        Put_Line ("An error occurred: " & Exception_Message(E));
end readwrite;
