WITH Ada.Text_Io; USE Ada.Text_Io;
WITH Ada.Integer_Text_IO; USE Ada.Integer_Text_IO;
WITH Ada.Float_Text_IO; USE Ada.Float_Text_IO;

PROCEDURE Hello IS

   -- demande l'age
   PROCEDURE Ask_Age IS
      Age : Natural := 18;
   BEGIN
      --put("Quel est votre age ? ");
      --get(age); skip_line;
      Put("vous avez ");
      Put(Age, Width => 0);
      Put_Line(" ans");
   END Ask_Age;

   -- affiche x*2, x*3 et x*5
   PROCEDURE Multiple(Nombre : IN Integer) IS
      Double : Integer := Nombre * 2;
      Triple : Integer := Nombre * 3;
   BEGIN
      Put("double: "); Put(Double, Width => 0); New_Line;
      Put("triple: "); Put(Triple, Width => 0); New_Line;
      Put("quintuple: "); Put(Double + Triple, Width => 0); New_Line;
   END Multiple;

   -- affiche x/y et x MOD y
   PROCEDURE Euclide(Nominator, Denominator: IN Integer) IS
   BEGIN
      Put("div: "); Put(Nominator/Denominator, Width => 0); New_Line;
      Put("mod: "); Put(Nominator MOD Denominator, Width => 0); New_Line;
   EXCEPTION
      WHEN Constraint_Error =>
         Put("div: "); Put(Nominator/1, Width => 0); New_Line;
         Put("mod: "); Put(Nominator MOD 1, Width => 0); New_Line;
   END Euclide;

   -- affiche l'aire et le perimetre d'un cercle de rayon R
   PROCEDURE Infos_Cercle(R: IN Natural) IS
      PI: CONSTANT Float := 3.1415926535;
   BEGIN
      Put("peremiter: "); Put(2.0 * PI * Float(R), Fore => 0, Aft => 2); New_Line;
      Put("area: "); Put(PI * Float(R**2), Fore => 0, Aft => 2); New_Line;
   END Infos_Cercle;

   -- bidouille des lettres
   PROCEDURE Lettres IS
      C1: CONSTANT Character := 'a';
      C2: CONSTANT Character := 'f';
      C3: CONSTANT Character := Character'Val((Character'Pos(C1) + Character'Pos(C2)) / 2);
   BEGIN
      Put(C1); Put(" en maj est "); Put(Character'Val(Character'Pos(C1)-32)); New_Line;
      Put(C2); Put(" en maj est "); Put(Character'Val(Character'Pos(C2)-32)); New_Line;
      Put("Entre les deux on a: "); Put(C3); New_Line;
   END Lettres;

BEGIN
   Put_Line("Salut tout le monde !") ; --on affiche un message
   Ask_Age;
   Multiple(5);
   Euclide(13, 0);
   Infos_Cercle(3);
   Lettres;
END Hello ;
