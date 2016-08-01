with Pump;
with Fuel_Units;
use Fuel_Units;

package Pump_Unit
  with SPARK_Mode => On
is

   type State_Enum is private;

   type State (Amount_Of_Pumps : Positive)is private;

   type Pump_Array is array (Positive range <>) of Pump.Pump_State;

   procedure Lift_Nozzle (s: in out State;
                          p: in Fuel_Type);

   procedure Replace_Nozzle (s: in out State;
                            p: in Fuel_Type);

   procedure Start_Pumping (s: in out State);

   procedure Stop_Pumping (s: in out State;
                           p: in Pump.Pump_State);

   procedure Pay (s: in out State);

   function Init (a: in Pump_Array) return State;

private

   type State_Enum is (Base_State, Ready_State, Pumping_State, Waiting_State);
   --type Pump_Array is array (Positive range <>) of Pump.Pump_State;

type State (Amount_of_Pumps : Positive) is
   record
         Current_State: State_Enum;
         Has_Selected: Boolean;
         Selected: Positive;
         Pumps: Pump_Array (1 .. Amount_of_Pumps);
   end record;

end Pump_Unit;
