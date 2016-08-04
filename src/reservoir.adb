with Fuel_Units;
use Fuel_Units;
with Ada.Text_IO;
use Ada.Text_IO;

package body Reservoir
with SPARK_Mode => on
is

   function Init (f : in Fuel_Type;
                  a : in Litre) return Reservoir_State is
      ((f, a));

   function Has_Fuel_Type (f: Fuel_Type;
                           p: in Reservoir_State) return Boolean is
     (p.F_T = f);


end Reservoir;
