library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity align_calc is
	Port ( exp_A 	      : in  STD_LOGIC_VECTOR (7 downto 0);
		     exp_B 	      : in  STD_LOGIC_VECTOR (7 downto 0);
		     exp_C 	      : in  STD_LOGIC_VECTOR (7 downto 0);
		     exp_AB       : out STD_LOGIC_VECTOR (9 downto 0);
		     exp_C_int    : out STD_LOGIC_VECTOR (9 downto 0);
		     shift_amount : out STD_LOGIC_VECTOR (9 downto 0)
		 );
end align_calc;

architecture Behavioral of align_calc is
signal exp_A_i, exp_B_i, exp_C_i, exp_AB_i, shift_amount_i, shift_amount_ii : STD_LOGIC_VECTOR (9 downto 0);
begin
  exp_A_i <= "00" & exp_A;
	exp_B_i <= "00" & exp_B;
	exp_C_i <= "00" & exp_C;
	
	exp_AB_i <= STD_LOGIC_VECTOR(signed(exp_A_i) + signed(exp_B_i) - 100); --expAB = expA + expB - bias(127) + 27
	shift_amount_i <= STD_LOGIC_VECTOR(signed(exp_AB_i) - signed(exp_C_i));
	shift_amount_ii <= shift_amount_i when (shift_amount_i(9) = '0') else (others => '0'); -- if negative, shift amount is zero 
	shift_amount <= "0001001010" when (signed(shift_amount_ii) > 74) else shift_amount_ii; -- if shift amount is greater than 74, then shift amount = 74
	
	exp_AB <= exp_AB_i when (exp_AB_i(9) = '0') else "0000000000";
	exp_C_int <= exp_C_i;
end Behavioral;