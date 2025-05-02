----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:44:44 03/12/2025 
-- Design Name: 
-- Module Name:    integration - Behavioral 
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

entity integration is
 Port ( 
        clk_in    : in  STD_LOGIC;   -- Clock signal
        din    : in  STD_LOGIC;   -- Serial data input
        seg1   : out std_logic_vector(6 downto 0); -- 7-segment display 1
        seg2   : out std_logic_vector(6 downto 0);  -- 7-segment display 2
		  output : out STD_LOGIC
    );
end integration;

architecture Structural of integration is

-- Declare components
	component clock_buf
			  Port ( 
					clk : in  STD_LOGIC;
					enable : in STD_LOGIC;
					o : out  STD_LOGIC;
					o1 : out STD_LOGIC
			  );
		 end component;
		 
    component shift_register
        Port ( 
            clk    : in  STD_LOGIC;
            din    : in  STD_LOGIC;
				adder_in : in STD_LOGIC;
            dout   : out std_logic_vector(7 downto 0);
            enable : in  STD_LOGIC;
            clr    : in  STD_LOGIC
        );
    end component;

    component bcd_7segment
        Port (
            BCDin : in  STD_LOGIC_VECTOR (3 downto 0);
            Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;
	 
	 component adder
		Port ( 
			  clk : in  STD_LOGIC;
           eight : out  STD_LOGIC;
           clr : in  STD_LOGIC);
	 end component;
	 
	 component controller 
		Port ( 
			  adder_in  : in  STD_LOGIC;
           din  : in  STD_LOGIC;
           clk  : in  STD_LOGIC;
           enable  : out  STD_LOGIC;
           clr  : out  STD_LOGIC);
	 end component;
	 
    -- Internal signals
    signal dout_signal: std_logic_vector(7 downto 0); -- Shift register output
    signal BCD1: std_logic_vector(3 downto 0) := "0000"; -- Upper BCD digit
    signal BCD2: std_logic_vector(3 downto 0):= "0000"; -- Lower BCD digit
    signal slow_clk : STD_LOGIC; -- 57600
	 signal fast_clk : STD_LOGIC; -- 480k 
	 signal enable : STD_LOGIC; 
	 signal clr : STD_LOGIC; 
	 signal adder_8 : STD_LOGIC;

begin

		U6: controller 
		port map(
			adder_in  => adder_8,
         din => din,
         clk => fast_clk,
         enable => enable,
         clr => clr
		);

	 U2: adder
		port map(
			clk=>slow_clk,
			eight=>adder_8,
			clr=>clr
		);
		  
    U3: shift_register
        port map (
            clk    => slow_clk,
            din    => din,
            dout   => dout_signal,
            enable => enable,
            clr    => clr,
				adder_in => adder_8
        );

    -- Extract BCD digits from shift register output
    BCD1 <= dout_signal(7 downto 4) when adder_8 ='1'; -- Upper 4 bits
    BCD2 <= dout_signal(3 downto 0) when adder_8 ='1'; -- Lower 4 bits
	 
    -- Instantiate 7-segment display converters
    U4: bcd_7segment
        port map (
            BCDin => BCD1,
            Seven_Segment => seg1
        );

    U5: bcd_7segment
        port map (
            BCDin => BCD2,
            Seven_Segment => seg2
        );
		  
		    -- Instantiate shift register
	  U1: clock_buf
	  port map (
			clk => clk_in,
			o => fast_clk,
			enable => enable,
			o1 => slow_clk
	  );
	  
		  
	 output <= slow_clk;
		
end Structural;
