-- Codeslot
--
-- gemaakt door
-- 
--     __  ___                 _         
--    /  |/  /___ ___  _______(_)_______ 
--   / /|_/ / __ `/ / / / ___/ / ___/ _ \
--  / /  / / /_/ / /_/ / /  / / /__/  __/
-- /_/  /_/\__,_/\__,_/_/  /_/\___/\___/ 
                                      
--     ____                                   __    ____ 
--    / __ \____ __   _____  ______   _____  / /___/ / /_
--   / / / / __ `/ | / / _ \/ ___/ | / / _ \/ / __  / __/
--  / /_/ / /_/ /| |/ /  __/ /   | |/ /  __/ / /_/ / /_  
-- /_____/\__,_/ |___/\___/_/    |___/\___/_/\__,_/\__/ 
--
-- Maurice Daverveldt
-- Ev3a
-- 1531491
--
-- gebruikte wachtwoord binair:
-- 0001010010010001
-- Dit bestand bevat de testbench voor alle afzonderlijke onderdelen

library ieee;
use ieee.std_logic_1164.all;

entity opdr6_FSM_tb is
end opdr6_FSM_tb;

architecture DUT of opdr6_FSM_tb is

component opdr6_FSM is
port(	druk : in std_logic;
		DIP : in std_logic_vector(3 downto 0);
		uit : out std_logic_vector(3 downto 0);
		LED : out std_logic);
end component;

signal druk : std_logic;
signal DIP : std_logic_vector(3 downto 0);
signal uit : std_logic_vector(3 downto 0);
signal LED : std_logic;

begin
	DUT: entity work.opdr6_FSM port map (
		druk => druk,
		DIP => DIP,
		uit => uit,
		LED => LED
		);
	
	klok : process
	begin
		for i in 0 to 8 loop
			druk <= '0';
			wait for 5 ns;
			druk <= '1';
			wait for 5 ns;
		end loop;
		wait;
	end process;
	
	tb : process
	begin
		DIP <= (others => '0');
		wait for 7 ns;
		
		wait for 5 ns;
		DIP <= "0001";
		
		wait for 10 ns;
		DIP <= "0100";
		
		wait for 10 ns;
		DIP <= "1001";
		
		wait for 10 ns;
		DIP <= "0001";
		
		
		
		
		wait;
		
	end process;
end DUT;

library ieee;
use ieee.std_logic_1164.all;

entity opdr6_Disp_tb is
end opdr6_Disp_tb;


architecture DUT of opdr6_Disp_tb is

component opdr6_Disp is
port( ingang : in std_logic_vector(31 downto 0);
		AN : out std_logic_vector(3 downto 0);
		SEG : out std_logic_vector(7 downto 0);
		clk : in std_logic);
end component;

signal ingang : std_logic_vector(31 downto 0);
signal AN : std_logic_vector(3 downto 0);
signal SEG : std_logic_vector(7 downto 0);
signal clk : std_logic;

begin
	DUT: entity work.opdr6_Disp port map (
		ingang => ingang,
		AN => AN,
		SEG => SEG,
		clk => clk
		);
	
	ingang <= "00000001000000100000001100000100";
	tb : process
	begin
		for i in 2048 downto 0 loop
			clk <= '0';
			wait for 5 ns;
			clk <= '1';
			wait for 5 ns;
		end loop;
		
		wait;
	end process;

end DUT;

library ieee;
use ieee.std_logic_1164.all;

entity opdr6_dender_tb is
end opdr6_dender_tb;

architecture DUT of opdr6_dender_tb is
component opdr6_dender is
port(	druk : in std_logic;
		clk : in std_logic;
		uit : out std_logic);
end component;

signal druk : std_logic;
signal clk : std_logic;
signal uit : std_logic;

begin
	DUT : entity work.opdr6_dender port map(
		druk => druk,
		clk => clk,
		uit => uit
		);
	
	klok : process
	begin
		for i in 64 downto 0 loop
			clk <= '0';
			wait for 5 ns;
			clk <= '1';
			wait for 5 ns;
		end loop;
		
		wait;
	end process;
	
	tb : process
	begin
		--druk <= '0';
		--wait for 2 ns;
		--druk <= '1';
		--wait for 5 ns;
		--druk <= '0';
		--wait for 5 ns;
		druk <= '1';
		wait for 500 ns;
		
		wait;
	end process;
	
end DUT;

library ieee;
use ieee.std_logic_1164.all;

entity opdr6_conv_tb is
end opdr6_conv_tb;

architecture DUT of opdr6_conv_tb is
component opdr6_conv is
port( FSM : in std_logic_vector(3 downto 0);
		DIP : in std_logic_vector(3 downto 0);
		uit : out std_logic_vector(31 downto 0));
end component;

signal FSM : std_logic_vector(3 downto 0);
signal DIP : std_logic_vector(3 downto 0);
signal uit : std_logic_vector(31 downto 0);

begin

	DUT : entity work.opdr6_conv port map (
		FSM => FSM,
		DIP => DIP,
		uit => uit
		);
	
	FSM <= "0010";
	DIP <= "0100";
	
	tb : process
	begin
		wait for 5 ns;
		wait;
	end process;
	
end DUT;
