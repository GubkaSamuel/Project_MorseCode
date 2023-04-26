----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Tezky
-- 
-- Create Date: 04/19/2023 02:18:37 AM
-- Design Name: 
-- Module Name: tb_morse_deliver - Behavioral
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

use work.sev_seg_pkg.ALL;  -- our own package or array of letter with 7 seg cathode represented as binary

entity tb_morse_deliver is
--  Port ( );
end tb_morse_deliver;

architecture Behavioral of tb_morse_deliver is
    constant clk_100MHz_period : time := 10 ns;
    
    signal sig_clk_100MHz : std_logic;
    signal tb_rst : std_logic := '0';
    signal tb_state : std_logic := '0';
    signal tb_letter_id : integer;
    signal tb_enter_pulse : std_logic;
    signal tb_dot_threshold : integer := 50;
    signal tb_comma_threshold : integer := 200;
    
    signal tb_ready : std_logic;
    signal tb_an_out : std_logic;
    signal tb_led_out : std_logic;
begin
    uut_morse_deliver : entity work.morse_deliver
        port map (
            clk => sig_clk_100MHz,
            state => tb_state,
            rst => tb_rst,
            letter_id => tb_letter_id,
            enter_pulse => tb_enter_pulse,
            dot_threshold => tb_dot_threshold,
            comma_threshold => tb_comma_threshold,
            
            ready => tb_ready,
            an_out => tb_an_out,
            led_out => tb_led_out
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
            tb_rst <= '0';
            tb_state <= '0';
            wait for 300 ns;
            
            tb_letter_id <= 0;
            wait for 20 ns;
            tb_enter_pulse <= '1';
            wait for 29 ns;
            tb_enter_pulse <= '0';
            wait for 6 us;
            
            tb_letter_id <= 1;
            wait for 20 ns;
            tb_enter_pulse <= '1';
            wait for 29 ns;
            tb_enter_pulse <= '0';
            wait for 10 us;
            
            tb_letter_id <= 16;
            wait for 20 ns;
            tb_enter_pulse <= '1';
            wait for 29 ns;
            tb_enter_pulse <= '0';
            wait for 10 us;
            
            report "Stimulus process finished";
            wait;
            
        
        end process p_stimulus;
            

end Behavioral;
