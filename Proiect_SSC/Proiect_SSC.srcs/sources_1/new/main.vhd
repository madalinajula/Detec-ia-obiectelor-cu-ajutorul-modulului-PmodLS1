----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2020 20:49:54
-- Design Name: 
-- Module Name: main - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PModLS1 is
--  Port ( );
 Port ( Clk : in STD_LOGIC;
        Rst : in STD_LOGIC;
        S : in STD_LOGIC_VECTOR (3 downto 0);      --input
        Q : out STD_LOGIC_VECTOR (3 downto 0);     --output
        LS1 : in STD_LOGIC_VECTOR(1 downto 0);
        An : out STD_LOGIC_VECTOR (7 downto 0);
        Seg : out STD_LOGIC_VECTOR (7 downto 0));
end PModLS1;

architecture Behavioral of PModLS1 is
signal Data:STD_LOGIC_VECTOR(31 downto 0);
signal Count: INTEGER := 0 ;
signal tmp : std_logic_vector(3 downto 0);

signal pulse : std_logic := '0';
signal m : std_logic_vector(3 downto 0);
signal dm : std_logic_vector(3 downto 0);
signal cm : std_logic_vector(3 downto 0);
signal trigger : std_logic;

component Range_Sensor is 
Port ( fpgaClk : in std_logic;
       pulse : in std_logic;
       triggerOut : out std_logic;
       meters : out std_logic_vector(3 downto 0);
       decimeters : out std_logic_vector(3 downto 0);
       centimeters : out std_logic_vector(3 downto 0));
end component;

begin

Sensor : Range_Sensor port map ( fpgaClk => Clk, 
                                 pulse => pulse,
                                 triggerOut => trigger,
                                 meters => m,
                                 decimeters => dm,
                                 centimeters => cm );

process(LS1)
begin 
    Data(1 downto 0) <= LS1;
    Data(4 downto 1) <= cm;
    Data(8 downto 5) <= dm;
    Data(11 downto 8) <= m;
end process;

process(clk,rst)
begin
if rst = '1' then 
    tmp <= "0000";
    else
        if rising_edge(clk) then
            tmp <= s;
        end if;
    end if;
end process;

q <= tmp;


displ7segm: entity WORK.displ7seg port map(
          Clk=>Clk,
          Rst=>Rst,
          Data=>Data,   
          An=>An,  
          Seg=>Seg);


end Behavioral;
