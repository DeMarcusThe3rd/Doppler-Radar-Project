----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:16:31 03/14/2025 
-- Design Name: 
-- Module Name:    adder - Behavioral 
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
    Port ( clk : in  STD_LOGIC;
           eight : out  STD_LOGIC;
           clr : in  STD_LOGIC);
end adder;

architecture Behavioral of adder is
signal temp : STD_LOGIC_VECTOR(3 downto 0):="0000";  --4-bit counter 
begin
	process(clk,clr)
	begin
	if (clr='1')then  
		temp <= (others => '0');  --Reset the counter to 0 
	elsif (clr='0' and clk='1' and clk'EVENT) then  --Keeps track of the 8 data bits on every rising edge  
		temp <= temp + '1';
	end if;
	end process;
	
eight <= temp(3); --eight bits have been counted
end Behavioral;

