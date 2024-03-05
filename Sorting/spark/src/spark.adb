with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure spark is
   type Number_Array is array (Natural range <>) of Integer;
   File : File_Type;

   function Read_Numbers return Number_Array is
      Arr : Number_Array (1 .. 100);
      I : Integer := 1;
   begin
      Open (File, In_File, "numbers.txt");
      while not End_Of_File (File) loop
         Get (File, Arr (I));
         I := I + 1;
      end loop;
      Close (File);
      return Arr (1 .. I - 1);
   end Read_Numbers;

   procedure Merge (Left, Right : Number_Array; Result : out Number_Array) is
      I, J, K : Integer;
   begin
      I := Left'First;
      J := Right'First;
      K := Result'First;
      while I <= Left'Last and then J <= Right'Last loop
         if Left (I) <= Right (J) then
            Result (K) := Left (I);
            I := I + 1;
         else
            Result (K) := Right (J);
            J := J + 1;
         end if;
         K := K + 1;
      end loop;
      while I <= Left'Last loop
         Result (K) := Left (I);
         I := I + 1;
         K := K + 1;
      end loop;
      while J <= Right'Last loop
         Result (K) := Right (J);
         J := J + 1;
         K := K + 1;
      end loop;
   end Merge;

   procedure Merge_Sort (Arr : in out Number_Array) is
      Mid : constant Integer := Arr'Length / 2;
      Left : Number_Array (Arr'First .. Mid);
      Right : Number_Array (Mid + 1 .. Arr'Last);
   begin
      if Arr'Length > 1 then
         Left := Arr (Arr'First .. Mid);
         Right := Arr (Mid + 1 .. Arr'Last);
         Merge_Sort (Left);
         Merge_Sort (Right);
         Merge (Left, Right, Arr);
      end if;
   end Merge_Sort;

   

   Numbers : Number_Array := Read_Numbers;
begin
   Merge_Sort (Numbers);
   for I in Numbers'Range loop
      Put (Numbers (I));
      New_Line;
   end loop;
end spark;