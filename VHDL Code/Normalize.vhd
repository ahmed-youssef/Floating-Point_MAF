library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Normalize is
  Port ( add_result   : in  STD_LOGIC_VECTOR (73 downto 0);
         LZN          : in  STD_LOGIC_VECTOR (6 downto 0);
         mantissa_MAF : out STD_LOGIC_VECTOR (22 downto 0)
	);
end Normalize;

architecture Behavioral of Normalize is

signal norm_result : STD_LOGIC_VECTOR (73 downto 0):= (others => '0');
begin
  
  norm_result <= STD_LOGIC_VECTOR(unsigned(add_result) sll to_integer(unsigned(LZN)));
  
  mantissa_MAF <= norm_result(72 downto 50);
  
end Behavioral;