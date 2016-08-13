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

   function Init (r : in Reservoir.Reservoir_State) return Pump_State
     with Depends => (Init'Result => (r)),
     Pre => (Reservoir.Get_Amount(r) >= 0),
     Post => (Get_Amount_Pumped(Init'Result) = 0);

   function Has_Fuel_Type (f: in Fuel_Type;
                           p: in Pump_State) return Boolean
     with Depends => (Has_Fuel_Type'Result => (f, p));

   function Get_Amount_Pumped(p: in Pump_State) return Litre
     with Depends => (Get_Amount_Pumped'Result => (p)),
     Pre => (p.Amount_Pumped >= Litre (0.0)),
   Post => (Get_Amount_Pumped'Result = p.Amount_Pumped);

   procedure Set_Amount_Pumped(p: in out Pump_State;
                               a: in Litre)
     with Depends => (p => (p, a)),
     Pre => (Can_Pump(p, a) and p.Amount_Pumped + a in Litre'Range),
     Post => (p'Old.Amount_Pumped = p.Amount_Pumped + a and
                Reservoir.Get_Amount(p.Reserve) =
                  Reservoir.Get_Amount(p'Old.Reserve) - a);


   function Can_Pump(p: in Pump_State; a: in Litre) return Boolean
   with Depends => (Can_Pump'Result => (p, a));




end Pump;
