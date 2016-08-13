with Reservoir;
with Fuel_Units;
use Fuel_Units;

package body Pump
with SPARK_Mode => On
is

   function Init (r : in Reservoir.Reservoir_State) return Pump_State is
      ((r, 0));

   function Has_Fuel_Type (f: in Fuel_Type;
                           p: in Pump_State) return Boolean is
    (Reservoir.Has_Fuel_Type(f, p.Reserve));


   function Get_Amount_Pumped(p: in Pump_State) return Litre is (p.Amount_Pumped);

   function Can_Pump(p: in Pump_State; a: in Litre) return Boolean is
      (Reservoir.Can_Pump(p.Reserve, a));

   procedure Set_Amount_Pumped(p: in out Pump_State;
                               a: in Litre) is
   begin
      p.Amount_Pumped := a; --p.Amount_Pumped + a;
      Reservoir.Set_Amount(p.Reserve, a);
   end Set_Amount_Pumped;

end Pump;
