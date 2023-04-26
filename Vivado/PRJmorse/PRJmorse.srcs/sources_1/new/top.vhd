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
        LED17_R : out STD_LOGIC;                    -- Diode for signal view IN
        LED16_G : out STD_LOGIC                     -- Diode for signal view OUT
    );
end top;
----------------------------------------------------------------------------------
architecture Behavioral of top is
    
    constant dot_threshold : integer := 50000000;      -- threshold for dot
    constant comma_threshold : integer := 200000000;   -- threshold for comma

    signal selected_letter_id : integer;   -- selected letter id
    signal recognized_letter_id : integer;   -- selected letter id
    signal ready : std_logic := '1';                   -- ready check statement
    signal submit : std_logic := '0';           -- send signal if we press enter or if we recognize letter
    
    signal cat : std_logic_vector(6 downto 0);  -- cathode outputs for process down below
    
begin
    
    -- this entity works as a "keyboard"
    -- we use two buttons to select a letter (or symbol) and then submit it (via 3rd button) 
    -- submit means we change 'selected_letter_id' and send 'submit' signal
    letter_selector : entity work.abc_7seg_out
        port map (
            clk => CLK100MHZ,
            rst => BTNC,
            state => SW,
            but_up => BTNU,
            but_down => BTND,
            but_enter => BTNR,
            ready => ready,
            
            send => submit,
            letter_id => selected_letter_id  
        );
    morse_transmit : entity work.morse_deliver
        port map (
            clk => CLK100MHZ,
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
    morse_receive : entity work.morse_detect
        port map (
            clk => CLK100MHZ,
            rst => BTNC, 
            state => SW,
            an_in => JAA,
            dot_t => dot_threshold,
            comma_t => comma_threshold,
            
   --         led => LED16_R,
            lett_id => recognized_letter_id
        );
        
        
     AN <= b"1111_1110"; -- connecting anode to 3,3V - just one display
     LED17_R <= JAA;
     
     
        -- switch process state if we expect receiving or transmitting
    process (CLK100MHZ)
        begin
            if rising_edge(CLK100MHZ) then
                if BTNC = '0' then
                    -- I have problem with timing, this temporarily fixed it
                    -- problem is that entity abc_7seg_out outputs into selected_letter_id after first 15 ns... :-/ 
                    -- at the begining every integer is at its lower position (minus two bilion or st) so i added if to test if its in range
                    if 0 <= selected_letter_id and selected_letter_id <= 36 and SW = '0' then
                        cat <= id_SEV_SEG_TABLE(selected_letter_id);
                    end if;
                    
                    if 0 <= recognized_letter_id and recognized_letter_id <= 36 and SW = '1' then
                        cat <= id_SEV_SEG_TABLE(recognized_letter_id);     
                    end if;
                else
                    cat <= id_SEV_SEG_TABLE(0);      
                end if;
                
                CA <= cat(6);
                CB <= cat(5);
                CC <= cat(4);
                CD <= cat(3);
                CE <= cat(2);
                CF <= cat(1);
                CG <= cat(0);     
            end if;
            
        end process;
end Behavioral;
----------------------------------------------------------------------------------
