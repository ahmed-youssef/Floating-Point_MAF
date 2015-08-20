library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity LZD is
  Port ( add_result : in  STD_LOGIC_VECTOR (73 downto 0);
         LZN        : out STD_LOGIC_VECTOR (6 downto 0)
	);
end LZD;

architecture Behavioral of LZD is
begin
  
LZN <=  "0000000" when add_result(73) = '1' else
				"0000001" when add_result(72) = '1' else
				"0000010" when add_result(71) = '1' else
				"0000011" when add_result(70) = '1' else
				"0000100" when add_result(69) = '1' else
				"0000101" when add_result(68) = '1' else
				"0000110" when add_result(67) = '1' else
				"0000111" when add_result(66) = '1' else
				"0001000" when add_result(65) = '1' else
				"0001001" when add_result(64) = '1' else
				"0001010" when add_result(63) = '1' else
				"0001011" when add_result(62) = '1' else
				"0001100" when add_result(61) = '1' else
				"0001101" when add_result(60) = '1' else
				"0001110" when add_result(59) = '1' else
				"0001111" when add_result(58) = '1' else
				"0010000" when add_result(57) = '1' else
				"0010001" when add_result(56) = '1' else
				"0010010" when add_result(55) = '1' else
				"0010011" when add_result(54) = '1' else
				"0010100" when add_result(53) = '1' else
				"0010101" when add_result(52) = '1' else
				"0010110" when add_result(51) = '1' else
				"0010111" when add_result(50) = '1' else
				"0011000" when add_result(49) = '1' else
				"0011001" when add_result(48) = '1' else
				"0011010" when add_result(47) = '1' else
				"0011011" when add_result(46) = '1' else
				"0011100" when add_result(45) = '1' else
				"0011101" when add_result(44) = '1' else
				"0011110" when add_result(43) = '1' else
				"0011111" when add_result(42) = '1' else
				"0100000" when add_result(41) = '1' else
				"0100001" when add_result(40) = '1' else
				"0100010" when add_result(39) = '1' else
				"0100011" when add_result(38) = '1' else
				"0100100" when add_result(37) = '1' else
				"0100101" when add_result(36) = '1' else
				"0100110" when add_result(35) = '1' else
				"0100111" when add_result(34) = '1' else
				"0101000" when add_result(33) = '1' else
				"0101001" when add_result(32) = '1' else
				"0101010" when add_result(31) = '1' else
				"0101011" when add_result(30) = '1' else
				"0101100" when add_result(29) = '1' else
				"0101101" when add_result(28) = '1' else
				"0101110" when add_result(27) = '1' else
				"0101111" when add_result(26) = '1' else
				"0110000" when add_result(25) = '1' else
				"0110001" when add_result(24) = '1' else
				"0110010" when add_result(23) = '1' else
				"0110011" when add_result(22) = '1' else
				"0110100" when add_result(21) = '1' else
				"0110101" when add_result(20) = '1' else
				"0110110" when add_result(19) = '1' else
				"0110111" when add_result(18) = '1' else
				"0111000" when add_result(17) = '1' else
				"0111001" when add_result(16) = '1' else
				"0111010" when add_result(15) = '1' else
				"0111011" when add_result(14) = '1' else
				"0111100" when add_result(13) = '1' else
				"0111101" when add_result(12) = '1' else
				"0111110" when add_result(11) = '1' else
				"0111111" when add_result(10) = '1' else
				"1000000" when add_result(9) = '1' else
				"1000001" when add_result(8) = '1' else
				"1000010" when add_result(7) = '1' else
				"1000011" when add_result(6) = '1' else
				"1000100" when add_result(5) = '1' else
				"1000101" when add_result(4) = '1' else
				"1000110" when add_result(3) = '1' else
				"1000111" when add_result(2) = '1' else
				"1001000" when add_result(1) = '1' else
				"1001001" when add_result(0) = '1' else
        "1001010";
 
end Behavioral;