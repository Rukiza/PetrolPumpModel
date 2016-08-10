--package body Test is
--with Ada.Text_IO;
--use Ada.Text_IO;
with Reservoir;
with Pump;
with Pump_Unit;
with Fuel_Units;
use Fuel_Units;

procedure Test
with SPARK_Mode => on
is

   j : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol91, 1000.0));
   k : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol95, 100000.0));
   m : Pump.Pump_State := Pump.Init(Reservoir.Init(Diesel, 500.0));
   a : Pump_Unit.Pump_Array := (j, k, m);
   l : Pump_Unit.State;-- Pump_Unit.Init(a);

begin
   if (for all i in a'Range => Pump.Has_Fuel_Type(i, a(i))) then
      l := Pump_Unit.Init(a);
      if (Pump_Unit.CheckState(l, Pump_Unit.Base_State)) then
         --Put_Line(l.Current_State'Image);
         Pump_Unit.Lift_Nozzle(l, Petrol91);
      end if;

   end if;

end Test;


--end Test;
