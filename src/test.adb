--package body Test is
with Reservoir;
with Pump;
with Pump_Unit;
with Fuel_Units;
use Fuel_Units;

procedure Test is
   j : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol91, 1000.0));
   k : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol95, 100000.0));
   m : Pump.Pump_State := Pump.Init(Reservoir.Init(Diesel, 500.0));
   a : Pump_Unit.Pump_Array := (j, k, m);
   l : Pump_Unit.State := Pump_Unit.Init(a);

begin
   Pump_Unit.Lift_Nozzle(l, Petrol91);
end Test;


--end Test;
