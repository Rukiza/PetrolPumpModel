with Fuel_Units;
use Fuel_Units;


package body Tank
with SPARK_Mode => on
is

   function Is_Full (t: in Tank_State) return Boolean
   is
     ((t.Total_Volume = t.Volume_Used));

   function Init (v: in Litre) return Tank_State
   is
     ((v, Litre(0.0)));

   procedure Add_Fuel (t: in out Tank_State) is
   begin
      --if (Litre'Succ(t.Volume_Used) in Litre'Range and
            --Litre'Succ(t.Volume_Used) <= t.Total_Volume) then
         t.Volume_Used := t.Volume_Used + 1;
      --end if;
   end Add_Fuel;

end Tank;
