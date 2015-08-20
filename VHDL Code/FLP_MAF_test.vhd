library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FLP_MAF_test is
end entity;

architecture behavioural of FLP_MAF_test is
  component FLP_MAF is
  Port (  A			 : in  STD_LOGIC_VECTOR (31 downto 0);
          B			 : in  STD_LOGIC_VECTOR (31 downto 0);
		  C			 : in  STD_LOGIC_VECTOR (31 downto 0);
		  result_MAF : out STD_LOGIC_VECTOR (31 downto 0)
	);
  end component;
  
  signal A_in, B_in, C_in, result_MAF_out : STD_LOGIC_VECTOR (31 downto 0);
  signal error : std_logic;
begin
  
  test : component FLP_MAF
        port map(A_in, B_in, C_in, result_MAF_out);
          
  process begin
      A_in <= "01000010110010010000000000000000"; -- 100.5
      B_in <= "01000001101000011100001010001111"; -- 20.22
      C_in <= "01000010010011110011001100110011"; -- 51.8
      
      wait for 99 ps;
      
      if(result_MAF_out = "01000101000000100011111010001111") then
        error <= '0';
      else 
        error <= '1';
      end if;
      
      wait for 99 ps;
      
      A_in <= "11000010101101001000000000000000"; -- -90.25
      B_in <= "01000001101000011100001010001111"; -- 20.22
      C_in <= "11000001111111100110011001100110"; -- -31.8
      
      wait for 99 ps;
      
      if(result_MAF_out = x"C4E814F5") then
        error <= '0';
      else 
        error <= '1';
      end if;
      
      wait for 99 ps;
      
      A_in <= "01000001010101000111101011100001"; -- 13.28
      B_in <= "01000001011100111000010100011111"; -- 15.22
      C_in <= "11000001111111100110011001100110"; -- -31.8
      
      wait for 99 ps;
      
      if(result_MAF_out = x"432A5254") then
        error <= '0';
      else 
        error <= '1';
      end if;
      
      wait for 99 ps;
      
      
      A_in <= "11000001011101000111101011100001"; -- -15.28
      B_in <= "01000001001100111000010100011111"; -- 11.22
      C_in <= "01000001101011000000000000000000"; -- 21.5
      
      wait for 99 ps;
      
      if(result_MAF_out = x"C315F10C") then
        error <= '0';
      else 
        error <= '1';
      end if;
      
      wait for 99 ps;
      
      A_in <= "01000000101010001111010111000011"; -- 5.28
      B_in <= "00111111100111000010100011110110"; -- 1.22
      C_in <= "01000001101011000000000000000000"; -- 21.5
      
      wait for 99 ps;
      
      if(result_MAF_out = x"41DF8865") then
        error <= '0';
      else 
        error <= '1';
      end if;
      
      wait for 99 ps;
      
      A_in <= "11000000101010001111010111000011"; -- -5.28
      B_in <= "00111111100111000010100011110110"; -- 1.22
      C_in <= "11000001101011000000000000000000"; -- -21.5
      
      wait for 99 ps;
      
      if(result_MAF_out = x"C1DF8865") then
        error <= '0';
      else 
        error <= '1';
      end if;
      
      wait for 99 ps;
      
      A_in <= "00111110100011110101110000101001"; -- 0.28
      B_in <= "00111110011000010100011110101110"; -- 0.22
      C_in <= "11000100011111110110000000000000"; -- -1021.5
      
      wait for 99 ps;
      
      if(result_MAF_out = x"C47F5C0E") then
        error <= '0';
      else 
        error <= '1';
      end if;
      
      wait for 99 ps;
      
      A_in <= "00111111000000000000000000000000"; -- 0.5
      B_in <= "10111110011000010100011110101110"; -- -0.5
      C_in <= "01001001011101000010010000000001"; -- 1000000.06
      
      wait for 99 ps;
      
      if(result_MAF_out = x"497423FF") then
        error <= '0';
      else 
        error <= '1';
      end if;
      
      wait for 99 ps;
      
      wait;
      
    end process;
  end architecture;
      
      
      
      
      