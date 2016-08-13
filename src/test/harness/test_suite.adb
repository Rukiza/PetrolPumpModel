with Pump_Unit_Tests;

package body Test_Suite is

   use AUnit.Test_Suites;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is

      TS_Ptr : constant Access_Test_Suite := new AUnit.Test_Suites.Test_Suite;
   begin

      TS_Ptr.Add_Test (new Pump_Unit_Tests.TC) ;

      return TS_Ptr;

   end Suite;

end Test_Suite;
