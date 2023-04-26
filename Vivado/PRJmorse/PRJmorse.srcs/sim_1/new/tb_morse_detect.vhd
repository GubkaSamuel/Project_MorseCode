----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2023 02:18:37 AM
-- Design Name: 
-- Module Name: tb_morse_detect - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_morse_detect is
--  Port ( );
end tb_morse_detect;

architecture Behavioral of tb_morse_detect is
    constant clk_100MHz_period : time := 10 ns;
    
    signal sig_clk_100MHz : std_logic;
    signal tb_rst : std_logic := '0';
    signal tb_state : std_logic := '1';
    signal tb_an_in : std_logic;
    signal tb_dot_t : integer := 5;
    signal tb_comma_t : integer := 20;
    
    signal tb_led : std_logic;
    signal tb_lett_id : integer;
begin
    uut_morse_detect : entity work.morse_detect
        port map (
            clk => sig_clk_100MHz,
            state => tb_state,
            rst => tb_rst,
            an_in => tb_an_in,
            dot_t => tb_dot_t,
            comma_t => tb_comma_t,
            
            led => tb_led,
            lett_id => tb_lett_id
        );
    p_clk_gen : process is
        begin
            while now < 30000 ns loop -- periods of 100MHz clock
                sig_clk_100MHz <= '0';
                wait for clk_100MHz_period / 2;
                sig_clk_100MHz <= '1';
                wait for clk_100MHz_period / 2;
            end loop;
            wait;                -- Process is suspended forever
        end process p_clk_gen;
        
    p_stimulus : process is
        begin
            wait for 300 ns;
            
            tb_an_in <= '1';
            wait for 45 ns;
            tb_an_in <= '0';
            wait for 75 ns;
            
            tb_an_in <= '1';
            wait for 147 ns;
            tb_an_in <= '0';
            wait for 250 ns;
            -- A
            
            
            tb_an_in <= '1';
            wait for 147 ns;
            tb_an_in <= '0';
            wait for 75 ns;
            
            tb_an_in <= '1';
            wait for 45 ns;
            tb_an_in <= '0';
            wait for 75 ns;
            
            tb_an_in <= '1';
            wait for 147 ns;
            tb_an_in <= '0';
            wait for 75 ns;
            
            tb_an_in <= '1';
            wait for 45 ns;
            tb_an_in <= '0';
            wait for 250 ns;
            -- C
            
            tb_an_in <= '1';
            wait for 147 ns;
            tb_an_in <= '0';
            wait for 75 ns;
            
            tb_an_in <= '1';
            wait for 147 ns;
            tb_an_in <= '0';
            wait for 75 ns;
            
            tb_an_in <= '1';
            wait for 45 ns;
            tb_an_in <= '0';
            wait for 250 ns;
            -- G
            
            tb_an_in <= '1';
            wait for 45 ns;
            tb_an_in <= '0';
            wait for 75 ns;
            
            tb_an_in <= '1';
            wait for 45 ns;
            tb_an_in <= '0';
            wait for 75 ns;
            
            tb_an_in <= '1';
            wait for 147 ns;
            tb_an_in <= '0';
            wait for 250 ns;
            -- U
            
            report "Stimulus process finished";
            wait;
        end process p_stimulus;    
end Behavioral;
