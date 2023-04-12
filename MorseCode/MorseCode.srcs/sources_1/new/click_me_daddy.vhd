----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Tezky, Samko Gubi <3 
-- 
-- Create Date: 04/12/2023 01:18:17 PM
-- Design Name: 
-- Module Name: click_me_daddy - Behavioral
-- Project Name: 
-- Target Devices: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity click_me_daddy is
Port ( 
    clk    : in    std_logic; --! Main clock
    rst    : in    std_logic; --! Synchronous reset
    en     : in    std_logic; --! Enable input
    ltr_up : in    std_logic; --! pismenko nahoru
    ltr_down : in  std_logic; --! pismenko dolu
    enter  : in    std_logic; --! enter pro odeslani
    seg    : out   std_logic_vector(6 downto 0) --! display output
    );
end click_me_daddy;

architecture Behavioral of click_me_daddy is
    signal sig_ltr : unsigned(4 downto 0); -- counter pismenek
    type char_table is array (0 to 25) of std_logic_vector(6 downto 0);
    constant letters : char_table := (
        "0001000", -- A
        "1100000", -- B
        "0110001", -- C
        "1000010", -- D
        "0110000", -- E
        "0111000", -- F
        "0100001", -- G
        "1101000", -- H
        "1111001", -- I
        "1000011", -- J
        "0101000", -- K
        "1110001", -- L
        "0101011", -- M
        "0001001", -- N
        "0000001", -- O
        "0011000", -- P
        "0001100", -- Q
        "0011001", -- R
        "0100100", -- S
        "1110000", -- T
        "1000001", -- U
        "1000101", -- V
        "1010101", -- W
        "1001000", -- X
        "1000100", -- Y
        "0010110"  -- Z
    );
begin
    p_click_me_daddy : process (clk) is
    begin
        if rising_edge(clk) then
            if(rst = '1') then
                sig_ltr <= (others => '0');
            elsif (en='1') then
                if (ltr_up ='1' and ltr_down ='0') then
                    sig_ltr <= sig_ltr + 1;
                    seg <= letters(to_integer(sig_ltr));
                elsif (ltr_down ='1' and ltr_up ='0') then
                    sig_ltr <= sig_ltr - 1;
                end if;
            end if;
        end if;
    end process p_click_me_daddy;
    
    
end Behavioral;
