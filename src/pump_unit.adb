with Pump;
with Fuel_Units;
with Tank;
with Currency;
use Fuel_Units;
use Currency;

package body Pump_Unit
  with SPARK_Mode => On
is

   procedure Lift_Nozzle (s: in out State;
                          p: in Fuel_Type) is
   begin

      s.Current_State := Ready_State;
      s.Selected := p;--Get_Fuel_Pump(p, s.Pumps);
      s.Has_Selected := true;

   end Lift_Nozzle;


   procedure Replace_Nozzle (s: in out State;
                             p: in Fuel_Type) is
   begin

      if (Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) < Litre(0.0) and
         p = s.Selected and s.Current_State = Ready_State) then
         s.Current_State := Waiting_State;
      elsif (Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) = Litre(0.0) and
         p = s.Selected and s.Current_State = Ready_State) then
           s.Current_State := Base_State;
      end if;

   end Replace_Nozzle;


   procedure Start_Pumping (s: in out State;
                            a: in Litre;
                            t: in Tank.Tank_State) is
   begin
      if (Pump.Can_Pump(s.Pumps(s.Selected), a)) then
         s.Current_State := Pumping_State;
         s.Amount_To_Be_Pumped := a;
         s.Tank_To_Be_Fulled := t;
      end if;

   end Start_Pumping;


   procedure Stop_Pumping (s: in out State;
                           a: in Litre;
                           t: out Tank.Tank_State) is
      l : Litre := Litre(0);
   begin
      t := s.Tank_To_Be_Fulled;
      while (not Tank.Is_Full(t) and l < a) loop
         Tank.Add_Fuel(t);
         l := Litre'Succ(l);
      end loop;
      Pump.Set_Amount_Pumped(s.Pumps(s.Selected), l);
      s.Current_State := Ready_State;
   end Stop_Pumping;


   procedure Pay (s: in out State;
                  a: in Money) is
   begin
      null;
   end Pay;

   function Init (a: in Pump_Array) return State is
      ((Base_State, false, Petrol91, a, Litre(0.0), (Litre(0), Litre(0))));

   --function Get_Fuel_Pump(f: Fuel_Type;
   --                       a: Pump_Array) return Positive is
   --   l : Positive := 1;
   --begin
   --   for i in a'Range loop
   --      if Pump.Has_Fuel_Type(f, a(i)) then
   --         l := i;
   --         return l;
   --      end if;
   --   end loop;
   --   return l;
   --end Get_Fuel_Pump;

   function Get_Current_State(s: State) return State_Enum is (s.Current_State);


end Pump_Unit;
