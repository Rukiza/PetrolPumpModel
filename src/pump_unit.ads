with Pump;
with Fuel_Units;
use Fuel_Units;

package Pump_Unit
  with SPARK_Mode => On
is

type State_Enum is private;



private

type State_Enum is (Base_State, Ready_State, Pumping_State, Waiting_State);

type State is
   record
      Current_State: State_Enum;
      Selected: Pump;
      Fuel_Consumed: Litre;
   end record;

end Pump_Unit;
