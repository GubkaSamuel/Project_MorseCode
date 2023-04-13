----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Tezky
-- 
-- Create Date: 04/13/2023 12:14:52 AM
-- Design Name: 
-- Module Name: morse_pkg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: this package is for sharing letter decimal codes, morse codes and symbols via different components
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


package morse_pkg is
    type letter_morse_array is array (CHARACTER) of STRING(1 to 5);
    type letter_bin_morse_array is array (CHARACTER) of STD_LOGIC_VECTOR(1 to 5);
    type letter_index_array is array (CHARACTER) of INTEGER;
    type index_to_letter_array is array (INTEGER range 1 to 36) of CHARACTER;
    type index_to_morse_array is array (INTEGER range 1 to 36) of STD_LOGIC_VECTOR(1 to 5);
    
    constant MORSE_TABLE: letter_morse_array := (
        'A' => ".-",
        'B' => "-...",
        'C' => "-.-.",
        'D' => "-..",
        'E' => ".",
        'F' => "..-.",
        'G' => "--.",
        'H' => "....",
        'I' => "..",
        'J' => ".---",
        'K' => "-.-",
        'L' => ".-..",
        'M' => "--",
        'N' => "-.",
        'O' => "---",
        'P' => ".--.",
        'Q' => "--.-",
        'R' => ".-.",
        'S' => "...",
        'T' => "-",
        'U' => "..-",
        'V' => "...-",
        'W' => ".--",
        'X' => "-..-",
        'Y' => "-.--",
        'Z' => "--..",
        '1' => ".----",
        '2' => "..---",
        '3' => "...--",
        '4' => "....-",
        '5' => ".....",
        '6' => "-....",
        '7' => "--...",
        '8' => "---..",
        '9' => "----.",
        '0' => "-----"
    );
    
    constant MORSE_BIN_TABLE: letter_bin_morse_array := (
    'A' => "01",
    'B' => "1000",
    'C' => "1010",
    'D' => "100",
    'E' => "0",
    'F' => "0010",
    'G' => "110",
    'H' => "0000",
    'I' => "00",
    'J' => "0111",
    'K' => "101",
    'L' => "0100",
    'M' => "11",
    'N' => "10",
    'O' => "111",
    'P' => "0110",
    'Q' => "1101",
    'R' => "010",
    'S' => "000",
    'T' => "1",
    'U' => "001",
    'V' => "0001",
    'W' => "011",
    'X' => "1001",
    'Y' => "1011",
    'Z' => "1100",
    '1' => "01111",
    '2' => "00111",
    '3' => "00011",
    '4' => "00001",
    '5' => "00000",
    '6' => "10000",
    '7' => "11000",
    '8' => "11100",
    '9' => "11110",
    '0' => "11111"
    );
      
    constant LETTER_TO_INDEX: letter_index_array := (
        'A' => 1,
        'B' => 2,
        'C' => 3,
        'D' => 4,
        'E' => 5,
        'F' => 6,
        'G' => 7,
        'H' => 8,
        'I' => 9,
        'J' => 10,
        'K' => 11,
        'L' => 12,
        'M' => 13,
        'N' => 14,
        'O' => 15,
        'P' => 16,
        'Q' => 17,
        'R' => 18,
        'S' => 19,
        'T' => 20,
        'U' => 21,
        'V' => 22,
        'W' => 23,
        'X' => 24,
        'Y' => 25,
        'Z' => 26,
        '1' => 27,
        '2' => 28,
        '3' => 29,
        '4' => 30,
        '5' => 31,
        '6' => 32,
        '7' => 33,
        '8' => 34,
        '9' => 35,
        '0' => 36
    );
    
constant INDEX_TO_LETTER: index_to_letter_array := (
    1 => 'A',
    2 => 'B',
    3 => 'C',
    4 => 'D',
    5 => 'E',
    6 => 'F',
    7 => 'G',
    8 => 'H',
    9 => 'I',
    10 => 'J',
    11 => 'K',
    12 => 'L',
    13 => 'M',
    14 => 'N',
    15 => 'O',
    16 => 'P',
    17 => 'Q',
    18 => 'R',
    19 => 'S',
    20 => 'T',
    21 => 'U',
    22 => 'V',
    23 => 'W',
    24 => 'X',
    25 => 'Y',
    26 => 'Z',
    27 => '1',
    28 => '2',
    29 => '3',
    30 => '4',
    31 => '5',
    32 => '6',
    33 => '7',
    34 => '8',
    35 => '9',
    36 => '0'
    );
    
constant INDEX_TO_MORSE: index_to_morse_array := (
    1 => "01",      -- A
    2 => "1000",    -- B
    3 => "1010",    -- C
    4 => "100",     -- D
    5 => "0",       -- E
    6 => "0010",    -- F
    7 => "110",     -- G
    8 => "0000",    -- H
    9 => "00",      -- I
    10 => "0111",   -- J
    11 => "101",    -- K
    12 => "0100",   -- L
    13 => "11",     -- M
    14 => "10",     -- N
    15 => "111",    -- O
    16 => "0110",   -- P
    17 => "1101",   -- Q
    18 => "010",    -- R
    19 => "000",    -- S
    20 => "1",      -- T
    21 => "001",    -- U
    22 => "0001",   -- V
    23 => "011",    -- W
    24 => "1001",   -- X
    25 => "1011",   -- Y
    26 => "1100",   -- Z
    27 => "01111",  -- 1
    28 => "00111",  -- 2
    29 => "00011",  -- 3
    30 => "00001",  -- 4
    31 => "00000",  -- 5
    32 => "10000",  -- 6
    33 => "11000",  -- 7
    34 => "11100",  -- 8
    35 => "11110",  -- 9
    36 => "11111"   -- 0
);

end package morse_pkg;