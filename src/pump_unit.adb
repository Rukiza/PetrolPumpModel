with Pump;
with Fuel_Units;
with Tank;
with Currency;
with Ada.Text_IO;
use Fuel_Units;
use Currency;

package body Pump_Unit
  with SPARK_Mode => On
is

   procedure Lift_Nozzle (s: in out State;
                          p: in Fuel_Type) is
   begin
      if (s.Current_State = Waiting_State or s.Current_State = Base_State) then
         s.Current_State := Ready_State;
         s.Selected := p;--Get_Fuel_Pump(p, s.Pumps);
         s.Has_Selected := true;
      end if;

   end Lift_Nozzle;


   procedure Replace_Nozzle (s: in out State;
                             p: in Fuel_Type) is
   begin

      if (Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) > Litre(0) and
         p = s.Selected and s.Current_State = Ready_State) then
         s.Current_State := Waiting_State;
      elsif (Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) = Litre(0) and
         p = s.Selected and s.Current_State = Ready_State) then
         s.Current_State := Base_State;
         s.Has_Selected := False;
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
      while ((not Tank.Is_Full(t)) and l < a) loop
         Tank.Add_Fuel(t);
         l := l + Litre(1);
      end loop;
      --Ada.Text_IO.Put_Line(l'Image);
      s.Amount_To_Be_Pumped := 0;
      Pump.Set_Amount_Pumped(s.Pumps(s.Selected), l);
      --Ada.Text_IO.Put_Line(Pump.Get_Amount_Pumped(s.Pumps(s.Selected))'Image);
      s.Current_State := Ready_State;
   end Stop_Pumping;


   procedure Pay (s: in out State;
                  l: in Litre) is
   begin
      if (s.Current_State = Waiting_State
          and
            Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) >= l)  then
         Pump.Set_Amount_Pumped(
                                s.Pumps(s.Selected),
                                Pump.Get_Amount_Pumped(s.Pumps(s.Selected))
                                - l);
         if (Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) = 0) then
            Pump.Set_Amount_Pumped(s.Pumps(s.Selected),
                                   0);
            s.Has_Selected := False;
            s.Current_State := Base_State;
         end if;

      end if;
   end Pay;

   function Init (a: in Pump_Array) return State is
      ((Base_State, false, Petrol91, a, Litre(0), (Litre(0), Litre(0))));

   function CheckState (s: in State;
                        To_Check: in State_Enum) return Boolean is
      (s.Current_State = To_Check);

   function Get_Current_State(s: State) return State_Enum is (s.Current_State);


end Pump_Unit;
