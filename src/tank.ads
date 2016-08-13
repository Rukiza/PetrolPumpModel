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
     Pre => (t.Total_Volume >= t.Volume_Used),
     Post => (if Is_Full'Result then t.Total_Volume = t.Volume_Used else t.Total_Volume > t.Volume_Used) ;

   function Init (v: Litre) return Tank_State
     with Depends => (Init'Result => v),
     Pre => (v >= Litre(0.0)),
     Post => (Init'Result.Total_Volume = v and
             Init'Result.Volume_Used = 0);

   procedure Add_Fuel (t: in out Tank_State)
     with Depends => (t => (t)),
     Pre => (t.Total_Volume > t.Volume_Used) and (t.Volume_Used + 1 in Litre'Range),
     Post => (t.Total_Volume >= t.Volume_Used) and
     t'Old.Volume_Used = t.Volume_Used - 1;--,
--   Contract_Cases => (t.Total_Volume > t.Volume_Used => t.Total_Volume >= t.Volume_Used);
end Tank;
