library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity adder is
  Port (  m_C     	   : in  STD_LOGIC_VECTOR (74 downto 0);
		      mult_result : in  STD_LOGIC_VECTOR (47 downto 0);
		      comp_add    : out STD_LOGIC;
		      add_result  : out STD_LOGIC_VECTOR (73 downto 0)
	);
end adder;

architecture Behavioral of adder is
signal add_result_i, add_result_c, mult_result_i : STD_LOGIC_VECTOR (74 downto 0) := (others=>'0');
begin
  mult_result_i(47 downto 0) <= mult_result;
  add_result_i <= STD_LOGIC_VECTOR(signed(m_C) + signed(mult_result_i));
  add_result_c <= STD_LOGIC_VECTOR(signed(not(add_result_i)) + 1); -- complement adder result
  comp_add <= add_result_i(74);
  add_result <= add_result_i(73 downto 0) when (add_result_i(74) = '0') else add_result_c(73 downto 0);
end Behavioral;