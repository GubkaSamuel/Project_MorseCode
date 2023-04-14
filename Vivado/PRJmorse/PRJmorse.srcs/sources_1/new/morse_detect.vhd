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
        lett_id     : out integer;                  -- recognized letter id
        confirm     : out std_logic                 -- confirm letter recognition
    );
end morse_detect;

architecture Behavioral of morse_detect is
    type morse_state is (IDLE, SIGNAL_ON, SIGNAL_OFF, INTER_LETTER);
    signal current_state: morse_state;
    signal current_letter: string(1 to 5) := (others => '0');
    signal current_length: integer := 0;
    signal temp_pulse: std_logic := '0';
    signal tick: std_logic := '0';

begin
    process (clk, state)
    begin
        if rising_edge(clk) and state = '1' then
            led <= analog_in;
            
            case current_state is
                when IDLE =>
                    if analog_in = '1' then
                        current_length <= 0;
                        current_state <= SIGNAL_ON;
                    end if;

                when SIGNAL_ON =>
                    current_length <= current_length + 1;
                    if analog_in = '0' then
                        if current_length <= dot_t then
                            current_letter := current_letter & "0";
                        elsif current_length <= comma_t then
                            current_letter := current_letter & "1";
                        end if;
                        current_state <= SIGNAL_OFF;
                        current_length <= 0;
                    end if;

                when SIGNAL_OFF =>
                    current_length <= current_length + 1;
                    if analog_in = '1' then
                        current_state <= SIGNAL_ON;
                        current_length <= 0;
                    elsif current_length > dot_t then
                        current_state <= INTER_LETTER;
                    end if;

                when INTER_LETTER =>
                    if analog_in = '1' then
                        current_length <= 0;
                        current_state <= SIGNAL_ON;
                    else
                        current_length <= current_length + 1;
                        if current_length > comma_t then
                            current_state <= IDLE;
                            lett_id <= morse_to_letter(current_letter);
                            temp_pulse <= '1';
                        end if;
                    end if;
            end case;
        end if;
    end process;

    -- Generate confirm pulse of appropriate duration
    process (clk, temp_pulse)
    begin
        if rising_edge(clk) then
            if temp_pulse = '1' then
                tick <= not tick;
            else
                tick <= '0';
            end if;
        end if;
    end process;

    confirm <= tick and temp_pulse;
end Behavioral;