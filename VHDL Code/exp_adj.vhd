library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity exp_adj is
	Port ( exp_MAF_int  : in  STD_LOGIC_VECTOR (9 downto 0);
	       LZN          : in  STD_LOGIC_VECTOR (6 downto 0);
	       exp_MAF      : out STD_LOGIC_VECTOR (7 downto 0)
		 );
end exp_adj;

architecture Behavioral of exp_adj is
signal exp_MAF_i, lzn_i : STD_LOGIC_VECTOR (9 downto 0);
signal overflow  : STD_LOGIC;
begin
  lzn_i <= "000"&lzn;
  exp_MAF_i <= STD_LOGIC_VECTOR(unsigned(exp_MAF_int) - unsigned(LZN_i));
  overflow <= exp_MAF_i(9) or exp_MAF_i(8);
  
  exp_MAF <= exp_MAF_i(7 downto 0) when (overflow = '0') else "11111111";
end Behavioral;