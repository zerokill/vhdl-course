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
-- dit bestand bevat de testbench die het hele codeslot test

library ieee;
use ieee.std_logic_1164.all;

entity codeslot_tb is
end codeslot_tb;

architecture DUT of codeslot_tb is
component codeslot is
port(	DIP : in std_logic_vector(3 downto 0);
		druk : in std_logic;
		clk : in std_logic;
		disp_seg : out std_logic_vector(7 downto 0);
		disp_sel : out std_logic_vector(3 downto 0);
		LED : out std_logic);
end component;

signal DIP : std_logic_vector(3 downto 0);
signal druk : std_logic;
signal clk : std_logic;
signal disp_seg : std_logic_vector(7 downto 0);
signal disp_sel : std_logic_vector(3 downto 0);
signal LED : std_logic;

signal ok : std_logic;

constant tijd : TIME := 20 ns;

begin

	DUT : entity work.codeslot port map(
		DIP => DIP,
		druk => druk,
		clk => clk,
		disp_seg => disp_seg,
		disp_sel => disp_sel,
		led => led
		);
	
	clock : process
	begin
		for i in 0 to 300 loop
			clk <= '0'; wait for 1 ns;
			clk <= '1'; wait for 1 ns;
		end loop;
		
		wait;
	end process;
	
	tb : process
	begin
		ok <= '1';
	
		DIP <= "0000";			-- code slot staat op start stand
		druk <= '0';
		wait for 2 ns;
		
		druk <= '1';			-- ga naar stand 1
		wait for tijd;
		druk <= '0';
		wait for tijd;
		

		DIP <= "0001";			-- zet eerste waarde op DIP
		wait for tijd;
		druk <= '1';			-- maak druk hoog
		wait for tijd;
		druk <= '0';			-- maak druk laag
		wait for tijd;
		
		DIP <= "0100";			-- zet tweede waarde op DIP
		wait for tijd;
		druk <= '1';			-- druk op knop
		wait for tijd;
		druk <= '0';
		wait for tijd;
		
		DIP <= "1001";			-- zet derde waarde op DIP
		wait for tijd;
		druk <= '1';
		wait for tijd;
		druk <= '0';
		wait for tijd;
		
		DIP <= "0001";			-- zet vierde waarde op DIP
		wait for tijd;
		druk <= '1';			-- ga naar laatste stand
		wait for tijd;
		druk <= '0';
		
		if led /= '1' then 
			ok <= '0';
		end if;
		
		
		wait for tijd;
		druk <= '1';			-- ga naar eerste stand
		wait for tijd;
		druk <= '0';
		wait for tijd;
		
		
		
		DIP <= "0001";			-- zet eerste waarde op DIP
		wait for tijd;
		druk <= '1';			-- maak druk hoog
		wait for tijd;
		druk <= '0';
		wait for tijd;
		
		DIP <= "0100";			-- zet tweede waarde op DIP
		wait for tijd;
		druk <= '1';
		wait for tijd;
		druk <= '0';
		wait for tijd;
		
		DIP <= "1001";			-- zet derde waarde op DIP
		wait for tijd;
		druk <= '1';
		wait for tijd;
		druk <= '0';
		wait for tijd;
		
		DIP <= "0101";			-- zet vierde (foute) waarde op DIP
		wait for tijd;
		druk <= '1';			
		wait for tijd;
		druk <= '0';
		
		wait for tijd;
		druk <= '1';
		wait for tijd;
		druk <= '0';
		wait for tijd;
		
		if led /= '0' then	-- check of led laag is
			ok <= '0';
		end if;

		
		
		
		
		
		wait;
	end process;
		
	
end DUT;