----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.01.2021 14:02:07
-- Design Name: 
-- Module Name: Range_Sensor - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Range_Sensor is
--  Port ( );
  Port ( fpgaClk : in std_logic;
         pulse : in std_logic;
         triggerOut : out std_logic;
         meters : out std_logic_vector(3 downto 0);
         decimeters : out std_logic_vector(3 downto 0);
         centimeters : out std_logic_vector(3 downto 0));
end Range_Sensor;

architecture Behavioral of Range_Sensor is

component Distance_calculator is 
  Port  ( clk : in std_logic; 
            rst : in std_logic;
            pulse : in std_logic;
            distance : out std_logic_vector (8 downto 0));
end component;

component Trigger_generator is 
  Port ( clk : in std_logic; 
         trigger : out std_logic);
end component;

component BCD_converter is 
 Port( input : in std_logic_vector(8 downto 0);
       hundreds : out std_logic_vector(3 downto 0);
       tens : out std_logic_vector(3 downto 0);
       unitss : out std_logic_vector(3 downto 0));
end component;

signal distanceOut : std_logic_vector (8 downto 0);
signal triggOut : std_logic;

begin

trigger_gen : Trigger_generator port map (clk => fpgaClk,
                                          trigger => triggOut);
                                          
pulse_width : Distance_calculator port map ( clk => fpgaClk, 
                                             rst => triggOut,
                                             pulse => pulse,
                                             distance => distanceOut);

BCD_Conv : BCD_Converter port map ( input => distanceOut,
                                         hundreds => meters,
                                         tens => decimeters,
                                         unitss => centimeters);
triggerOut <= triggOut;

end Behavioral;
