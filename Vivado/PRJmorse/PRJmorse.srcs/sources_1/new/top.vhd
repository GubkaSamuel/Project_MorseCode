----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Tezky
-- 
-- Create Date: 04/12/2023 11:13:05 PM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: Project Morse
-- Target Devices: Nexys A7-50T
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.morse_pkg.ALL; -- our own package of array of letter with morse code
----------------------------------------------------------------------------------
entity top is
    Port (
        CLK100MHZ : in STD_LOGIC;                   -- master clock
        BTNC : in STD_LOGIC;                        -- reset button
        BTNU : in STD_LOGIC;                        -- button for letters change up
        BTND : in STD_LOGIC;                        -- button for letters change down
        BTNR : in STD_LOGIC;                        -- button for enter
        SW   : in STD_LOGIC;                        -- I/O switch (receiver / transmitter)
        
        
        
        AN : out STD_LOGIC_VECTOR(6 downto 0);      -- Anode for 7 segment display
        CA : out STD_LOGIC;                         -- Cathode A
        CB : out STD_LOGIC;                         -- Cathode B
        CC : out STD_LOGIC;                         -- Cathode C
        CD : out STD_LOGIC;                         -- Cathode D
        CE : out STD_LOGIC;                         -- Cathode E
        CF : out STD_LOGIC;                         -- Cathode F
        CG : out STD_LOGIC;                         -- Cathode G
        JA : out STD_LOGIC;                         -- Analog pinout
        LED16_R : out STD_LOGIC                     -- Diode for check
    );
end top;
----------------------------------------------------------------------------------
architecture Behavioral of top is
    
    signal sig_clk_en : std_logic;              -- clock enable signal
    signal selected_letter_id : integer := 0;   -- selected letter id
    signal ready : std_logic;                   -- ready check statement
    signal submit : std_logic := '0';           -- send pulse signal (50ns) if we press enter in transmitter mode
    
begin
    -- component for clock enable signal
    clock_enable : entity work.clock_enable
        generic map (
        g_max =>    1000000000 
        )
    port map (
      clk => CLK100MHZ,
      rst => BTNC,
      ce  => sig_clk_en
    );
    
    -- component for letter selection and 7 seg display
    abc_7seg_out : entity work.abc_7seg_out
        port map (
            clk => CLK100MHZ,
            clk_en => sig_clk_en,
            rst => BTNC,
            state => SW,
            but_up => BTNU,
            but_down => BTND,
            but_enter => BTNR,
            ready => ready,
            
            send => submit,
            cat(0) => CA,
            cat(1) => CB,
            cat(2) => CC,
            cat(3) => CD,
            cat(4) => CE,
            cat(5) => CF,
            cat(6) => CG,
            letter_id => selected_letter_id  
        );
    morse_deliver : entity work.morse_deliver
        port map (
            clk => CLK100MHZ,
            clk_en => sig_clk_en,
            rst => BTNC,
            state => SW,
            letter_id => selected_letter_id,
            enter_pulse => submit,
            
            ready => ready,
            an_out => JA,
            led_out => LED16_R
            
        );
    
    -- switch process state if we expect receiving or transmitting
    process (CLK100MHZ, SW)
    begin
        if rising_edge(CLK100MHZ) then
            if SW = '0' then
                    
            else
                
            end if;
        end if;
    end process;
    
end Behavioral;
----------------------------------------------------------------------------------
