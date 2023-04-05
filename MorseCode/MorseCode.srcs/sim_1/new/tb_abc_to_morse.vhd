----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan T?žký
-- 
-- Create Date: 04/05/2023 09:04:34 PM
-- Design Name: 
-- Module Name: tb_abc_to_morse - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_abc_to_morse is
--  Port ( );
end tb_abc_to_morse;

architecture Behavioral of tb_abc_to_morse is

    --testbench lokální prom?nné
    signal sig_blank : std_logic;
    signal sig_abc_bin : std_logic_vector(4 downto 0);
    signal sig_morse : std_logic_vector(5 downto 0);
    
    
begin

    uut_abc_to_morse : entity work.abc_to_morse --unit under test 
      port map (
        blank => sig_blank,
        abc_bin => sig_abc_bin,
        morse => sig_morse
      );

    p_stimulus : process is 
    begin 
        report "Stimulus process started";
        
        sig_blank <= '0'; --za?átek operace
        sig_abc_bin <= "00000"; --defaultní písmeno ('a')
        wait for 50 ns;
        
        sig_blank <= '1'; --reset
        wait for 30 ns; 
        sig_blank <= '0'; --za?átek 2. operace
        wait for 15 ns;
        
        --smy?ka pro všechny abc_bin možnosti (všechny nejsou použity - od 26 do 31 budou pouze 'z'
        for ii in 0 to 28 loop
        --nemusíme testovat vše, sta?í 0 - 25, ale chci vyzkoušet i p?ípady mimo zadané meze (26 a výše)
        
            --p?evod dec na 5 bit ?íslo
            sig_abc_bin <= std_logic_vector(to_unsigned(ii, 5));
            wait for 30 ns;
            
        end loop;
        
        report "stimulus process finished";
        wait;
        
    end process p_stimulus;
        
        
end Behavioral;
