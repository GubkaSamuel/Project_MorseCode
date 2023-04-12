----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan T?žký
-- 
-- Create Date: 04/05/2023 02:24:02 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port (
    CLK100MHZ : in std_logic; --hlavní clock
    LED       : out   std_logic; --dioda indikace stla?ení
    SW        : in std_logic_vector(5 downto 0); --p?epína?e pro ur?ení písmene (26 písmen => 2^5) + p?epína? režimu (p?íjem/vysílání morse) 
    CA        : out   std_logic;                     --! Cathod A
    CB        : out   std_logic;                     --! Cathod B
    CC        : out   std_logic;                     --! Cathod C
    CD        : out   std_logic;                     --! Cathod D
    CE        : out   std_logic;                     --! Cathod E
    CF        : out   std_logic;                     --! Cathod F
    CG        : out   std_logic;                     --! Cathod G
    AN        : out   std_logic_vector(7 downto 0);  --! Common anode signals to individual displays
    BTNC      : in    std_logic;                     --! Synchronous reset
    BTNU      : in    std_logic;                     --! tlacitko pro zmenu pismene nahoru
    BTND      : in    std_logic;                     --! tlacitko pro zmenu pismene dolu
    BTNR      : in    std_logic                      --! enter pro odeslani
    
    
     );
end top;

architecture Behavioral of top is

signal sig_clk_en : std_logic;

begin
clk_enable : entity work.clock_enable
    generic map (
      g_MAX => 1000000000
    )
    port map (
      clk => CLK100MHZ,
      rst => BTNC,
      ce  => sig_clk_en
    );

end Behavioral;
