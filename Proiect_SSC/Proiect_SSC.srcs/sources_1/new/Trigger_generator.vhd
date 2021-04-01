----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2021 01:18:06
-- Design Name: 
-- Module Name: Trigger_generator - Behavioral
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

entity Trigger_generator is
--  Port ( );
 Port ( clk : in std_logic; 
        trigger : out std_logic);
end Trigger_generator;

architecture Behavioral of Trigger_generator is

component Counter is 
   generic(n: positive := 10);
   Port ( clk : in STD_LOGIC;
          enable : in STD_LOGIC;
          reset : in STD_LOGIC;
          q : out STD_LOGIC_VECTOR (n-1 downto 0));
end component;

signal rstCounter : std_logic; 
signal outCounter : std_logic_vector(23 downto 0);
constant ms250 : std_logic_vector(23 downto 0) := "010111110101111000100000";    
constant ms250And100us : std_logic_vector(23 downto 0) := "101111101100111110101000";
 
begin

Trigg : Counter generic map(24) 
                  port map(clk => clk,
                           enable => '1',
                           reset => rstCounter, 
                           q => outCounter);
                           
process(clk)
 
 begin 
   if (outCounter > ms250 and outCounter < ms250And100us ) then 
     trigger <= '1';
   else 
     trigger <= '0';
   end if;
   if (outCounter = ms250And100us or outCounter = "000000000000000000000000") then 
      rstCounter <= '0';
   else 
      rstCounter <= '1';
   end if;
end process;

end Behavioral;
