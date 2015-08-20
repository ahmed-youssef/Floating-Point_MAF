library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity mantissa_multiply is
	Port ( mantissa_A  	: in  STD_LOGIC_VECTOR (23 downto 0);
		     mantissa_B 	 : in  STD_LOGIC_VECTOR (23 downto 0);
		     mult_result  : out STD_LOGIC_VECTOR (47 downto 0)
		);
end mantissa_multiply;

architecture Behavioral of mantissa_multiply is

begin
	mult_result <= STD_LOGIC_VECTOR(unsigned(mantissa_A) * unsigned(mantissa_B));
end Behavioral;