with Reservoir;
with Fuel_Units;
use Fuel_Units;



generic
   type Fuel_Type is private;



package Pump
with SPARK_Mode => On
is

   type Pump_State is private;

   function Init (r : in Reservoir.Reservoir_State) return Pump_State;

   private

type Pump_State is
   record
         Reserve : Reservoir.Reservoir_State;
         Amount_Pumped : Litre;
   end record;

end Pump;
