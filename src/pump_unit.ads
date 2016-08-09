with Pump;
with Tank;
with Fuel_Units;
with Currency;
use Fuel_Units;
use Currency;

package Pump_Unit
  with SPARK_Mode => On
is

   type State_Enum is (Base_State, Ready_State, Pumping_State, Waiting_State);

   --type State (Amount_Of_Pumps : Positive)is private;

   type Pump_Array is array (Fuel_Type range Fuel_Type'Range) of Pump.Pump_State;

   type State is
   record
         Current_State: State_Enum;
         Has_Selected: Boolean;
         Selected: Fuel_Type ;
         Pumps: Pump_Array;
         Amount_To_Be_Pumped: Litre;
         Tank_To_Be_Fulled: Tank.Tank_State;
   end record;

   procedure Lift_Nozzle (s: in out State;
                          p: in Fuel_Type)
     with Depends => (s => (p, s)),
     Pre =>
       ((for all j in s.Pumps'Range => Pump.Has_Fuel_Type(j, s.Pumps(j))) and then
       (for some i in s.Pumps'Range => (Pump.Has_Fuel_Type(p, s.Pumps(i)) and p = i)
        and then (if (s.Current_State = Waiting_State) then (s.Selected = i
          and s.Has_Selected)))) and
     (for some e in Fuel_Type'First .. Fuel_Type'Last => e = p) and
     ((if s.Current_State = Base_State then not s.Has_Selected) and
                 (if s.Current_State = Waiting_State then (s.Has_Selected))),
       Post => --(s.Selected in s.Pumps'Range) and then
         (( s.Selected = p)
            and then --
              --(Pump.Has_Fuel_Type(p, s.Pumps(s.Selected)) and
     s.Has_Selected = true);

   procedure Replace_Nozzle (s: in out State;
                             p: in Fuel_Type)
     with Depends => (s => (s, p)),
     Pre => (for some i in s.Pumps'Range
             => (Pump.Has_Fuel_Type(p, s.Pumps(i))
                 and Pump.Get_Amount_Pumped(s.Pumps(i)) >= Litre(0))
             and then i = s.Selected) and
     (s.Current_State = Ready_State and s.Has_Selected = true and
        ((s.Selected in s.Pumps'Range)
         and then Pump.Has_Fuel_Type(p, s.Pumps(s.Selected)))),
     Post => ( if s.Current_State = Base_State then
                Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) = Litre(0.0))
              and (if s.Current_State = Waiting_State then
                Pump.Get_Amount_Pumped(s.Pumps(p)) < Litre(0.0));


   procedure Start_Pumping (s: in out State;
                            a: in Litre;
                            t: in Tank.Tank_State) -- needs changing.
     with Depends => (s => (s, a, t)),
     Pre => (s.Current_State = Ready_State and a >= Litre(0.0)),
     Post => (((Pump.Can_Pump((s'Old.Pumps(s'Old.Selected)), a) and
                  s.Current_State = Pumping_State) and
                    s.Amount_To_Be_Pumped = a)
     xor ((not Pump.Can_Pump((s'Old.Pumps(s'Old.Selected)), a)) and
                    s.Current_State = s'Old.Current_State and
                    s.Amount_To_Be_Pumped = s'Old.Amount_To_Be_Pumped));

   procedure Stop_Pumping (s: in out State;
                           a: in Litre;
                           t: out Tank.Tank_State)
     with Depends => (s => (s, a),
                     t => (s, a)),
     Pre => (s.Current_State = Pumping_State and
               s.Amount_To_Be_Pumped >= a and
               Pump.Can_Pump(s.Pumps(s.Selected), a)),
     Post => (s.Current_State = Ready_State) and
     ((if (Tank.Is_Full(t)) then
            (Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) <=
               a)) and
     (if (not Tank.Is_Full(t)) then
            (Pump.Get_Amount_Pumped(s.Pumps(s.Selected)) =
               a)));


   procedure Pay (s: in out State;
                  a: in Money)
     with Depends => (s => (s, a)),
     Pre => (),
     Post => ();

   function Init (a: in Pump_Array) return State
     with Depends => (Init'Result => a),
     Pre => (for all i  in a'Range => Pump.Has_Fuel_Type(i,a(i))) and
     (for all i in a'Range => (for some j in Fuel_Type'Range => i = j));

   --function Get_Fuel_Pump(f: Fuel_Type;
   --                       a: Pump_Array) return Positive
   --  with Depends => (Get_Fuel_Pump'Result => (f, a)),
   --  Pre =>
   --    (a'First = 1) and (for all j in a'Range =>
   --            (for some e in Fuel_Type'First .. Fuel_Type'Last => Pump.Has_Fuel_Type(e, a(j))))
   --    and (for some J in a'Range => Pump.Has_Fuel_Type(f, a(J))),
   --  Post => (Get_Fuel_Pump'Result in a'Range) and then
   --  (Pump.Has_Fuel_Type(f, a(Get_Fuel_Pump'Result)));

   --function Get_Current_State(s: State) return State_Enum;

   --type Pump_Array is array (Positive range <>) of Pump.Pump_State;


end Pump_Unit;
