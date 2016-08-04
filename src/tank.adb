with Fuel_Units;
use Fuel_Units;


package body Tank
with SPARK_Mode => on
is

   function Is_Full (t: in Tank_State) return Boolean
   is
     ((t.Total_Volume > t.Volume_Used));

   function Init (v: in Litre) return Tank_State
   is
      ((v, Litre(0.0)));

end Tank;
