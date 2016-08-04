with Fuel_Units;
use Fuel_Units;


package Tank
with SPARK_Mode => on
is

   type Tank_State is
      record
         Total_Volume: Litre;
         Volume_Used: Litre;
      end record;
   --with Volume_Used <= Total_Volume;

   function Is_Full (t: in Tank_State) return Boolean
     with Depends => (Is_Full'Result => t),
     Pre => (t.Total_Volume >= t.Volume_Used);

   function Init (v: Litre) return Tank_State
     with Depends => (Init'Result => v),
     Pre => (v <= Litre(0.0));


end Tank;
