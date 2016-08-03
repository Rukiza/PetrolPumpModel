with Pump;
with Fuel_Units;
use Fuel_Units;

package Pump_Unit
  with SPARK_Mode => On
is

   type State_Enum is (Base_State, Ready_State, Pumping_State, Waiting_State);

   --type State (Amount_Of_Pumps : Positive)is private;

   type Pump_Array is array (Positive range <>) of Pump.Pump_State;

   type State (Amount_of_Pumps : Positive) is
   record
         Current_State: State_Enum;
         Has_Selected: Boolean;
         Selected: Positive;
         Pumps: Pump_Array (1 .. Amount_of_Pumps);
         Amount_To_Be_Pumped: Litre;
   end record;

   procedure Lift_Nozzle (s: in out State;
                          p: in Fuel_Type)
     with Depends => (s => (p, s)),
     Pre => ((s.Current_State = Base_State) and not s.Has_Selected) xor
                 ((s.Current_State = Waiting_State) and (s.Has_Selected and
                 Pump.Has_Fuel_Type(p,s.Pumps(s.Selected)))),
     Post => Pump.Has_Fuel_Type(p, s.Pumps(s.Selected));

   procedure Replace_Nozzle (s: in out State;
                             p: in Fuel_Type)
     with Depends => (s => (s, p)),
     Pre => (s.Current_State = Ready_State and
               Pump.Has_Fuel_Type(p, s.Pumps(s.Selected))),
     Post => ((s.Current_State = Base_State and
                Pump.Get_Amount_Pumped(s.Pumps(Get_Fuel_Pump(p, s.Pumps))) = Litre(0.0))
              xor (s.Current_State = Waiting_State and
                Pump.Get_Amount_Pumped(s.Pumps(Get_Fuel_Pump(p, s.Pumps))) < Litre(0.0)));


   procedure Start_Pumping (s: in out State; a: in Litre) -- needs changing.
     with Depends => (s => (s, a)),
     Pre => (s.Current_State = Ready_State and a <= Litre(0.0)),
     Post => (Pump.Can_Pump((s'Old.Pumps(s'Old.Selected)), a) and
                (Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) =
                   (Pump.Get_Amount_Pumped(s'Old.Pumps(s'Old.Selected)) + a)))
     xor ((not Pump.Can_Pump((s'Old.Pumps(s'Old.Selected)), a)) and
                (Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) =
                   (Pump.Get_Amount_Pumped(s'Old.Pumps(s'Old.Selected)))));

   procedure Stop_Pumping (s: in out State;
                           p: in Pump.Pump_State);

   procedure Pay (s: in out State);

   function Init (a: in Pump_Array) return State;

   function Get_Fuel_Pump(f: Fuel_Type;
                          a: Pump_Array) return Positive;

   --function Get_Current_State(s: State) return State_Enum;

   --type Pump_Array is array (Positive range <>) of Pump.Pump_State;


end Pump_Unit;
