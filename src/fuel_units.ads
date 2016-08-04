package Fuel_Units
with SPARK_Mode => On
is

   type Fuel_Type is (Petrol91, Petrol95, Diesel);

   type Litre is digits 3 range 0.0 .. 100000.0 ;


end Fuel_Units;
