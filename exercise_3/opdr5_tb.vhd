-- maurice daverveldt
-- 1531491
-- ev3a
-- dit bestand bevat de testbench voor de ALU


library ieee;
use ieee.std_logic_1164.all;
use work.opdr5.all;

entity opdr5_tb is
end opdr5_tb;

architecture RTL of opdr5_tb is

component ALU is
port(	getal_a, getal_b : in std_logic_vector(7 downto 0);
		s :			in std_logic_vector(1 downto 0);
		resultaat :	out std_logic_vector(8 downto 0);
		cout :		out std_logic);
end component;

signal a,b : 	std_logic_vector(7 downto 0);
signal s :		std_logic_vector(1 downto 0);
signal resultaat : std_logic_vector(8 downto 0);
signal cout: 	std_logic;
signal OK :		std_logic;

begin
	DUT: entity work.ALU port map(
			getal_a => a,
			getal_b => b,
			resultaat => resultaat,
			s => s,
			cout => cout
			);
			
	tb : process
	begin
		--	01010101 01001010 10010101 00011100 01101011
		
		OK <= '1';
		s <= "00";
		
		a <= "01010101";	--zet waarde op portb
		b <= "01001010";	--zet waarde op porta
		wait for 2 ns;		--even wachten
		if resultaat /= "010011111" then OK <= '0';	--als resultaat niet klopt maak dan ok laag
		end if;
		wait for 3 ns;
		
		a <= "01001010";	--zet waarde op portb
		b <= "01001010";	--zet waarde op porta
		wait for 2 ns;		--even wachten
		if resultaat /= "010010100" then OK <= '0';	--als resultaat niet klopt maak dan ok laag
		end if;
		wait for 3 ns;
		
		a <= "10010101";	--zet waarde op portb
		b <= "01001010";	--zet waarde op porta
		wait for 2 ns;		--even wachten
		if resultaat /= "011011111" then OK <= '0';	--als resultaat niet klopt maak dan ok laag
		end if;
		wait for 3 ns;
		
		a <= "00011100";	--zet waarde op portb
		b <= "01001010";	--zet waarde op porta
		wait for 2 ns;		--even wachten
		if resultaat /= "001100110" then OK <= '0';	--als resultaat niet klopt maak dan ok laag
		end if;
		wait for 3 ns;
		
		a <= "01101011";	--zet waarde op portb
		b <= "01001010";	--zet waarde op porta
		wait for 2 ns;		--even wachten
		if resultaat /= "010110101" then OK <= '0';	--als resultaat niet klopt maak dan ok laag
		end if;
		wait for 3 ns;
		
		s <= "01";
		
		b <= "01010101";	--zet waarde op portb
		a <= "01001010";	--zet waarde op porta
		wait for 2 ns;		--even wachten
		if resultaat /= "010011111" then OK <= '0';	--als resultaat niet klopt maak dan ok laag
		end if;
		wait for 3 ns;
		
		b <= "01001010";	--zet waarde op portb
		a <= "01001010";	--zet waarde op porta
		wait for 2 ns;		--even wachten
		if resultaat /= "010010100" then OK <= '0';	--als resultaat niet klopt maak dan ok laag
		end if;
		wait for 3 ns;
		
		b <= "10010101";	--zet waarde op portb
		a <= "01001010";	--zet waarde op porta
		wait for 2 ns;		--even wachten
		if resultaat /= "011011111" then OK <= '0';	--als resultaat niet klopt maak dan ok laag
		end if;
		wait for 3 ns;
		
		b <= "00011100";	--zet waarde op portb
		a <= "01001010";	--zet waarde op porta
		wait for 2 ns;		--even wachten
		if resultaat /= "001100110" then OK <= '0';	--als resultaat niet klopt maak dan ok laag
		end if;
		wait for 3 ns;
		
		b <= "01101011";	--zet waarde op portb
		a <= "01001010";	--zet waarde op porta
		wait for 2 ns;		--even wachten
		if resultaat /= "010110101" then OK <= '0';	--als resultaat niet klopt maak dan ok laag
		end if;
		wait for 3 ns;
		
		
		
		
		
		wait;
	end process;
end RTL;