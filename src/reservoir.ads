with Fuel_Units;
use Fuel_Units;

package Reservoir
with SPARK_Mode => on
is

   type Reservoir_State is private;

   function Init (f : in Fuel_Type;
                  a : in Litre) return Reservoir_State;

   function Has_Fuel_Type (f: Fuel_Type;
                           p: in Reservoir_State) return Boolean;

private


   type Reservoir_State is
      record
         F_T : Fuel_Type;
         Amount : Litre;
      end record;




end Reservoir;
