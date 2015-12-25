library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port(	A, B 	: in std_logic_vector(7 downto 0);
			Code 	: in std_logic_vector(3 downto 0);
			F 		: out std_logic_vector(7 downto 0);
			Cout 	: out Std_logic;
			Equal : out Std_logic);
end ALU;

architecture RTL of ALU is
signal INT : signed(8 downto 0);
signal sA, sB: signed(8 downto 0);
begin
	sA <= resize(signed(A),sA'length);
	sB <= resize(signed(B),sB'length);
	process(sA,sB,code)
	begin
		case code is		
			when "0000" =>	INT <= sA + sB;
			when "0001" =>	INT <= sA - sB;
			when "0010" =>	INT <= sB - sA;
			when "0100" =>	INT <= sA;
			when "0101" =>	INT <= sB;
			when "0110" =>	INT <= -sA;
			when "0111" =>	INT <= -sB;
			when "1000" =>	INT <= sA(7 downto 0) & '0';
			when "1001" =>	INT <= "00" & sA(7 downto 1);
			when "1010" =>	INT <= sA(7 downto 0) & sA(7);
			when "1011" =>	INT <= '0' & sA(0) & sA(7 downto 1);
			when "1110" =>	INT <= (others => '0');
			when "1111" =>	INT <= (others => '1');
			when others => INT <= INT;
		end case;
	end process;
	process(sA,sB)
	begin
		if (sA = sB) then equal <= '1';
		else equal <= '0';
		end if;
	end process;
	F <= std_logic_vector(INT(7 downto 0));
	Cout <= INT(8);
end RTL;
