with Pump;
with Fuel_Units;
use Fuel_Units;

package Pump_Unit
  with SPARK_Mode => On
is

   type State_Enum is private;

   type State is private;

   procedure Lift_Nozzle (s: in out State;
                          p: out Pump.Pump_State);

   procedure Replace_Nozzle (s: in out State;
                            p: in Pump.Pump_State);

   procedure Start_Pumping (s: in out State;
                            p: in out Pump.Pump_State);

   procedure Stop_Pumping (s: in out State;
                           p: Pump.Pump_State);

   procedure Pay (s: in out State);

private

type State_Enum is (Base_State, Ready_State, Pumping_State, Waiting_State);

type State is
   record
         Current_State: State_Enum;
         Has_Selected: Boolean;
         Selected: Pump;
         Fuel_Consumed: Litre;
   end record;

end Pump_Unit;
