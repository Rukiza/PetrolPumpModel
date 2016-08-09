with Fuel_Units;
use Fuel_Units;

package Reservoir
with SPARK_Mode => on
is

      type Reservoir_State is
      record
         F_T : Fuel_Type;
         Amount : Litre;
      end record;

   function Init (f : in Fuel_Type;
                  a : in Litre) return Reservoir_State
     with Depends => (Init'Result => (f, a)),
     Pre => (a <= Litre(0.0));

   function Has_Fuel_Type (f: in Fuel_Type;
                           p: in Reservoir_State) return Boolean
   with Depends => (Has_Fuel_Type'Result => (f, p));

   function Can_Pump (r: in Reservoir_State;
                      a: in Litre) return Boolean
     with Depends => (Can_Pump'Result => (r, a));

   function Get_Amount(r: in Reservoir_State) return Litre
     with Depends => (Get_Amount'Result => r);

   procedure Set_Amount(r: in out Reservoir_State;
                        a: in Litre)
     with Depends => (r => (r, a)),
     Pre => (Can_Pump(r, a)),
     Post => (r.Amount = r'Old.Amount - a);

end Reservoir;
