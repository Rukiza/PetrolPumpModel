with Currency;
use Currency;

package Fuel_Units
with SPARK_Mode => On
is

   type Fuel_Type is (Petrol91, Petrol95, Diesel);

   type Litre is new Integer range 0.. 100000 ;

     type Fuel_Price is
      record
         Fuel: Fuel_Type;
         Price: Money;
      end record;

   type Prices is array (Fuel_Type range Fuel_Type'Range) of Fuel_Price;

end Fuel_Units;
