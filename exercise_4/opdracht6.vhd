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
-- dit bestand bevat de beschrijvingen voor alle onderdelen

-- dit onderdeel zorgt voor de werking van het codeslot
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity opdr6_FSM is
port(	druk : in std_logic;
		DIP : in std_logic_vector(3 downto 0);
		uit : out std_logic_vector(3 downto 0);
		LED : out std_logic);
end entity;

architecture RTL of opdr6_FSM is

type stand is(st0, st1, st2, st3, st4, st5);
signal VT, HT : stand;
signal ok : unsigned(15 downto 0) := (others => '0') ;

begin
	combi : process(HT)
	begin
		case HT is
			-- selecteer volgende standen
			when st0 => VT <= st1;
			when st1 => VT <= st2;
			when st2 => VT <= st3;
			when st3 => VT <= st4;
			when st4 => VT <= st5;
			when st5 => VT <= st0;
		end case;
	end process;
	
	seq : process(druk)
	begin
		if rising_edge(druk) then
			-- selecteer volgende stand
			HT <= VT;
			-- zet bij de juiste stand de juiste waarde in ok register
			case HT is
				when st0 => ok <= (others => '0');
				when st1 => ok(15 downto 12) <= unsigned(DIP);
				when st2 => ok(11 downto 8) <= unsigned(DIP);
				when st3 => ok(7 downto 4) <= unsigned(DIP);
				when st4 => ok(3 downto 0) <= unsigned(DIP);
				when st5 => ok <= ok;
			end case;
		end if;
	end process;
	
	output : process(HT, ok)
	begin
		-- zet de uitgangen bij de juiste stand
		case HT is
			when st0 => 
				uit <= "0000";
				led <= '0';
			when st1 => 
				uit <= "0001";
				led <= '0';
			when st2 => 
				uit <= "0010";
				led <= '0';
			when st3 => 
				uit <= "0011";
				led <= '0';
			when st4 => 
				uit <= "0100";
				led <= '0';
			-- check of ok register overeenkomt met studenten nummer
			when st5 => 
				if (ok = "0001010010010001") then 
					uit <= "1001";
					led <= '1';
				else
					uit <= "1000";
					led <= '0';
				end if;
		end case;
	end process;
	
end RTL;

-- dit onderdeel stuurt het display aan
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity opdr6_Disp is
port( ingang : in std_logic_vector(31 downto 0);
		AN : out std_logic_vector(3 downto 0);
		SEG : out std_logic_vector(7 downto 0);
		clk : in std_logic);
end opdr6_Disp;

architecture RTL of opdr6_Disp is
signal clk_3k : std_logic;
signal selectie : unsigned(1 downto 0) := "00";

constant clk_deler	: integer := 2;

begin

	-- dit onderdeel is de klokdeler
	klok_deler : process(clk)
	variable teller : integer range 0 to clk_deler := 0;
	begin
		if rising_edge(clk) then
			-- verhoog teller
			teller := teller + 1;
			-- als teller te groot is maak hem dan 0
			if teller = clk_deler then teller := 0;
			end if;
			-- als teller voor de helft is maak dan clk_3k laag
			-- maak teller anders hoog
			if teller < clk_deler/2 then 
				clk_3k <= '0';
			else
				clk_3k <= '1';
			end if;
		end if;
	end process;
	
	-- dit onderdeel selecteerd het display
	selector : process(clk_3k)
	begin
		if rising_edge(clk_3k) then
			-- verhoog selectie met 1
			-- omdat selectie 2 bit getal is kan hij niet groter worden dan 4
			selectie <= selectie + 1;
		end if;
	end process;
	
	-- dit onderdeel combineert het juiste display met de juiste segmenten
	decoder : process(selectie, ingang)
	begin
		case selectie is
			when "00" => 
				AN <= "0111";
				seg <= ingang(31 downto 24);
			when "01" => 
				AN <= "1011";
				seg <= ingang(23 downto 16);
			when "10" => 
				AN <= "1101";
				seg <= ingang(15 downto 8);
			when "11" => 
				AN <= "1110";
				seg <= ingang(7 downto 0);
			when others => 
				AN <= "1111";
				seg <= (others => '0');
		end case;
	end process;
end RTL;

-- dit onderdeel zorgt voor een antidender schakeling voor de drukknop
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity opdr6_dender is
port(	druk : in std_logic;
		clk : in std_logic;
		uit : out std_logic);
