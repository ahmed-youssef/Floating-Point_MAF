library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity sign_logic is
  Port (  sign_AB		   : in  STD_LOGIC;
		      sign_C      : in  STD_LOGIC;
		      comp_add    : in  STD_LOGIC;
		      sign_MAF    : out STD_LOGIC
	);
end sign_logic;

architecture Behavioral of sign_logic is

begin
  sign_MAF <= (sign_AB and (not comp_add)) or (sign_C and comp_add); 
end Behavioral;