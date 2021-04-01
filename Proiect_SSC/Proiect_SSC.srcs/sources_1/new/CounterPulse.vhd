----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2020  00:09:58
-- Design Name: 
-- Module Name: CounterPulse - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
 generic (n : positive :=10);
--  Port ( );
 Port ( clk : in STD_LOGIC;
        enable : in STD_LOGIC;
        reset : in STD_LOGIC;
        q : out STD_LOGIC_VECTOR (n-1 downto 0));
end Counter;

architecture Behavioral of Counter is
signal count : STD_LOGIC_VECTOR (n-1 downto 0);
begin

process (clk,reset)
begin 
 if (reset = '0') then 
    count <= (others => '0');
    elsif (clk'event and clk='1') then 
      if (enable = '1') then 
       count <= count + 1;
     end if;
  end if;
end process;
q <= count;
end Behavioral;
