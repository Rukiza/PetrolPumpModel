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
      s.Selected := Get_Fuel_Pump(p, s.Pumps);
      s.Has_Selected := true;

   end Lift_Nozzle;


   procedure Replace_Nozzle (s: in out State;
                             p: in Fuel_Type) is
   begin

      if (Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) < Litre(0.0)) then
         s.Current_State := Waiting_State;
      end if;

   end Replace_Nozzle;


   procedure Start_Pumping (s: in out State; a: Litre) is
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

   function Get_Current_State(s: State) return State_Enum is (s.Current_State);


end Pump_Unit;
