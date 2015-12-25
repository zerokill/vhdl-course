-- maurice daverveldt
-- 1531491
-- ev3a
-- dit bestand koppelt alle losse componenten aan elkaar om een ALU te vormen

library ieee;
use ieee.std_logic_1164.all;
use work.opdr5.all;

entity ALU is		-- maak de juiste in en uitgangen voor de ALU
port(	getal_a, getal_b : in std_logic_vector(7 downto 0);
		s :			in std_logic_vector(1 downto 0);
		resultaat :	out std_logic_vector(8 downto 0);
		cout :		out std_logic);
end ALU;

architecture structure of ALU is
signal mux_inv, inv_add : std_logic_vector(7 downto 0);	--intern signaal om alle componenten te verbinden
signal y : std_logic;												
begin	
	-- koppel de mux aan de juiste ingang en zet 1 op de andere ingang
	mux : opdr5_mux port map (x => getal_b, y => "00000001", s => s(0), f => mux_inv);
	-- koppel invertor aan de mux en aan de adder
	min : opdr5_inv port map (x => mux_inv, s => s(1), f => inv_add);
	-- koppel de invertor aan de adder
	add : opdr5_add8 port map (a => getal_a, b => inv_add, cin => s(1), cout => resultaat(8), f => resultaat(7 downto 0));
end structure;