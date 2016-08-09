with Fuel_Units;
use Fuel_Units;
with Ada.Text_IO;
use Ada.Text_IO;

package body Reservoir
with SPARK_Mode => on
is

   function Init (f : in Fuel_Type;
                  a : in Litre) return Reservoir_State is
      ((f, a));

   function Has_Fuel_Type (f: Fuel_Type;
                           p: in Reservoir_State) return Boolean is
     (p.F_T = f);

   function Can_Pump (r: in Reservoir_State;
                      a: in Litre) return Boolean is
      (r.Amount - a >= Litre(0));

   function Get_Amount(r: in Reservoir_State) return Litre is
     (r.Amount);

   procedure Set_Amount(r: in out Reservoir_State;
                        a: in Litre) is
   begin
      r.Amount := r.Amount - a;
   end Set_Amount;

end Reservoir;
