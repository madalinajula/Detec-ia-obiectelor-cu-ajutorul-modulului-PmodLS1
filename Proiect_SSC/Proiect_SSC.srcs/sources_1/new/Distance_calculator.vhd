----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2021 00:42:03
-- Design Name: 
-- Module Name: Distance_calculator - Behavioral
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
use IEEE.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Distance_calculator is
--  Port ( );
    Port  ( clk : in std_logic; 
            rst : in std_logic;
            pulse : in std_logic;
            distance : out std_logic_vector (8 downto 0));
end Distance_calculator;

architecture Behavioral of Distance_calculator is

component Counter is 
   generic(n: positive := 10);
   Port ( clk : in STD_LOGIC;
          enable : in STD_LOGIC;
          reset : in STD_LOGIC;
          q : out STD_LOGIC_VECTOR (n-1 downto 0));
end component;

signal pulse_width : std_logic_vector (21 downto 0);
signal notRst : std_logic;  
begin

notRst <= not rst;

CounterPulse : Counter generic map(22) 
                       port map(clk => clk,
                                enable => pulse,
                                reset => notRst, 
                                q => pulse_width);
                                
process (pulse)
variable result : integer; 
variable multiplier : std_logic_vector (23 downto 0);

begin

if (pulse = '0') then 
  multiplier := pulse_width * "11"; 
  result := to_integer(unsigned(multiplier(23 downto 13)));
    if (result > 458) then 
        distance <= "111111111";
    else 
       distance <= STD_LOGIC_VECTOR(TO_UNSIGNED(result,9));
    end if;
end if;
end process;
end Behavioral;
