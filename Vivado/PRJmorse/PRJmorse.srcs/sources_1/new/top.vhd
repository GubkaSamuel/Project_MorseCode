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

use work.sev_seg_pkg.ALL;                           -- our own package or array of letter with 7 seg cathode represented as binary

----------------------------------------------------------------------------------
entity top is
    Port (
        CLK100MHZ : in STD_LOGIC;                   -- master clock
        BTNC : in STD_LOGIC;                        -- reset button
        BTNU : in STD_LOGIC;                        -- button for letters change up
        BTND : in STD_LOGIC;                        -- button for letters change down
        BTNR : in STD_LOGIC;                        -- button for enter
        SW   : in STD_LOGIC;                        -- I/O switch (receiver / transmitter)
        
        JAA  : in STD_LOGIC;                        -- Analog pinout used as INPUT
        JAB  : out STD_LOGIC;                       -- Analog pinout used as OUTPUT
        
        AN : out STD_LOGIC_VECTOR(7 downto 0);      -- Anode for 7 segment display
        CA : out STD_LOGIC;                         -- Cathode A
        CB : out STD_LOGIC;                         -- Cathode B
        CC : out STD_LOGIC;                         -- Cathode C
        CD : out STD_LOGIC;                         -- Cathode D
        CE : out STD_LOGIC;                         -- Cathode E
        CF : out STD_LOGIC;                         -- Cathode F
        CG : out STD_LOGIC;                         -- Cathode G
        LED16_R : out STD_LOGIC;                    -- Diode for signal view IN
        LED16_G : out STD_LOGIC                     -- Diode for signal view OUT
    );
end top;
----------------------------------------------------------------------------------
architecture Behavioral of top is
    
    constant dot_threshold : integer := 500000000;      -- threshold for dot
    constant comma_threshold : integer := 2000000000;   -- threshold for comma

    signal sig_clk_en : std_logic;              -- clock enable signal
    signal selected_letter_id : integer := 0;   -- selected letter id
    signal recognized_letter_id : integer := 0;   -- selected letter id
    signal ready : std_logic;                   -- ready check statement
    signal submit : std_logic := '0';           -- send pulse signal if we press enter or if we recognize letter
    
    signal cat : std_logic_vector(6 downto 0);  -- cathode outputs for process down below
    
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
            dot_threshold => dot_threshold,
            comma_threshold => comma_threshold,
            
            ready => ready,
            an_out => JAB,
            led_out => LED16_G

        );
    morse_detect : entity work.morse_detect
        port map (
            clk => CLK100MHZ, 
            state => SW,
            an_in => JAA,
            clk_en => sig_clk_en,
            dot_t => dot_threshold,
            comma_t => comma_threshold,
            
            led => LED16_R,
            lett_id => recognized_letter_id
        );
        
-- We used this mechanic in the process below
--    abc_7seg_in : entity work.abc_7seg_in
--       port map (
--            clk => CLK100MHZ, 
--            state => SW,
--            clk_en => sig_clk_en,
--            rst => BTNC,
--            letter_id => selected_letter_id
--        );
        
        
     AN <= b"1111_1110"; -- connecting anode to 3,3V
     
     
        -- switch process state if we expect receiving or transmitting
    process (CLK100MHZ)
        begin
            if rising_edge(CLK100MHZ) then
                if SW = '1' then
                    cat <= id_SEV_SEG_TABLE(selected_letter_id);
                else 
                    cat <= id_SEV_SEG_TABLE(recognized_letter_id);
                end if;
                CA <= cat(0);
                CB <= cat(1);
                CC <= cat(2);
                CD <= cat(3);
                CE <= cat(4);
                CF <= cat(5);
                CG <= cat(6);
                     
            end if;
        end process;
end Behavioral;
----------------------------------------------------------------------------------
