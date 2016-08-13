with Pump_Unit_Tests;
with Aunit;
with AUnit.Test_Suites;

package Test_Suite is

   use AUnit.Test_Suites;

   function Suite return AUnit.Test_Suites.Access_Test_Suite;

end Test_Suite;
