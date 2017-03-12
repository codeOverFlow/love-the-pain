WITH Ada.Text_Io; USE Ada.Text_Io;
WITH Ada.Integer_Text_IO; USE Ada.Integer_Text_IO;
WITH Ada.Float_Text_IO; USE Ada.Float_Text_IO;
WITH Ada.Numerics.Float_Random;
WITH Ada.Numerics.Discrete_Random;
WITH Ada.Strings.Unbounded;

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


   FUNCTION Moyenne(Nombre : IN Natural) RETURN Float IS
      TYPE T_Tableau IS ARRAY (Integer RANGE<>) OF Float;
      USE Ada.Numerics.Float_Random;

      Tableau : T_Tableau(0..(Nombre - 1));
      Somme : Float := 0.0;
      Hasard : Generator;
   BEGIN
      Reset(Hasard);
      FOR I IN Tableau'Range LOOP
         Tableau(I) := Random(Hasard) * 20.0; -- met la note sur 20
         Put(Tableau(I), Fore => 2, Aft => 2, Exp => 0); NEW_Line;
      END LOOP;

      FOR Note OF Tableau LOOP
         Somme := Somme + Note;
      END LOOP;
      RETURN Somme / Float(Tableau'Length);
   END Moyenne;

   -- Construit le triangle de pascal
   PROCEDURE Pascal(Profondeur: IN Positive) IS
      -- Tableau non contraint donc obligation de matrice carree
      TYPE T_Pascal_Triangle IS ARRAY(Positive RANGE<>, Positive RANGE<>) OF Natural;
      Triangle: T_Pascal_Triangle(1..Profondeur, 1..Profondeur) := (OTHERS => (OTHERS => 0));
   BEGIN
      -- Calcul le triangle
      FOR I IN Triangle'Range(1) LOOP
         Triangle(I, 1) := 1;
         FOR J IN 2..I LOOP
            Triangle(I, J) := Triangle(I-1, J-1) + Triangle(I-1, J);
         END LOOP;
      END LOOP;

      -- Affiche le triangle
      FOR I IN Triangle'Range(1) LOOP
         FOR J IN 1..I LOOP
            Put(Triangle(I,J), Width => 2);
         END LOOP;
         NEW_Line;
      END LOOP;
   END Pascal;

   TYPE T_Random_Array IS ARRAY(Positive RANGE<>) OF Integer;
   SUBTYPE T_Intervalle IS Integer RANGE 1..100;

   PROCEDURE Trie (Tableau : IN OUT T_Random_Array) IS
      PROCEDURE Swap(X: IN OUT T_Intervalle; Y: IN OUT T_Intervalle) IS
         Tmp: T_Intervalle := Y;
      BEGIN
         Y := X;
         X := Tmp;
      END Swap;

   BEGIN
      FOR I IN Tableau'Range LOOP
         FOR J IN I..Tableau'last LOOP
            IF Tableau(J) < Tableau(I) THEN
               Swap(Tableau(I), Tableau(J));
            END IF;
         END LOOP;
      END LOOP;
   END Trie;

   PROCEDURE Trie_Le_Random(Taille: IN Positive) IS
      PACKAGE P_Aleatoire IS NEW Ada.Numerics.Discrete_Random(T_Intervalle);
      USE P_Aleatoire;

      Hasard: Generator;
      Tableau: T_Random_Array(1..Taille) := (OTHERS => 0);
   BEGIN
      Reset(Hasard);
      FOR E OF Tableau LOOP
         E := Random(Hasard);
      END LOOP;

      Trie(Tableau);

      FOR E OF Tableau LOOP
         Put(E, Width => 4);
      END LOOP;
      NEW_Line;
   END Trie_Le_Random;

   PROCEDURE Lire_Poeme IS
      PACKAGE P_UString RENAMES Ada.Strings.Unbounded;
      File: File_Type;
   BEGIN
      Open(File, IN_File, "poeme.txt");
      WHILE NOT End_Of_File(File) LOOP
         Put_Line(Get_Line(File));
      END LOOP;
      Close(File);
   END Lire_Poeme;


BEGIN
   Put_Line("Salut tout le monde !");--on affiche un message
   New_Line; Put_Line("--------- ASK AGE ---------");
   Ask_Age;
   New_Line; Put_Line("--------- MULTIPLE 5 ---------");
   Multiple(5);
   New_Line; Put_Line("--------- EUCLIDE 13 0 ---------");
   Euclide(13, 0);
   New_Line; Put_Line("--------- INFOS CERCLE 3 ---------");
   Infos_Cercle(3);
   New_Line; Put_Line("--------- LETTRES ---------");
   Lettres;
   New_Line; Put_Line("--------- MOYENNE 5 ---------");
   Put("Moyenne: "); Put(Moyenne(5), Fore => 2, Aft => 2, Exp => 0); NEW_Line;
   New_Line; Put_Line("--------- PASCAL 5 ---------");
   Pascal(5);
   New_Line; Put_Line("--------- TRIE LE RANDOM 10 ---------");
   Trie_Le_Random(10);
   New_Line; Put_Line("--------- LIRE POEME ---------");
   Lire_Poeme;
END Hello ;
