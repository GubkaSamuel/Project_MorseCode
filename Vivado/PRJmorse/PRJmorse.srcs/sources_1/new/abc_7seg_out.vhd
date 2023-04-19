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
-- Revision 0.02 - Debounce mechanism added
-- Revision 0.03 - Ready state added (waiting for morse to be sent)
-- Additional Comments: I hate this 'if' syntax... :(
-- 
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.sev_seg_pkg.ALL;  -- our own package or array of letter with 7 seg cathode represented as binary
----------------------------------------------------------------------------------
entity abc_7seg_out is
    Port (
        clk         : in std_logic;                     -- main clock
        clk_en      : in std_logic;                     -- clock enable impulse
        rst         : in std_logic;                     -- reset
        state       : in std_logic;                     -- state switch (receiver/transmitter mode)
        but_up      : in std_logic;                     -- letter up button
        but_down    : in std_logic;                     -- letter down button
        but_enter   : in std_logic;                     -- enter letter button
        ready       : in std_logic;                     -- ready state (awaiting for morse to be sent)
        
        send        : out std_logic;                    -- sends puls if we submit (by pressing enter)
        cat         : out std_logic_vector(6 downto 0); -- cathode for 7 seg
        letter_id   : out integer range 1 to 36         -- letter number (a = 0, z = 25)
    );
end abc_7seg_out;
----------------------------------------------------------------------------------
architecture Behavioral of abc_7seg_out is
    signal selected_index : integer := 1;               -- set default letter index to 1 ('A')
    
    signal but_up_counter : integer := 0;               -- add debounce counter for but_up
    signal but_down_counter : integer := 0;             -- add debounce counter for but_down
    signal but_enter_counter : integer := 0;            -- add debounce counter for but_enter
    constant debounce_threshold : integer := 50000;     -- set debounce threshold


begin
    p_abc_7seg_out : process (clk) is
    begin
        if rising_edge(clk) then                                                        -- react on clock
            if clk_en = '1' then                                                        -- doesnt work if clock enable isnt enabled
            if rst = '0' then                                                           -- doesnt work if reset button is pressed
            if state = '0' then                                                         -- doesnt work if set as receiver
            if ready = '0' then
                cat <= "1111110";                                                       -- if there is some other stuff running (ready check isn't complete) then 7 seg shows '-'
            else
            
                -- BUTTON SELECTION LOGIC
                -- only works if one button pressed at a time
                -- if we press the up/down button "selected_index" will change its value so we have different output on cathodes
                -- implemented simple logic so "selected_index" can be on range 1 to 36
                -- signal on cathodes is defined in "sev_seg_pkg"
                -- after finding the letter, we need to press enter button - it will change letter_id integer so other components can work with it (declared in top.vhd)
                
                --db for up
                if(but_up = '1' and but_down = '0' and but_enter = '0') then 
                    but_up_counter <= but_up_counter + 1;
                    if but_up_counter = debounce_threshold then       
                        if(selected_index < 36) then
                            selected_index <= selected_index + 1;
                        else selected_index <= 1;
                        end if;
                        cat <= id_SEV_SEG_TABLE(selected_index);
                    end if;
                else but_up_counter <= 0;
                end if;
                
                --db for down
                if(but_up = '0' and but_down = '1' and but_enter = '0') then
                    but_down_counter <= but_down_counter + 1;
                    if but_down_counter = debounce_threshold then
                        if(selected_index > 0) then
                        selected_index <= selected_index - 1;
                        else selected_index <= 36;
                        end if;
                        cat <= id_SEV_SEG_TABLE(selected_index);
                    end if;
                else but_down_counter <= 0;
                end if;
                
                --db for enter
                if(but_up = '0' and but_down = '0' and but_enter = '1') then
                    but_enter_counter <= but_enter_counter + 1;
                    if but_enter_counter = debounce_threshold then
                        letter_id <= selected_index;
                        -- easy pulse mechanic to state some letter has been sent (enter pressed) for other components
                        send <= '1';
                    else send <= '0';
                    end if;    
                else but_enter_counter <= 0;
                end if;
                
            end if;
            else
                but_up_counter <= 0;
                but_down_counter <= 0;
                but_enter_counter <= 0;
            end if;
            else
                cat <= "1111110";
            end if;
            end if;
        end if;
    end process p_abc_7seg_out;
end Behavioral;
