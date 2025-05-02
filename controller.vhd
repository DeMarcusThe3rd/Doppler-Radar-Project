library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity controller is
    Port ( adder_in  : in  STD_LOGIC;
           din  : in  STD_LOGIC;
           clk  : in  STD_LOGIC;
           enable  : out  STD_LOGIC;
           clr  : out  STD_LOGIC);
end controller;

architecture Behavioral of controller is
    signal state : STD_LOGIC_VECTOR (1 downto 0) := "00";  -- state machine signal
    signal two  : STD_LOGIC_VECTOR (1 downto 0) := "00"; -- counter signal for 4
begin
    -- Process triggered by the clock
    process(clk)
    begin
        if rising_edge(clk) then  -- Trigger on rising edge of clock
            case state is 
                when "00" =>  -- Idle mode
							enable <= '0';
                    if (din = '0') then
                        two <= two + 1;  -- Increment 'four'
                    end if;
                    if (two(1) = '1') then  -- Check if the MSB of 'four' is 1
                        clr <= '1';  -- Set clear
                        state <= "01";  -- Transition to measuring state
                    end if;

                when "01" =>  -- Measuring state
                    clr <= '0';  -- Clear signal should be 0 in this state
                    enable <= '1';  -- Enable signal is active
                    if (adder_in = '1') then  -- Wait for adder input to be '1'
                        state <= "10";  -- Transition to stop mode
                    end if;

                when "10" =>  -- Stop mode
                    enable <= '0';  -- Disable signal
                    two <= "00";  -- Reset counter 'four'
                    state <= "00";  -- Transition back to idle state

                when others =>  -- Default case
                    state <= "00";  -- Ensure state resets to idle if unknown state
            end case;
        end if;
    end process;

end Behavioral;
