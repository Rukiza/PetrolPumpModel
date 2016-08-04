with Reservoir;
with Fuel_Units;
use Fuel_Units;

package Pump
with SPARK_Mode => On
is

   type Pump_State is
   record
         Reserve : Reservoir.Reservoir_State;
         Amount_Pumped : Litre;
   end record;

   function Init (r : in Reservoir.Reservoir_State) return Pump_State;

   function Has_Fuel_Type (f: in Fuel_Type;
                           p: in Pump_State) return Boolean
     with Depends => (Has_Fuel_Type'Result => (f, p));

   function Get_Amount_Pumped(p: in Pump_State) return Litre
     with Depends => (Get_Amount_Pumped'Result => (p)),
       Pre => (p.Amount_Pumped >= Litre (0.0));


   function Can_Pump(p: in Pump_State; a: in Litre) return Boolean;




end Pump;
