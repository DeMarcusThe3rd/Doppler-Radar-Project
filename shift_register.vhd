----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:34:42 03/11/2025 
-- Design Name: 
-- Module Name:    shift_register - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_register is
    Port ( 
		clk : in  STD_LOGIC;
		din : in  STD_LOGIC;
		dout : out std_logic_vector(7 downto 0);
		enable : in STD_LOGIC;
		clr : in STD_LOGIC;
		adder_in : in STD_LOGIC
	);
end shift_register;

architecture Behavioral of shift_register is
	Signal temp: std_logic_vector (7 downto 0);	
	Signal BCD1: std_logic_vector (3 downto 0);
	Signal BCD2: std_logic_vector (3 downto 0);	

begin		
	process (clk,clr,adder_in)
	begin
		if(clr = '1')then
			temp <= (others => '0');
			BCD1 <= (others => '0');
			BCD2 <= (others => '0');
		elsif(clk = '1' and clk'EVENT and enable ='1') then
			temp <= temp(6 downto 0) & din; 
		end if;
		if adder_in = '1' then
			BCD1 <= temp(7 downto 4);
			BCD2 <= temp(3 downto 0);
		end if;
	end process;
dout <= temp;
end Behavioral;
