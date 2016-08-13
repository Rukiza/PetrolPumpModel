
--with Ada.Text_IO;

with Reservoir;
with Pump;
with Pump_Unit;
with Fuel_Units;
with Tank;
   --use Ada.Text_IO;
use Fuel_Units;

procedure Test
with SPARK_Mode => on
is

   j : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol91, 1000));
   k : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol95, 100000));
   m : Pump.Pump_State := Pump.Init(Reservoir.Init(Diesel, 500));
   a : Pump_Unit.Pump_Array := (j, k, m);
   l : Pump_Unit.State;-- Pump_Unit.Init(a);
   t : Tank.Tank_State := Tank.Init(50);

begin
   if (for all i in a'Range => Pump.Has_Fuel_Type(i, a(i))) then
         --Put_Line("1");
      l := Pump_Unit.Init(a);
         --Put_Line("2");
      Pump_Unit.Lift_Nozzle(l, Petrol91);
         --Put_Line("3");
      Pump_Unit.Replace_Nozzle(l, Petrol91);
         --Put_Line("4");
      Pump_Unit.Lift_Nozzle(l, Petrol95);
         --Put_Line("5");
      Pump_Unit.Start_Pumping(l, 30, t);
         --Put_Line("6");
      Pump_Unit.Stop_Pumping(l,30,t);
   end if;


end Test;


--end Test;
