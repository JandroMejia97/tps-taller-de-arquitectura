-- Práctica 4
-- Parte A
-- Descripción funcional de un Sumador completo y su Testbench

entity fulladder is
 port (X,Y,Cin: in Bit; Cout, Sum: out Bit);
end fulladder;

architecture ecuacion of fulladder is
begin
 Sum <= X xor Y xor Cin;
 Cout <= (X and Y) or (X and Cin) or (Y and Cin);
end;

---- testbench ------ Simule y haga las modificaciones que correspondan en el testbench, para 
---  que la sentencia assert despliegue un reporte de error.

---------------Testbench---------------
entity test_sumador is
end;

architecture driver of test_sumador is
component fulladder
 port (X, Y, Cin: in Bit; Cout, Sum: out Bit);
end component;
signal X, Y, Cin, Cout, Sum: Bit;
begin
 uut: fulladder port map (X, Y, Cin, Cout, Sum);
 estimulo: process
	type Entry is record
	 X, Y, Cin: Bit;
	 Cout, Sum: Bit;
	end record;
	type Table is array (0 to 7) of Entry;
	constant Tabla: Table:=
	(('0', '0', '0', '0', '0'),
	 ('0', '0', '1', '0', '1'),
	 ('0', '1', '0', '0', '1'),
	 ('0', '1', '1', '1', '0'),
	 ('1', '0', '0', '0', '1'),
	 ('1', '0', '1', '1', '0'),
	 ('1', '1', '0', '1', '0'),
	 ('1', '1', '1', '1', '1')
	);
 begin
	for i in Tabla'range loop
	 X <= Tabla(i).X;
	 Y <= Tabla(i).Y;
	 Cin <= Tabla(i).Cin;
	 wait for 1 ns;
	 assert
	  Cout = Tabla(i).Cout and
	  Sum = Tabla(i).Sum;
	end loop;
	wait;
 end process;
end;





-- Parte B

-- Analizar y describir los efectos que producen los atributos o calificadores en las señales y las asignaciones.
-- Describa sentencia 'block'

entity Test_16 is
end Test_16;

architecture Behave_1 of Test_16 is
  signal  Source : NATURAL := 0;
  signal  Destination_1 : NATURAL := 0;
  signal  Destination_2 : NATURAL := 0;
  signal  Destination_3 : NATURAL := 0;
  signal  Destination_4 : NATURAL := 0;
  signal  Clock : BIT := '0';
begin

  Blck_Test_1:
  block (Clock = '1' and Clock'EVENT)
  begin
      Destination_1 <= guarded Source;
      Destination_2 <= Source;
  end block Blck_Test_1;

  Blck_Test_2:
  block (Clock = '1' and (not Clock'STABLE))
  begin
      Destination_3 <= guarded Source;
      Destination_4 <= Source;
  end block Blck_Test_2;

  Tick_Tock:
  process
  begin
    wait for 10 ns;
    Clock <= not Clock;
  end process Tick_Tock; 

  Source_Wave: Source <= 1 after 8 ns,
                         2 after 15 ns,
                         3 after 16 ns,
                         4 after 17 ns,
                         5 after 18 ns,
                         6 after 19 ns; 







	
end Behave_1;