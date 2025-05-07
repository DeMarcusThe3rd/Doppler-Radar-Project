----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:38 03/10/2025 
-- Design Name: 
-- Module Name:    clock_buf - Behavioral 
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

entity clock_buf is
    Port ( CLK : in  STD_LOGIC;
			  enable : in STD_LOGIC;
           O : out  STD_LOGIC;
			  O1: out STD_LOGIC);
end clock_buf;

	architecture Behavioral of clock_buf is
	signal CLK_DIV : STD_LOGIC_VECTOR(2 downto 0):="000";   --Fast clock
	signal CLK_DIV1 : STD_LOGIC_VECTOR(4 downto 0):="00000"; --Slow clock
begin
	process(CLK,enable)
	begin
	if rising_edge(clk) then
			CLK_DIV <= CLK_DIV + '1';
			if (enable='1')then   --If enable is 1, that means the start bit has been detected,and we must use slow clock 
				CLK_DIV1 <= CLK_DIV1 + '1'; 
			end if;
			
			if (enable ='0') then --If enable is 0, that means the start bit has not been detected,and we must use fast clock to detect for start bits 
				CLK_DIV1 <= (others => '0');
			end if;
			
		end if;
	end process;
	O<=CLK_DIV(2);
	O1<=CLK_DIV1(4);
	
end Behavioral;

