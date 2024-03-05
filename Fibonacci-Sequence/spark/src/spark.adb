with Ada.Text_IO; use Ada.Text_IO;
with Fibonacci; use Fibonacci;

procedure Spark is
   Max : constant Natural := 40; -- Generate up to the 40th Fibonacci number
begin
   for I in 0 .. Max loop
      Put(Compute(I)'Img & " ");
   end loop;
   New_Line;
end Spark;
