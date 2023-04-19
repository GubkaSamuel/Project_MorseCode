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
use work.sev_seg_pkg.ALL;  -- our own package or array of letter with 7 seg cathode represented as binary

entity abc_7seg_in is
    Port (
        clk         : in std_logic;                     -- master clock
        state       : in std_logic;                     -- state signal (transmitter/receiver)
        clk_en      : in std_logic;                     -- clock enable signal
        rst         : in std_logic;                     -- reset
        letter_id   : in integer;                       -- recognized letter id
        
        cat         : out std_logic_vector(6 downto 0)  -- cathodes of 7 seg display
    );
end abc_7seg_in;

architecture Behavioral of abc_7seg_in is

begin
    process (clk)
    begin
        if rising_edge(clk) and state = '1' and clk_en = '1' then
            if rst = '1' then
                cat <= id_SEV_SEG_TABLE(0);
            else
                cat <= id_SEV_SEG_TABLE(letter_id);
            end if;
        end if;         
    end process;
    
end Behavioral;
