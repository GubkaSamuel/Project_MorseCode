----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Tezky
-- 
-- Create Date: 04/13/2023 12:44:28 AM
-- Design Name: 
-- Module Name: sev_seg_pkg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: this package is for cathod outputs by letter character or id ('A' or '1')
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



package sev_seg_pkg is
    type letter_7seg_array is array (CHARACTER) of STD_LOGIC_VECTOR(6 downto 0);
    type id_7seg_array is array (INTEGER range 0 to 36) of STD_LOGIC_VECTOR(6 downto 0);
    
    constant letter_SEV_SEG_TABLE: letter_7seg_array := (
        'A' => "0001000",
        'B' => "1100000",
        'C' => "0110001",
        'D' => "1000010",
        'E' => "0110000",
        'F' => "0111000",
        'G' => "0100001",
        'H' => "1101000",
        'I' => "1111001",
        'J' => "1000011",
        'K' => "0101000",
        'L' => "1110001",
        'M' => "0101011",
        'N' => "0001001",
        'O' => "1100010",
        'P' => "0011000",
        'Q' => "0001100",
        'R' => "0011001",
        'S' => "0100100",
        'T' => "1110000",
        'U' => "1000001",
        'V' => "1000101",
        'W' => "1010101",
        'X' => "1001000",
        'Y' => "1000100",
        'Z' => "0010110",
        '1' => "1001111",
        '2' => "0010010",
        '3' => "0000110",
        '4' => "1001100",
        '5' => "0100100",
        '6' => "0100000",
        '7' => "0001111",
        '8' => "0000000",
        '9' => "0000100",
        '0' => "0000001",
        others => "1111110"
    ); 
     
    constant id_SEV_SEG_TABLE: id_7seg_array := (
        1 => "0001000",
        2 => "1100000",
        3 => "0110001",
        4 => "1000010",
        5 => "0110000",
        6 => "0111000",
        7 => "0100001",
        8 => "1101000",
        9 => "1111001",
        10 => "1000011",
        11 => "0101000",
        12 => "1110001",
        13 => "0101011",
        14 => "0001001",
        15 => "1100010",
        16 => "0011000",
        17 => "0001100",
        18 => "0011001",
        19 => "0100100",
        20 => "1110000",
        21 => "1000001",
        22 => "1000101",
        23 => "1010101",
        24 => "1001000",
        25 => "1000100",
        26 => "0010110",
        27 => "1001111",
        28 => "0010010",
        29 => "0000110",
        30 => "1001100",
        31 => "0100100",
        32 => "0100000",
        33 => "0001111",
        34 => "0000000",
        35 => "0000100",
        36 => "0000001",
        others => "1111110"
    ); 
    
end sev_seg_pkg;
