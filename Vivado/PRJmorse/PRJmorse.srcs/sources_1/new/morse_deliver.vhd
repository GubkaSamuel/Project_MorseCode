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


entity morse_deliver is
    Port (
        clk         : in std_logic;                     -- main clock
        clk_en      : in std_logic;                     -- clock enable impulse
        rst         : in std_logic;                     -- reset
        state       : in std_logic;                     -- state switch (receiver/transmitter mode)
        letter_id   : in integer;                       -- letter id (selected from other component)
        enter_pulse : in std_logic;                     -- pulse signal from abc_7seg_out if enter has been pressed
        dot_threshold : in integer;
        comma_threshold: in integer;

        ready       : out std_logic;                    -- ready switch to send info counter is running
        an_out      : out std_logic;                    -- signal out (morse code)
        led_out     : out std_logic                     -- show visually what are we sending on analog out
    );
end morse_deliver;

architecture Behavioral of morse_deliver is
    signal counter : integer := 0;                      -- clock counter
    signal morse_code : std_logic_vector(1 to 5);       -- morse code "buffer"
    signal morse_index: integer := 1;                   -- counter for how many symbols does this letter have
    signal sending : std_logic := '0';                  -- indicator if we are still sending morse letter
    
begin
    p_morse_deliver : process (clk) is
        begin
            if rising_edge(clk) then                                                    -- react on clock
            if clk_en = '1' then                                                        -- doesnt work if clock enable isnt enabled
            if rst = '0' then                                                           -- doesnt work if reset button is pressed
            if state = '0' then                                                         -- doesnt work if set as receiver
                ready <= not sending;                                                   -- ready is negation of sending, in the next code we are starting the sending process and making sure it wont end untill the actual "sending" is done :)
                if enter_pulse = '1' and sending = '0' then
                    case letter_id is
                        when 1 =>
                            morse_code <= "01";      -- A
                        when 2 =>
                            morse_code <= "1000";    -- B
                        when 3 =>
                            morse_code <= "1010";    -- C
                        when 4 =>
                            morse_code <= "100";     -- D
                        when 5 =>
                            morse_code <= "0";       -- E
                        when 6 =>
                            morse_code <= "0010";    -- F
                        when 7 =>
                            morse_code <= "110";     -- G
                        when 8 =>
                            morse_code <= "0000";    -- H
                        when 9 =>
                            morse_code <= "00";      -- I
                        when 10 =>
                            morse_code <= "0111";    -- J
                        when 11 =>
                            morse_code <= "101";     -- K
                        when 12 =>
                            morse_code <= "0100";    -- L
                        when 13 =>
                            morse_code <= "11";      -- M
                        when 14 =>
                            morse_code <= "10";      -- N
                        when 15 =>
                            morse_code <= "111";     -- O
                        when 16 =>
                            morse_code <= "0110";    -- P
                        when 17 =>
                            morse_code <= "1101";    -- Q
                        when 18 =>
                            morse_code <= "010";     -- R
                        when 19 =>
                            morse_code <= "000";     -- S
                        when 20 =>
                            morse_code <= "1";       -- T
                        when 21 =>
                            morse_code <= "001";     -- U
                        when 22 =>
                            morse_code <= "0001";    -- V
                        when 23 =>
                            morse_code <= "011";     -- W
                        when 24 =>
                            morse_code <= "1001";    -- X
                        when 25 =>
                            morse_code <= "1011";    -- Y
                        when 26 =>
                            morse_code <= "1100";    -- Z
                        when 27 =>
                            morse_code <= "01111";   -- 1
                        when 28 =>
                            morse_code <= "00111";   -- 2
                        when 29 =>
                            morse_code <= "00011";   -- 3
                        when 30 =>
                            morse_code <= "00001";   -- 4
                        when 31 =>
                            morse_code <= "00000";   -- 5
                        when 32 =>
                            morse_code <= "10000";   -- 6
                        when 33 =>
                            morse_code <= "11000";   -- 7
                        when 34 =>
                            morse_code <= "11100";   -- 8
                        when 35 =>
                            morse_code <= "11110";   -- 9
                        when 36 =>
                            morse_code <= "11111";   -- 0
                        when others =>
                            morse_code <= "00000";   -- Invalid letter index
                    end case;
                    morse_index <= 1;                                                   -- morse index is our "operating" symbol
                    sending <= '1';                                                     -- start sending
                end if;
                if sending = '1' then
                    counter <= counter + 1;
                        if morse_index <= morse_code'length then                        -- if our letter is still "in the limit" we run our decision logic
                    
                    
                    -- now we are not ready for another submit
                    -- in the next logic, we decide if the curent morse code symbol is . or - and then start timer for dot or comma threshold
                    -- after that, we run another timer with 0 output (to make a pause)                    
                    if morse_code(morse_index) = '0' and counter <= dot_threshold then
                        an_out <= '1';
                        led_out <= '1';
                    elsif morse_code(morse_index) = '1' and counter <= comma_threshold then
                        an_out <= '1';
                        led_out <= '1';
                    else
                        an_out <= '0';
                        led_out <= '0';
                        
                        if (morse_code(morse_index) = '0' and counter > dot_threshold + dot_threshold) or
                           (morse_code(morse_index) = '1' and counter > comma_threshold + dot_threshold) then
                            counter <= 0;
                            morse_index <= morse_index + 1;
                        end if;
                    end if;
                else
                    an_out <= '0';
                    led_out <= '0';
                    sending <= '0';
                    counter <= 0;
                end if;
                
            end if;
            end if;
            end if;
            end if;  
            end if;       
        end process p_morse_deliver;    

end Behavioral;