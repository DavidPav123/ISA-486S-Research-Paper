with Ada.Text_IO; use Ada.Text_IO;
package body Fibonacci is
   function Compute(N : Natural) return Natural is
   begin
      if N <= 1 then
         return N;
      else
         return Compute(N - 1) + Compute(N - 2);
      end if;
   end Compute;
end Fibonacci;
