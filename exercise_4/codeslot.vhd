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
-- dit bestand combineert alle afzonderlijke onderdelen

library ieee;
use ieee.std_logic_1164.all;
use work.opdr6.all;

entity codeslot is
port(	DIP : in std_logic_vector(3 downto 0);
		druk : in std_logic;
		clk : in std_logic;
		disp_seg : out std_logic_vector(7 downto 0);
		disp_sel : out std_logic_vector(3 downto 0);
		LED : out std_logic);
end codeslot;

architecture structure of codeslot is

signal dender_FSM : std_logic;
signal FSM_conv : std_logic_vector(3 downto 0);
signal conv_disp : std_logic_vector(31 downto 0);

begin
	
	-- maak de druk knop vast aan de anti dender schakeling
	input : opdr6_dender port map(
		druk => druk,
		clk => clk,
		uit => dender_FSM
		);
	
	-- maak de druk knop en DIP switches vast aan de FSM
	FSM : opdr6_FSM port map(
		druk => dender_FSM,
		DIP => DIP,
		uit => FSM_conv,
		LED => LED
		);
	
	-- maak de FSM en DIP switches vast aan de display convertor
	conv : opdr6_conv port map(
		FSM => FSM_conv,
		DIP => DIP,
		uit => conv_disp
		);
		
	-- maak de display convertor vast aan de display driver	
	disp : opdr6_disp port map(
		ingang => conv_disp,
		AN => disp_sel,
		SEG => disp_seg,
		clk => clk
		);

end structure;