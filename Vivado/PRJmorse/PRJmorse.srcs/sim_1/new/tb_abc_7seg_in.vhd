----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Tezky
-- 
-- Create Date: 04/19/2023 02:18:37 AM
-- Design Name: 
-- Module Name: tb_abc_7seg_in - Behavioral
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

entity tb_abc_7seg_in is
--  Port ( );
end tb_abc_7seg_in;

architecture tb_1 of tb_abc_7seg_in is
    constant clk_100MHz_period : time := 10 ns;
    
    signal sig_clk_100MHz : std_logic;
    signal tb_clk_en : std_logic;
    signal tb_rst : std_logic;
    signal tb_state : std_logic;
    signal tb_letter_id : integer;
    
    
    signal tb_cat              :   std_logic_vector(6 downto 0);
    
begin
    uut_abc_7seg_in : entity work.abc_7seg_in
        port map (
            clk => sig_clk_100MHz,
            state => tb_state,
            clk_en => tb_clk_en,
            rst => tb_rst,
            letter_id => tb_letter_id,
            
            cat => tb_cat
        );
        
    p_clk_gen : process is
        begin
            while now < 300 ns loop -- periods of 100MHz clock
                sig_clk_100MHz <= '0';
                wait for clk_100MHz_period / 2;
                sig_clk_100MHz <= '1';
                wait for clk_100MHz_period / 2;
            end loop;
            wait;                -- Process is suspended forever
        end process p_clk_gen;  
              
    p_stimulus : process is
        begin
            tb_state <= '0';
            tb_clk_en <= '0';
            tb_letter_id <= 6;
            wait for 30 ns;
            
            tb_state <= '1';
            tb_clk_en <= '0';
            tb_letter_id <= 9;
            wait for 15 ns;
            
            tb_state <= '1';
            tb_clk_en <= '1';
            tb_letter_id <= 15;
            wait for 30 ns;
            
            tb_letter_id <= 26;
            wait for 15 ns;
            
            tb_letter_id <= 1;
            wait for 30 ns;
            
            tb_rst <= '1';
            wait for 30 ns;
            tb_letter_id <= 3;
            wait for 30 ns;
            
            tb_rst <= '0';
            wait for 30 ns;
            
            tb_letter_id <= 32;
            wait for 30 ns;
            
            tb_letter_id <= 9;
            wait for 30 ns;
            
            tb_letter_id <= 6;
            wait for 30 ns;
            
            report "Stimulus process finished";
            wait;
            
    end process p_stimulus;        
        
end tb_1;
