with Reservoir;
with Fuel_Units;
use Fuel_Units;

generic
   type Fuel_Type is private;

package Pump
with SPARK_Mode => On
is

   package PumpReservior is new Reservoir(Fuel_Type);

end Pump;
