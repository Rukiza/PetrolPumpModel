with Reservoir;
with Fuel_Units;
use Fuel_Units;

package Pump
with SPARK_Mode => On
is

   type Pump_State is private;

   function Init (r : in Reservoir.Reservoir_State) return Pump_State;

   function Has_Fuel_Type (f: Fuel_Type;
                           p: in Pump_State) return Boolean;


   private

type Pump_State is
   record
         Reserve : Reservoir.Reservoir_State;
         Amount_Pumped : Litre;
   end record;

end Pump;
