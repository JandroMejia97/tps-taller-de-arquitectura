-- Práctica 3
-- Descripción estructural de un Latch de 8 bits y su Testbench

entity Latch8 is
   port (D: in Bit_Vector(7 downto 0); Clk: in Bit; Pre: in Bit; Clr: in Bit; Q: out Bit_Vector(7 downto 0));
end Latch8;

architecture Estructura of Latch8 is
   component DFF
       port (Preset: in Bit; Clear: in Bit; Clock: in Bit; Data: in Bit; Q: out Bit; QBar: out Bit);
   end component;
   signal QBar: Bit_Vector(7 downto 0);
begin
F7: DFF port map (Pre, Clr, Clk, D(7), Q(7), QBar(7));
F6: DFF port map (Pre, Clr, Clk, D(6), Q(6), QBar(6));
F5: DFF port map (Pre, Clr, Clk, D(5), Q(5), QBar(5));
F4: DFF port map (Pre, Clr, Clk, D(4), Q(4), QBar(4));
F3: DFF port map (Pre, Clr, Clk, D(3), Q(3), QBar(3));
F2: DFF port map (Pre, Clr, Clk, D(2), Q(2), QBar(2));
F1: DFF port map (Pre, Clr, Clk, D(1), Q(1), QBar(1));
F0: DFF port map (Pre, Clr, Clk, D(0), Q(0), QBar(0));
end;

---- testbench ------ Simule y haga las modificaciones que correspondan en el testbench de Latch8, para 
---  establecer en qué condiciones de la señal Clk, la sentencia assert despliega su reporte de alerta.
 
-------------------- Testbendh -------------------------------

entity Test_Latch8 is end;

architecture Driver of Test_Latch8 is
     component Latch8
        port (D: in Bit_Vector(7 downto 0); Clk: in Bit; Pre: in Bit; Clr: in Bit; Q: out Bit_Vector(7 downto 0));
     end component;
     signal D, Q: Bit_Vector(7 downto 0);
     signal Clk, Pre, Clr: Bit := '1';
begin
      UUT: Latch8 port map (D, Clk, Pre, Clr, Q);
     Stimulus: process
variable Temp: Bit_Vector(7 downto 0);
begin
    -- Set the latch
    Pre <= '0', '1' after 5 ns;
    wait for 10 ns;
    -- Clear the latch
    Clr <= '0', '1' after 5 ns;
    wait for 10 ns;
    -- Load the latch
    Temp := "00010011";
    for i in 1 to 8 loop
        D <= Temp;
        Clk <= '0' after 1 ns, '1' after 5 ns;
        wait for 10 ns;
        assert Q = Temp report "Load Failed";
        Temp := Temp(0) & Temp(7 downto 1);
    end loop;
        wait; -- to terminate simulation
    end process;
end;