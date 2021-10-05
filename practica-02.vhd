Práctica 2
-- Descripción tipo flujo de datos de un Flip Flop tipo D y su Testbench
-- 1 – Edite, compile y simule la entidad Test_DFF (testbench) para verificar el funcionamiento del Flip Flop tipo D.
-- 2 – Modifique el testbench para determinar: 
------- a) minimo periodo de reloj (o máxima frecuencia de trabajo), 
------- b) minimo ancho de pulso de preset y de clear,
------- c) minimo tiempo de 'setup' y de 'hold' de datos.
 
entity DFF is
port (Preset: in Bit; Clear: in Bit; Clock: in Bit; Data: in Bit; Q:out Bit;
QBar: out Bit);
end DFF;

architecture flujodedatos of DFF is 
	signal A, B, C, D: Bit;
	signal Qint, QbarInt: Bit;
begin
	A <= not (Preset and D and B) after 1 ns;
	B <= not (A and Clear and Clock) after 1 ns;
 	C <= not (B and Clock and D) after 1 ns;
	D <= not (C and Clear and Data) after 1 ns;
	Qint <= not (Preset and B and QbarInt) after 1 ns;
	QbarInt <= not (Qint and Clear and C) after 1ns;
	Q <= Qint;
	QBar <= QbarInt;
end;

------ testbench ------ 

entity Test_DFF is end;

architecture Driver of Test_DFF is 
	component DFF
	   port (Preset, Clear, Clock, Data: in Bit; Q, Qbar: out Bit);
	end component;
	signal Preset, Clear: Bit := '1',
	signal Clock, Data, Q, QBar: Bit,
begin
  UUT: DFF port map (Preset, Clear, Clock, Data, Q, Qbar);
  Stimulus: Process
	Begin
	-- chequeo de preset y clear
  Preset <= '0'; wait for 5 ns; Preset <= '1'; wait for 5 ns;
  Clear <= '0'; wait for 5 ns; Clear <= '1'; wait for 5 ns;
    -- interaccion de preset y clear
  Preset <= '0'; Clear <= '0'; wait for 5 ns;
  Preset <= '1'; Clear <= '1'; wait for 5 ns;
-- limpiar
  Clear <= '0', '1' after 5 ns; wait for 10 ns;
-- chequeo de datos y clock
  Data <= '1'; Clock <= '0' after 1 ns, '1' after 5 ns; wait for 10 ns;
  Data <= '0'; Clock <= '0' after 1 ns, '1' after 5 ns; wait for 10 ns;
-- limpiar
  Clear <= '0', '1' after 5 ns; wait for 10 ns;
--interaccion de preset y clock
  Data <= '0'; Preset <= '0', '1' after 10 ns;
  Clock <= '0', '1' after 5 ns; wait for 10 ns;
  Wait;
	end process;
end;