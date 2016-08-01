with Fuel_Units;
use Fuel_Units;
with Ada.Text_IO;
use Ada.Text_IO;

package body Reservoir
with SPARK_Mode => on
is

   function Init (f : in Fuel_Type;
                  a : in Litre) return Reservoir_State is
      l : Reservoir_State := (f,a);
   begin
      Put_Line(Float'Image((Float(a))));
      return l;
   end Init;

   function Has_Fuel_Type (f: Fuel_Type;
                           p: in Reservoir_State) return Boolean is
   begin
      return p.F_T = f;
   end Has_Fuel_Type;


end Reservoir;
