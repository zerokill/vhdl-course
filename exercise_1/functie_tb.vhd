----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:44 09/16/2008 
-- Design Name: 
-- Module Name:    functie_tb - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity functie_tb is
end functie_tb;

architecture BENCH of functie_tb is

	signal w : Std_logic;
	signal x : Std_logic;
	signal y : Std_logic;
	signal z : Std_logic;	
	signal f : Std_logic;
	
begin
	process
	begin
	
		w <= '0'; x <= '0'; y <= '0'; z <= '0';wait for 20 NS;
		w <= '0'; x <= '0'; y <= '0'; z <= '1';wait for 20 NS;
		w <= '0'; x <= '0'; y <= '1'; z <= '0';wait for 20 NS;
		w <= '0'; x <= '0'; y <= '1'; z <= '1';wait for 20 NS;

		w <= '0'; x <= '1'; y <= '0'; z <= '0';wait for 20 NS;
		w <= '0'; x <= '1'; y <= '0'; z <= '1';wait for 20 NS;
		w <= '0'; x <= '1'; y <= '1'; z <= '0';wait for 20 NS;
		w <= '0'; x <= '1'; y <= '1'; z <= '1';wait for 20 NS;

		w <= '1'; x <= '0'; y <= '0'; z <= '0';wait for 20 NS;
		w <= '1'; x <= '0'; y <= '0'; z <= '1';wait for 20 NS;
		w <= '1'; x <= '0'; y <= '1'; z <= '0';wait for 20 NS;
		w <= '1'; x <= '0'; y <= '1'; z <= '1';wait for 20 NS;

		w <= '1'; x <= '1'; y <= '0'; z <= '0';wait for 20 NS;
		w <= '1'; x <= '1'; y <= '0'; z <= '1';wait for 20 NS;
		w <= '1'; x <= '1'; y <= '1'; z <= '0';wait for 20 NS;
		w <= '1'; x <= '1'; y <= '1'; z <= '1';wait for 20 NS;		
		wait;
	end process;
	
	M: entity work.functie(dataflow)
	port map(
		w => w,
		x => x,
		y => y,
		z => z,
		f => f
	);


end architecture BENCH;

