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
use work.sev_seg_pkg.ALL;  -- our own package or array of letter with 7 seg cathode represented as binary

entity abc_7seg_in is
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
end abc_7seg_in;

architecture Behavioral of abc_7seg_in is

begin


end Behavioral;
