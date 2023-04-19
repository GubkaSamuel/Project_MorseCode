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

use work.morse_pkg.ALL;                             -- our own package of array of letter with morse code
use work.sev_seg_pkg.ALL;                           -- our own package or array of letter with 7 seg cathode represented as binary

entity morse_detect is
    Port (
        clk         : in std_logic;                 -- master clock
        state       : in std_logic;                 -- state signal (transmitter/receiver)
        analog_in   : in std_logic;                 -- analog input with morse code signal
        clk_en      : in std_logic;                 -- clock enable signal
        dot_t       : in integer;                   -- dot threshold 
        comma_t     : in integer;                   -- comma threshold

        led         : out std_logic;                -- signal imput visualizer
        lett_id     : out integer                   -- recognized letter id
    );
end morse_detect;

architecture Behavioral of morse_detect is

-- local variables (morse_state with 4 possible states)
    type morse_state is (IDLE, SIGNAL_ON, SIGNAL_OFF, INTER_LETTER);
    signal current_state: morse_state;
    signal current_letter: string;
    signal current_length: integer := 0;

begin
    process (clk)
    begin
        -- main clock implementation
        if rising_edge(clk) and state = '1' then
            -- led indicates if analog_in is 0 or 1
            led <= analog_in;
            
            -- 4 cases (states)
            case current_state is
                
                -- idle = we are waiting for '1' on imput
                when IDLE =>
                    if analog_in = '1' then
                        current_length <= 0;
                        current_state <= SIGNAL_ON;
                    end if;
                
                -- we have '1' on imput and we are waiting for '0', then we decide if it was a comma or dot (1 or 0)
                when SIGNAL_ON =>
                    current_length <= current_length + 1;
                    if analog_in = '0' then
                        if current_length <= dot_t then
                            if current_letter'length < 5 then
                                current_letter <= current_letter & "0";
                            end if;
                        elsif current_length <= comma_t then
                            if current_letter'length < 5 then
                                current_letter <= current_letter & "1";
                            else
                                current_length <= 0;
                                current_state <= IDLE;
                            end if;
                            current_state <= SIGNAL_OFF;
                            current_length <= 0;
                        else
                            current_state <= INTER_LETTER;    
                        end if;
                    end if;
                
                -- we have '0' on imput but we still dont know if the letter ended, so we wait for '0' or for *comma_t* time to continue with signal_on or to submit letter
                when SIGNAL_OFF =>
                    current_length <= current_length + 1;
                    if analog_in = '1' then
                        current_state <= SIGNAL_ON;
                        current_length <= 0;
                    elsif current_length > dot_t then
                        current_state <= INTER_LETTER;
                    end if;
                
                -- after we submited letter, we decide what index does this letter have
                when INTER_LETTER =>
                    if analog_in = '1' then
                        current_length <= 0;
                        current_state <= SIGNAL_ON;
                    else
                        current_length <= current_length + 1;
                        if current_length > comma_t then
                            case current_letter is
                                when "01" =>
                                    lett_id <= 1; -- A
                                when "1000" =>
                                    lett_id <= 2; -- B
                                when "1010" =>
                                    lett_id <= 3; -- C
                                when "100" =>
                                    lett_id <= 4; -- D
                                when "0" =>
                                    lett_id <= 5; -- E
                                when "0010" =>
                                    lett_id <= 6; -- F
                                when "110" =>
                                    lett_id <= 7; -- G
                                when "0000" =>
                                    lett_id <= 8; -- H
                                when "00" =>
                                    lett_id <= 9; -- I
                                when "0111" =>
                                    lett_id <= 10; -- J
                                when "101" =>
                                    lett_id <= 11; -- K
                                when "0100" =>
                                    lett_id <= 12; -- L
                                when "11" =>
                                    lett_id <= 13; -- M
                                when "10" =>
                                    lett_id <= 14; -- N
                                when "111" =>
                                    lett_id <= 15; -- O
                                when "0110" =>
                                    lett_id <= 16; -- P
                                when "1101" =>
                                    lett_id <= 17; -- Q
                                when "010" =>
                                    lett_id <= 18; -- R
                                when "000" =>
                                    lett_id <= 19; -- S
                                when "1" =>
                                    lett_id <= 20; -- T
                                when "001" =>
                                    lett_id <= 21; -- U
                                when "0001" =>
                                    lett_id <= 22; -- V
                                when "011" =>
                                    lett_id <= 23; -- W
                                when "1001" =>
                                    lett_id <= 24; -- X
                                when "1011" =>
                                    lett_id <= 25; -- Y
                                when "1100" =>
                                    lett_id <= 26; -- Z
                                when "01111" =>
                                    lett_id <= 27; -- 1
                                when "00111" =>
                                    lett_id <= 28; -- 2
                                when "00011" =>
                                    lett_id <= 29; -- 3
                                when "00001" =>
                                    lett_id <= 30; -- 4
                                when "00000" =>
                                    lett_id <= 31; -- 5
                                when "10000" =>
                                    lett_id <= 32; -- 6
                                when "11000" =>
                                    lett_id <= 33; -- 7
                                when "11100" =>
                                    lett_id <= 34; -- 8
                                when "11110" =>
                                    lett_id <= 35; -- 9
                                when "11111" =>
                                    lett_id <= 36; -- 0
                                when others =>
                                    lett_id <= -1; -- neplatná hodnota
                            end case;
                            current_letter <= "";
                            current_state <= IDLE;
                        end if;
                    end if;
            end case;
        end if;
    end process;
    
end Behavioral;