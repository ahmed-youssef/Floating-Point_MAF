library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Is_comp is
  Port (  sign_A 		   : in  STD_LOGIC;
		      sign_B 		   : in  STD_LOGIC;
		      sign_C      : in  STD_LOGIC;
		      sign_AB_int : out STD_LOGIC;
		      sign_C_int  : out STD_LOGIC;
		      comp        : out STD_LOGIC
	);
end Is_comp;

architecture Behavioral of Is_comp is
signal sign_AB : STD_LOGIC;
begin
  sign_AB <= sign_A xor sign_B;
  comp <= sign_AB xor sign_C;
  
  sign_AB_int <= sign_AB;
  sign_C_int <= sign_C; 
  
end Behavioral;