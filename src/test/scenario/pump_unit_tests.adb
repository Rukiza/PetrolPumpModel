with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with Ada.Float_Text_IO;
with Tank;
with Pump_Unit;
with Pump;
with Reservoir;
with Fuel_Units;
use Fuel_Units;

package body Pump_Unit_Tests is

   Input_1 : Pump_Unit.State;
   Expected_1: Pump_Unit.State;
   Input_2 : Tank.Tank_State;
   Expected_2: Tank.Tank_State;


   procedure Set_Up_Case (T: in out TC) is
      pragma Unreferenced (T);
      j : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol91, 1000));
      k : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol95, 100000));
      m : Pump.Pump_State := Pump.Init(Reservoir.Init(Diesel, 500));
      a : Pump_Unit.Pump_Array := (j, k, m);
      l : Pump_Unit.State := Pump_Unit.Init(a);
      b : Tank.Tank_State := Tank.Init(50);
   begin
      New_Line;
      Put_Line ("Set up case ..");

      Expected_1 := l;
      Expected_2 := b;

   end Set_Up_Case;


   procedure Set_Up (T : in out TC) is
      j : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol91, 1000));
      k : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol95, 100000));
      m : Pump.Pump_State := Pump.Init(Reservoir.Init(Diesel, 500));
      a : Pump_Unit.Pump_Array := (j, k, m);
      l : Pump_Unit.State := Pump_Unit.Init(a);
      b : Tank.Tank_State := Tank.Init(50);
   begin
      New_Line;
      Put_Line("Set Up ..");
      Input_1 := l;
      Input_2 := b;
   end;

   procedure Tear_Down (T : in out TC) is
      j : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol91, 1000));
      k : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol95, 100000));
      m : Pump.Pump_State := Pump.Init(Reservoir.Init(Diesel, 500));
      a : Pump_Unit.Pump_Array := (j, k, m);
      l : Pump_Unit.State := Pump_Unit.Init(a);
      b : Tank.Tank_State := Tank.Init(50);
   begin
      Put_Line("Tear Down ...");
      Input_1 := l;
      Input_2 := b;
   end;

   procedure Tear_Down_Case (T : in out TC) is
      j : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol91, 1000));
      k : Pump.Pump_State := Pump.Init(Reservoir.Init(Petrol95, 100000));
      m : Pump.Pump_State := Pump.Init(Reservoir.Init(Diesel, 500));
      a : Pump_Unit.Pump_Array := (j, k, m);
      l : Pump_Unit.State := Pump_Unit.Init(a);
      b : Tank.Tank_State := Tank.Init(50);
   begin
      Put_Line ("Tear Down Case ..");
      Expected_1 := l;
      Expected_2 := b;
   end;

   --==========================================================
   --               Helper Methods.
   --==========================================================

   procedure Helper_After_Nozzle_Lifted (p: Fuel_Type) is
   begin
      Pump_Unit.Lift_Nozzle(Input_1, p);
   end Helper_After_Nozzle_Lifted;

   procedure Helper_After_Start_Pumping (a: Litre) is
   begin
      Pump_Unit.Start_Pumping(Input_1, a, Input_2);
   end Helper_After_Start_Pumping;

   -- ===========================================================
   --                 TEST CASES/SCENARIOS
   -- ===========================================================

   procedure Test_Lift_Nozzle_1 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Pump_Unit.Lift_Nozzle(Input_1, Petrol91);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Ready_State) and
                              Input_1.Has_Selected = True and
                                Input_1.Selected = Petrol91 and
                           Input_1.Amount_To_Be_Pumped = 0),
              Message => "Incorrect result after lifting nozzle.");
   end Test_Lift_Nozzle_1;

   procedure Test_Lift_Nozzle_2 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin

      Pump_Unit.Lift_Nozzle(Input_1, Petrol95);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Ready_State) and
                              Input_1.Has_Selected = True and
                                Input_1.Selected = Petrol95 and
                           Input_1.Amount_To_Be_Pumped = 0),
              Message => "Incorrect result after lifting nozzle.");
   end Test_Lift_Nozzle_2;

   procedure Test_Lift_Nozzle_3 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin

      Pump_Unit.Lift_Nozzle(Input_1, Diesel);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Ready_State) and
                              Input_1.Has_Selected = True and
                                Input_1.Selected = Diesel and
                           Input_1.Amount_To_Be_Pumped = 0),
              Message => "Incorrect result after lifting nozzle.");
   end Test_Lift_Nozzle_3;


   procedure Test_Replace_Nozzle_1 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Diesel);

      Pump_Unit.Replace_Nozzle(Input_1, Diesel);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Base_State) and
                              Input_1.Has_Selected = False and
                           Input_1.Amount_To_Be_Pumped = 0),
              Message => "Incorrect result after replacing nozzle.");
   end Test_Replace_Nozzle_1;

   procedure Test_Replace_Nozzle_2 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Petrol91);

      Pump_Unit.Replace_Nozzle(Input_1, Petrol91);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Base_State) and
                              Input_1.Has_Selected = False and
                           Input_1.Amount_To_Be_Pumped = 0),
              Message => "Incorrect result after replacing nozzle.");
   end Test_Replace_Nozzle_2;

   procedure Test_Replace_Nozzle_3 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Petrol95);

      Pump_Unit.Replace_Nozzle(Input_1, Petrol95);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Base_State) and
                              Input_1.Has_Selected = False and
                           Input_1.Amount_To_Be_Pumped = 0),
              Message => "Incorrect result after replacing nozzle.");
   end Test_Replace_Nozzle_3;

   procedure Test_Start_Pumping_1 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Petrol95);

      Pump_Unit.Start_Pumping(Input_1, 30, Input_2);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Pumping_State) and
                              Input_1.Has_Selected = True and
                           Input_1.Amount_To_Be_Pumped = 30),
              Message => "Incorrect result after replacing nozzle.");
   end Test_Start_Pumping_1;

   procedure Test_Start_Pumping_2 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Petrol91);

      Pump_Unit.Start_Pumping(Input_1, 30, Input_2);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Pumping_State) and
                              Input_1.Has_Selected = True and
                           Input_1.Amount_To_Be_Pumped = 30),
              Message => "Incorrect result after replacing nozzle.");
   end Test_Start_Pumping_2;

   procedure Test_Start_Pumping_3 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Diesel);

      Pump_Unit.Start_Pumping(Input_1, 30, Input_2);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Pumping_State) and
                              Input_1.Has_Selected = True and
                           Input_1.Amount_To_Be_Pumped = 30),
              Message => "Incorrect result after replacing nozzle.");
   end Test_Start_Pumping_3;

   procedure Test_Stop_Pumping_1 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Diesel);
      Helper_After_Start_Pumping(30);

      Pump_Unit.Stop_Pumping(Input_1, 30, Input_2);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Ready_State) and
                              Input_1.Has_Selected = True and
                           Input_1.Amount_To_Be_Pumped = 0 and
                           Input_1.Pumps(Input_1.Selected).Amount_Pumped = 30),
              Message => "Incorrect result after stop pumping.");
   end Test_Stop_Pumping_1;

   procedure Test_Stop_Pumping_2 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Diesel);
      Helper_After_Start_Pumping(30);

      Pump_Unit.Stop_Pumping(Input_1, 20, Input_2);
      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Ready_State) and
                              Input_1.Has_Selected = True and
                              Input_1.Amount_To_Be_Pumped = 0 and
                           Input_1.Pumps(Input_1.Selected).Amount_Pumped = 20),
              Message => "Incorrect result after stop pumping.");
   end Test_Stop_Pumping_2;

   procedure Test_Stop_Pumping_3 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Diesel);
      Helper_After_Start_Pumping(20);

      Pump_Unit.Stop_Pumping(Input_1, 20, Input_2);

      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Ready_State) and
                              Input_1.Has_Selected = True and
                              Input_1.Amount_To_Be_Pumped = 0 and
                           Input_1.Pumps(Input_1.Selected).Amount_Pumped = Litre(20)
                           ),
              Message => "Incorrect result after stop pumping.");
   end Test_Stop_Pumping_3;

   procedure Test_Replace_Nozzle_4 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Diesel);
      Helper_After_Start_Pumping(30);

      Pump_Unit.Stop_Pumping(Input_1, 30, Input_2);

      Pump_Unit.Replace_Nozzle(Input_1, Diesel);

      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Waiting_State) and
                              Input_1.Has_Selected = True and
                           Input_1.Amount_To_Be_Pumped = 0 and
                           Input_1.Pumps(Input_1.Selected).Amount_Pumped = 30),
              Message => "Incorrect result after stop pumping.");
   end Test_Replace_Nozzle_4;

   procedure Test_Pay_1 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Diesel);
      Helper_After_Start_Pumping(30);

      Pump_Unit.Stop_Pumping(Input_1, 30, Input_2);

      Pump_Unit.Replace_Nozzle(Input_1, Diesel);

      Pump_Unit.Pay(Input_1, 30);

      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Base_State) and
                              Input_1.Has_Selected = False and
                           Input_1.Amount_To_Be_Pumped = 0 and
                           Input_1.Pumps(Input_1.Selected).Amount_Pumped = 0),
              Message => "Incorrect result after stop pumping.");
   end Test_Pay_1;

   procedure Test_Pay_2 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Diesel);
      Helper_After_Start_Pumping(30);

      Pump_Unit.Stop_Pumping(Input_1, 30, Input_2);

      Pump_Unit.Replace_Nozzle(Input_1, Diesel);

      Pump_Unit.Pay(Input_1, 20);

      Assert (Condition => (Pump_Unit.State_Enum'Pos(Input_1.Current_State) =
                              Pump_Unit.State_Enum'Pos(Pump_Unit.Waiting_State) and
                              Input_1.Has_Selected = True and
                           Input_1.Amount_To_Be_Pumped = 0 and
                           Input_1.Pumps(Input_1.Selected).Amount_Pumped = 10),
              Message => "Incorrect result after stop pumping.");
   end Test_Pay_2;

   procedure Test_Check_State (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Helper_After_Nozzle_Lifted(Diesel);
      Helper_After_Start_Pumping(30);

      Pump_Unit.Stop_Pumping(Input_1, 30, Input_2);

      Pump_Unit.Replace_Nozzle(Input_1, Diesel);

      Pump_Unit.Pay(Input_1, 20);

      Assert (Condition => (Pump_Unit.CheckState(Input_1, Pump_Unit.Waiting_State) and
                              Input_1.Has_Selected = True and
                           Input_1.Amount_To_Be_Pumped = 0 and
                           Input_1.Pumps(Input_1.Selected).Amount_Pumped = 10),
              Message => "Incorrect result after stop pumping.");
   end Test_Check_State;

   --==========================================================
   --               REGISTRATION/NAMING
   --==========================================================

   procedure Register_Tests (T: in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test => T,
                        Routine => Test_Lift_Nozzle_1'Access,
                        Name => "Test_Lift_Nozzle_1");
      Register_Routine (Test => T,
                        Routine => Test_Lift_Nozzle_2'Access,
                        Name => "Test_Lift_Nozzle_2");
      Register_Routine (Test => T,
                        Routine => Test_Lift_Nozzle_3'Access,
                        Name => "Test_Lift_Nozzle_3");
      Register_Routine (Test => T,
                        Routine => Test_Replace_Nozzle_1'Access,
                        Name => "Test_Replace_Nozzle_1");
      Register_Routine (Test => T,
                        Routine => Test_Replace_Nozzle_2'Access,
                        Name => "Test_Replace_Nozzle_2");
      Register_Routine (Test => T,
                        Routine => Test_Replace_Nozzle_3'Access,
                        Name => "Test_Replace_Nozzle_3");
      Register_Routine (Test => T,
                        Routine => Test_Start_Pumping_1'Access,
                        Name => "Test_Start_Pumping_1");
      Register_Routine (Test => T,
                        Routine => Test_Start_Pumping_2'Access,
                        Name => "Test_Start_Pumping_2");
      Register_Routine (Test => T,
                        Routine => Test_Start_Pumping_3'Access,
                        Name => "Test_Start_Pumping_3");
      Register_Routine (Test => T,
                        Routine => Test_Stop_Pumping_1'Access,
                        Name => "Test_Stop_Pumping_1");
      Register_Routine (Test => T,
                        Routine => Test_Stop_Pumping_2'Access,
                        Name => "Test_Stop_Pumping_2");
      Register_Routine (Test => T,
                        Routine => Test_Stop_Pumping_3'Access,
                        Name => "Test_Stop_Pumping_3");
      Register_Routine (Test => T,
                        Routine => Test_Replace_Nozzle_4'Access,
                        Name => "Test_Replace_Nozzle_4");
      Register_Routine (Test => T,
                        Routine => Test_Pay_1'Access,
                        Name => "Test_Pay_1");
      Register_Routine (Test => T,
                        Routine => Test_Pay_2'Access,
                        Name => "Test_Pay_2");
       Register_Routine (Test => T,
                        Routine => Test_Check_State'Access,
                        Name => "Test_Check_State");
   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;






end Pump_Unit_Tests;
