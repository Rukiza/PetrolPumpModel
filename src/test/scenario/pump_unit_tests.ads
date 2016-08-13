with AUnit;
with AUnit.Test_Cases;

package Pump_Unit_Tests is
   type TC is new AUnit.Test_Cases.Test_Case with null record;
   overriding procedure Set_Up_Case (T: in out TC);
   overriding procedure Set_Up (T: in out TC);
   overriding procedure Tear_Down (T: in out TC);
   overriding procedure Tear_Down_Case (T: in out TC);
   procedure Register_Tests (T: in out TC);
   function Name (T: TC) return AUnit.Message_String;
end Pump_Unit_Tests;
