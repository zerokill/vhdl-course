----------------------------------------------------------------------------------
-- Company: 		 HU
-- Engineer: 		 Maurice Daverveldt - 1531491 - Ev3A
-- 
-- Create Date:    17:50:52 09/16/2008 
-- Design Name: 	
-- Module Name:    functie - dataflow 
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
-- functie geeft 0 bij:
-- 1, 5, 6, 7, 8, 13 en 15
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity functie is
    Port ( w : in  STD_LOGIC;
           x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           z : in  STD_LOGIC;
           f : out  STD_LOGIC);
end functie;

architecture dataflow of functie is

begin

	f <= (x and z) or (not w and x and y) or (not w and not y and z) or (w and not x and not y and not z);

end dataflow;

