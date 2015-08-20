library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity align_shifter is
	Port ( mantissa_C   : in  STD_LOGIC_VECTOR (23 downto 0);
		     shift_amount : in  STD_LOGIC_VECTOR (9 downto 0);
		     comp         : in  STD_LOGIC;
		     m_C          : out STD_LOGIC_VECTOR (74 downto 0)
		 );
end align_shifter;

architecture Behavioral of align_shifter is
signal m_C_i, m_C_ii : STD_LOGIC_VECTOR (74 downto 0):= (others => '0');
begin

  m_C_i(73 downto 50) <= mantissa_C;
  m_C_ii <= STD_LOGIC_VECTOR(unsigned(M_C_i) srl to_integer(unsigned(shift_amount)));
  
  m_C <= STD_LOGIC_VECTOR(signed(not(m_C_ii)) + 1) when (comp = '1') else m_C_ii;
end Behavioral;