end opdr6_dender;

architecture RTL of opdr6_dender is

signal clk_200 : std_logic;
signal shift : unsigned(3 downto 0) := "0000";
constant clk_deler	: integer := 2;

begin
	
	-- dit onderdeel verlaagt de 50mhz klok
	-- werking is hetzelfde als vorige frequentie deler
	klok_deler : process(clk)
	variable teller : integer range 0 to clk_deler := 0;
	begin
		if rising_edge(clk) then
			teller := teller + 1;
			if teller = clk_deler then teller := 0;
			end if;
			if teller < clk_deler/2 then 
				clk_200 <= '0';
			else
				clk_200 <= '1';
			end if;
		end if;
	end process;

	-- dit onderdeel vult een 4 bit schuifregister
	process(clk_200)
	begin
		if rising_edge(clk_200) then
			shift <= druk & shift(3 downto 1);
		end if;
	end process;
	
	-- zorg ervoor dat als het schuifregister gevuld is met enen de uitgang hoog wordt
	uit <= 	'1' when shift = "1111" else
				'0';
end RTL;

-- dit onderdeel converteerd de waarde van de DIP switch en van de FSM
-- naar waardes die geschikt zijn voor 7 segment display
library ieee;
use ieee.std_logic_1164.all;

entity opdr6_conv is
port( FSM : in std_logic_vector(3 downto 0);
		DIP : in std_logic_vector(3 downto 0);
		uit : out std_logic_vector(31 downto 0));
end opdr6_conv;

architecture RTL of opdr6_conv is

signal seg1 : std_logic_vector(7 downto 0);
signal seg2 : std_logic_vector(7 downto 0);
signal seg3 : std_logic_vector(7 downto 0);
signal seg4 : std_logic_vector(7 downto 0);

begin
	-- dit onderdeel zet de waardes van het FSM om in waardes voor het display
	-- segment 1
	process(FSM)
	begin
		case FSM is
			when "0000" => seg1 <= "01001001";
			when "0001" => seg1 <= "10011110";
			when "0010" => seg1 <= "00100100";
			when "0011" => seg1 <= "00001100";
			when "0100" => seg1 <= "00011000";
			when "1000" => seg1 <= "00110001";
			when "1001" => seg1 <= "00001001";
			when others => seg1 <= (others => '0');
		end case;
	end process;
	
	-- segment 2 moet altijd uit staan
	seg2 <= (others => '1');
	
	-- segment 3 moet altijd uit staan
	seg3 <= (others => '1');
	
	-- dit onderdeel zorgt ervoor dat de waardes van de DIP switch overeenkomen 
	-- met getallen op 7 segment displays
	-- segment 4
	process(DIP)
	begin
		case DIP is
			when "0000" => seg4 <= "00000010";
			when "0001" => seg4 <= "10011110";
			when "0010" => seg4 <= "00100100";
			when "0011" => seg4 <= "00001100";
			when "0100" => seg4 <= "00011000";
			when "0101" => seg4 <= "01001000";
			when "0110" => seg4 <= "01000000";
			when "0111" => seg4 <= "00011110";
			when "1000" => seg4 <= "00000000";
			when "1001" => seg4 <= "00001000";
			when others => seg4 <= "11111101";
		end case;
	end process;
	
	-- zet alles op de uitgang
	uit <= seg1 & seg2 & seg3 & seg4;

end RTL;

-- maak van alle onderdelen een package
library ieee;
use ieee.std_logic_1164.all;

package opdr6 is
component opdr6_FSM is
port(	druk : in std_logic;
		DIP : in std_logic_vector(3 downto 0);
		uit : out std_logic_vector(3 downto 0);
		LED : out std_logic);
end component;

component opdr6_Disp is
port( ingang : in std_logic_vector(31 downto 0);
		AN : out std_logic_vector(3 downto 0);
		SEG : out std_logic_vector(7 downto 0);
		clk : in std_logic);
end component;

component opdr6_dender is
port(	druk : in std_logic;
		clk : in std_logic;
		uit : out std_logic);
end component;

component opdr6_conv is
port( FSM : in std_logic_vector(3 downto 0);
		DIP : in std_logic_vector(3 downto 0);
		uit : out std_logic_vector(31 downto 0));
end component;
end package;

			
			
			
			
	