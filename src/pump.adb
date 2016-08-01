with Reservoir;
with Fuel_Units;
use Fuel_Units;

package body Pump
with SPARK_Mode => On
is

   function Init (r : in Reservoir.Reservoir_State) return Pump_State is
      l :Pump_State := (r, 0.000);
   begin
      return l;
   end Init;

   function Has_Fuel_Type (f: Fuel_Type;
                           p: in Pump_State) return Boolean is
   begin
      return Reservoir.Has_Fuel_Type(f, p.Reserve);
   end Has_Fuel_Type;

end Pump;
