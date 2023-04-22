----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2023 02:18:37 AM
-- Design Name: 
-- Module Name: tb_abc_7seg_out - Behavioral
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

entity tb_abc_7seg_out is
--  Port ( );
end tb_abc_7seg_out;

architecture Behavioral of tb_abc_7seg_out is
    constant clk_100MHz_period : time := 10 ns;
    
    signal sig_clk_100MHz : std_logic;
    signal tb_rst : std_logic := '0';
    signal tb_state : std_logic := '0';
    signal tb_letter_id : integer;
    signal tb_but_up : std_logic := '0';
    signal tb_but_down : std_logic := '0';
    signal tb_but_enter : std_logic := '0';
    signal tb_ready : std_logic := '1';
    
    signal tb_send : std_logic := '0';
    
begin
    uut_abc_7seg_out : entity work.abc_7seg_out
        port map (
            clk => sig_clk_100MHz,
            state => tb_state,
            rst => tb_rst,
            letter_id => tb_letter_id,
            but_up => tb_but_up,
            but_down => tb_but_down,
            but_enter => tb_but_enter,
            ready => tb_ready,
            
            send => tb_send
        );
    p_clk_gen : process is
        begin
            while now < 10000 ns loop -- periods of 100MHz clock
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
            tb_but_up <= '1';
            wait for 121 ns;
            tb_but_up <= '0';
            
            wait for 163 ns;
            tb_but_up <= '1';
            wait for 107 ns;
            tb_but_up <= '0';
            
            wait for 156 ns;
            tb_but_up <= '1';
            wait for 308 ns;
            tb_but_up <= '0';
            
            wait for 339 ns;
            tb_but_up <= '1';
            wait for 356 ns;
            tb_but_up <= '0';
            
            wait for 339 ns;
            tb_but_down <= '1';
            wait for 356 ns;
            tb_but_down <= '0';
            
            wait for 339 ns;
            tb_but_down <= '1';
            wait for 356 ns;
            tb_but_down <= '0';
            
            wait for 339 ns;
            tb_but_enter <= '1';
            wait for 356 ns;
            tb_but_enter <= '0';
            
            wait for 30 ns;
            
            report "Stimulus process finished";
            wait;
            
        end process p_stimulus;
end Behavioral;
