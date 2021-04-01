----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2021 13:36:08
-- Design Name: 
-- Module Name: BCD_converter - Behavioral
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

entity BCD_converter is
--  Port ( );
  Port( input : in std_logic_vector(8 downto 0);
        hundreds : out std_logic_vector(3 downto 0);
        tens : out std_logic_vector(3 downto 0);
        unitss : out std_logic_vector(3 downto 0));
end BCD_converter;

architecture Behavioral of BCD_converter is

begin

process(input)
variable i : integer := 0;
variable bcd : std_logic_vector(20 downto 0);
begin 
  bcd := (others => '0');
  bcd(8 downto 0) := input;
  
for i in 0 to 8 loop 
  bcd (19 downto 0) := bcd(18 downto 0) & '0';
  if (i < 8 and bcd (12 downto 9) > "0100") then 
    bcd(12 downto 9) := bcd (12 downto 9) + "0011";
  end if;
  if (i < 8 and bcd (16 downto 13) > "0100") then 
    bcd(16 downto 13) := bcd (16 downto 13) + "0011";
  end if;
  if (i < 8 and bcd(20 downto 17) > "0100") then 
      bcd(20 downto 17) := bcd (20 downto 17) + "0011";
   end if;
end loop;  

hundreds <= bcd(20 downto 17);
tens <= bcd(16 downto 13);
unitss <= bcd(12 downto 9);

end process;

end Behavioral;
