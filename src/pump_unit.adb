with Pump;
with Fuel_Units;
use Fuel_Units;

package body Pump_Unit
  with SPARK_Mode => On
is

   procedure Lift_Nozzle (s: in out State;
                          p: in Fuel_Type) is
   begin

      s.Current_State := Ready_State;

   end Lift_Nozzle;


   procedure Replace_Nozzle (s: in out State;
                             p: in Fuel_Type) is
   begin
      null;
   end Replace_Nozzle;


   procedure Start_Pumping (s: in out State) is
   begin
      null;
   end Start_Pumping;


   procedure Stop_Pumping (s: in out State;
                           p: in Pump.Pump_State) is
   begin
      null;
   end Stop_Pumping;


   procedure Pay (s: in out State) is
   begin
      null;
   end Pay;

   function Init (a: in Pump_Array) return State is
      v: State := (Positive (a'Length), Base_State, false, Positive (a'Length), a);
   begin
      return v;
   end Init;

   function Get_Fuel_Pump(f: Fuel_Type;
                          a: Pump_Array) return Positive is
      l : Positive := a'Length;
   begin
      for i in a'Range loop
         if Pump.Has_Fuel_Type(f, a(i)) then
            return i;
         end if;
      end loop;
      return l;
   end Get_Fuel_Pump;


end Pump_Unit;
