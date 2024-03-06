with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Spark is
    type Integer_Array is array (Natural range <>) of Integer;
    File : File_Type;
    Numbers : Integer_Array (1 .. 100000); -- Adjust size as needed
    Count : Natural := 0;

    function Merge (Left, Right : Integer_Array) return Integer_Array is
        Result : Integer_Array (1 .. Left'Length + Right'Length);
        L : Natural := Left'First;
        R : Natural := Right'First;
        I : Natural := Result'First;
    begin
        while L <= Left'Last and R <= Right'Last loop
            if Left (L) <= Right (R) then
                Result (I) := Left (L);
                L := L + 1;
            else
                Result (I) := Right (R);
                R := R + 1;
            end if;
            I := I + 1;
        end loop;

        while L <= Left'Last loop
            Result (I) := Left (L);
            L := L + 1;
            I := I + 1;
        end loop;

        while R <= Right'Last loop
            Result (I) := Right (R);
            R := R + 1;
            I := I + 1;
        end loop;

        return Result;
    end Merge;

    function Merge_Sort (Arr : Integer_Array) return Integer_Array is
        Mid : constant Natural := Arr'Length / 2;
    begin
        if Arr'Length <= 1 then
            return Arr;
        else
            return Merge (Merge_Sort (Arr (Arr'First .. Arr'First + Mid - 1)), Merge_Sort (Arr (Arr'First + Mid .. Arr'Last)));
        end if;
    end Merge_Sort;

begin
    Open (File, In_File, "/workspaces/ISA-486S-Research-Paper/Sorting/random_numbers.txt");

    while not End_Of_File (File) loop
        declare
            Number : Integer;
        begin
            Get (File, Number);
            Count := Count + 1;
            Numbers (Count) := Number;
        end;
    end loop;

    Numbers (1 .. Count) := Merge_Sort (Numbers (1 .. Count));

    for Number of Numbers (1 .. Count) loop
        Put (Number);
        New_Line;
    end loop;
end Spark;