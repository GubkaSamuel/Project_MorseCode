----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan T?žký
-- 
-- Create Date: 04/05/2023 02:27:45 PM
-- Design Name: 
-- Module Name: abc_to_morse - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity abc_to_morse is
    Port (
        blank : in std_logic; --reset
        abc_bin : in std_logic_vector(4 downto 0); --písmeno v bin kódu
        morse : out std_logic_vector(5 downto 0) --morse v bin kódu
        
     );
end abc_to_morse;

architecture Behavioral of abc_to_morse is
--první dva bity obsahují informaci o po?tu symbol? (te?ek a ?árek) v bin kódu, další 4 bity obsahují kombinaci symbol? (0 = te?ka, 1 = ?árka)
--00 = 1 symbol, 01 = 2 symboly, 10 = 3 symboly, 11 = 4 symboly
  --nap?. 010100 = A (01 - 2 symboly, 01 .- a zbylé dva symboly nás nezajímají)
  --nap?. 110111 = J (11 = 4 symboly, 0111 .---)
begin

    p_abc_to_morse : process (abc_bin, blank) is
    
    begin
    
    if(blank = '1') then
        morse <= "000000";
    else
        case abc_bin is
            
            when "00000" =>
             
             morse <= "010100"; --a
            
            when "00001" =>
            
             morse <= "111000"; --b
             
            when "00010" =>
            
             morse <= "111010"; --c
            
            when "00011" =>
            
             morse <= "101000"; --d
             
            when "00100" =>
            
             morse <= "000000"; --e 
             
            when "00101" =>
            
             morse <= "110010"; --f
             
            when "00110" =>
            
             morse <= "101100"; --g
            
            when "00111" =>
            
             morse <= "110000"; --h
             
            when "01000" =>
            
             morse <= "010000"; --i
            
            when "01001" =>
            
             morse <= "110111"; --j
             
            when "01010" =>
            
             morse <= "101010"; --k
            
            when "01011" =>
            
             morse <= "110100"; --l
            
            when "01100" =>
            
             morse <= "011100"; --m
            
            when "01101" =>
            
             morse <= "011000"; --n
             
            when "01110" =>
            
             morse <= "101110"; --o
            
            when "01111" =>
            
             morse <= "110110"; --p
             
            when "10000" =>
            
             morse <= "111101"; --q
            
            when "10001" =>
            
             morse <= "100100"; --r
            
            when "10010" =>
            
             morse <= "100000"; --s
            
            when "10011" =>
            
             morse <= "001000"; --t
            
            when "10100" =>
            
             morse <= "100010"; --u
            
            when "10101" =>
            
             morse <= "110001"; --v
             
            when "10110" =>
            
             morse <= "100110"; --w
            
            when "10111" =>
            
             morse <= "111001"; --x
            
            when "11000" =>
            
             morse <= "111011"; --y
             
            when others =>
            
             morse <= "111100"; --z 
             
        end case;
    end if;

    end process p_abc_to_morse;
    
end architecture Behavioral;
