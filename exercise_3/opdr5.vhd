-- maurice daverveldt
-- 1531491
-- ev3a
-- dit bestand bevat alle losse componenten

library ieee;
use ieee.std_logic_1164.all;

entity opdr5_mux is
port(	x,y : in	std_logic_vector(7 downto 0);
		s :	in std_logic;
		f :	out std_logic_vector(7 downto 0));
end opdr5_mux;

architecture RTL of opdr5_mux is
begin
	process(x,y,s)
	begin
		if s = '0' then f <= x;					--als s = 0 zet dan x op uitgang
		else f <= y;								--als s = 1 zet dan y op uitgang
		end if;
	end process;
end RTL;

library ieee;
use ieee.std_logic_1164.all;

entity opdr5_inv is
port(	x :	in std_logic_vector(7 downto 0);
		s :	in std_logic;
		f :	out std_logic_vector(7 downto 0));
end opdr5_inv;

architecture RTL of opdr5_inv is
begin
	process(x,s)
	begin
		if s = '1' then f <= not x;		--als s =1 inverteer x
		else f <= x;							--als s =0 inverteer x niet
		end if;
	end process;
end RTL;

library ieee;
use ieee.std_logic_1164.all;

entity opdr5_add is
port(	a,b,cin :	in std_logic;
		f :		out std_logic;
		cout :	out std_logic);
end opdr5_add;

architecture RTL of opdr5_add is
begin
	f <= (a xor b) xor cin;				--als a exor b exor cin maak dan f hoog
	cout <= (a and b) or (cin and b) or (cin and a);	-- maak de carry hoog als dat nodig is
end RTL;

library ieee;
use ieee.std_logic_1164.all;

entity opdr5_add8 is
port( a,b :	in std_logic_vector(7 downto 0);
		f :	out std_logic_vector(7 downto 0);
		cin :	in std_logic;
		cout :out std_logic);
end opdr5_add8;

architecture struct of opdr5_add8 is	-- in deze structure gaan we een 8 bits full adder maken 
													-- uit de 1 bits full adder die we eerder hebben gemaakt

component opdr5_add is
port(	a,b,cin :	in std_logic;
		f :		out std_logic;
		cout :	out std_logic);
end component;

signal im : std_logic_vector(6 downto 0);
begin
	--koppel c0 aan de juiste poorten
	c0 :	opdr5_add port map(a => a(0), b => b(0), cin => cin, f => f(0), cout => im(0));
	--koppel c1 tot c6 aan de juiste poorten en aan elkaar
	c 	: 	for i in 1 to 6 generate
				c1to6 : opdr5_add port map(a => a(i), b=> b(i), f => f(i), cin => im(i - 1), cout => im(i) );
		  	end generate;
	--koppel c7 aan de juiste poorten en de cout aan de uitgang
	c7 :	opdr5_add port map(a => a(7), b => b(7), cin => im(6), f => f(7), cout => cout);
end struct;

library ieee;
use ieee.std_logic_1164.all;

package opdr5 is
component opdr5_inv is
port(	x :	in std_logic_vector(7 downto 0);
		s :	in std_logic;
		f :	out std_logic_vector(7 downto 0));
end component;

component opdr5_mux is
port(	x,y : in	std_logic_vector(7 downto 0);
		s :	in std_logic;
		f :	out std_logic_vector(7 downto 0));
end component;

component opdr5_add8 is
port( a,b :	in std_logic_vector(7 downto 0);
		f :	out std_logic_vector(7 downto 0);
		cin :	in std_logic;
		cout :out std_logic);
end component;
end package;



