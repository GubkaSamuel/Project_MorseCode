----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan T?žký
-- 
-- Create Date: 04/21/2023 11:54:35 PM
-- Design Name: 
-- Module Name: tb_top - Behavioral
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
use work.sev_seg_pkg.ALL;                           -- our own package or array of letter with 7 seg cathode represented as binary

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is
    constant clk_100MHz_period : time := 10 ns;
    
    signal tb_clk_100MHz : std_logic;
    signal tb_BTNC : std_logic := '0';
    signal tb_BTNU : std_logic := '0';
    signal tb_BTND : std_logic := '0';
    signal tb_BTNR : std_logic := '0';
    signal tb_SW : std_logic := '0';
    
    signal tb_JAA : std_logic := '0';
    signal tb_JAB : std_logic;
    
    signal tb_AN : std_logic_vector(7 downto 0);
    signal tb_CA : STD_LOGIC;                         
    signal tb_CB : STD_LOGIC;                         
    signal tb_CC : STD_LOGIC;                        
    signal tb_CD : STD_LOGIC;                       
    signal tb_CE : STD_LOGIC;                         
    signal tb_CF : STD_LOGIC;                 
    signal tb_CG : STD_LOGIC;                   
    signal tb_LED16_R : STD_LOGIC;          
    signal tb_LED16_G : STD_LOGIC; 
    
    signal tb_sel_id : integer;                
    
begin
    uut_top : entity work.top
        port map ( 
            CLK100MHZ => tb_clk_100MHz,
            BTNC => tb_BTNC,
            BTNU => tb_BTNU,
            BTND => tb_BTND,
            BTNR => tb_BTNR,
            SW => tb_SW,
            
            JAA => tb_JAA,
            JAB => tb_JAB,
            
            AN => tb_AN,
            CA => tb_CA,
            CB => tb_CB,
            CC => tb_CC,
            CD => tb_CD,
            CE => tb_CE,
            CF => tb_CF,
            CG => tb_CG,
            LED16_R => tb_LED16_R,
            LED16_G => tb_LED16_G,
            
            sel_id => tb_sel_id
        );
        
     p_clk_gen : process is
        begin
            while now < 30000 ns loop -- periods of 100MHz clock
                tb_clk_100MHz <= '0';
                wait for clk_100MHz_period / 2;
                tb_clk_100MHz <= '1';
                wait for clk_100MHz_period / 2;
            end loop;
            wait;                -- Process is suspended forever
        end process p_clk_gen;
        
        
           
     p_stimulus : process is
        begin
        tb_AN <= b"1111_1110";
        tb_SW <= '0';
        
        ------------------------------------------------
        wait for 300 ns;
        tb_BTNC <= '1';
        wait for 100 ns;
        tb_BTNC <= '0';
        wait for 100 ns;
        -- reset
        ------------------------
        tb_BTND <= '1';
        wait for 100 ns;
        tb_BTND <= '0';
        wait for 100 ns;
        -- down
        ------------------------
        tb_BTND <= '1';
        wait for 100 ns;
        tb_BTND <= '0';
        wait for 100 ns;
        -- down
        ------------------------        
        tb_BTNU <= '1';
        wait for 100 ns;
        tb_BTNU <= '0';
        wait for 100 ns;
        -- up
        ------------------------
        tb_BTNU <= '1';
        wait for 100 ns;
        tb_BTNU <= '0';
        wait for 100 ns;
        -- up
        ------------------------
        tb_BTNU <= '1';
        wait for 100 ns;
        tb_BTNU <= '0';
        wait for 100 ns;
        -- up
        ------------------------
        tb_BTNU <= '1';
        wait for 100 ns;
        tb_BTNU <= '0';
        wait for 100 ns;
        -- up
        ------------------------
        tb_BTNR <= '1';
        wait for 100 ns;
        tb_BTNR <= '0';
        wait for 100 ns;
        -- enter
        ------------------------
        ------------------------------------------------
        tb_SW <= '1';
        ------------------------
        tb_JAA <= '1';
        wait for 44 ns;
        tb_JAA <= '0';
        wait for 78 ns;
        -- .
        tb_JAA <= '1';
        wait for 121 ns;
        tb_JAA <= '0';
        wait for 440 ns;
        -- -
        
        -- A
        ------------------------
        tb_JAA <= '1';
        wait for 44 ns;
        tb_JAA <= '0';
        wait for 78 ns;
        -- .
        tb_JAA <= '1';
        wait for 121 ns;
        tb_JAA <= '0';
        wait for 140 ns;
        -- -
        tb_JAA <= '1';
        wait for 44 ns;
        tb_JAA <= '0';
        wait for 78 ns;
        -- .
        
        -- R
        ------------------------
        
        
        
        report "Stimulus process finished";
        wait;
        
    end process p_stimulus; 
    
end Behavioral;
