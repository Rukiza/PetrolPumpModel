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

   function Has_Fuel_Type (f: in Fuel_Type;
                           p: in Pump_State) return Boolean is
    (Reservoir.Has_Fuel_Type(f, p.Reserve));


   function Get_Amount_Pumped(p: in Pump_State) return Litre is (p.Amount_Pumped);

   function Can_Pump(p: in Pump_State; a: in Litre) return Boolean is
   begin
      return true;
   end Can_Pump;

end Pump;
