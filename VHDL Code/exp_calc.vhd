library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity exp_calc is
	Port ( exp_AB       : in  STD_LOGIC_VECTOR (9 downto 0);
		     exp_C_int    : in  STD_LOGIC_VECTOR (9 downto 0);
		     exp_MAF_int  : out STD_LOGIC_VECTOR (9 downto 0)
		 );
end exp_calc;

architecture Behavioral of exp_calc is
--signal exp_AB_new : STD_LOGIC_VECTOR (9 downto 0);
begin
  --exp_AB_new <= STD_LOGIC_VECTOR(signed(exp_AB) - 11);
  exp_MAF_int <= exp_C_int when (signed(exp_C_int) > signed(exp_AB)) else exp_AB;
end Behavioral;