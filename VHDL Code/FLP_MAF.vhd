library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FLP_MAF is
  Port (  A			 : in  STD_LOGIC_VECTOR (31 downto 0);
          B			 : in  STD_LOGIC_VECTOR (31 downto 0);
		  C			 : in  STD_LOGIC_VECTOR (31 downto 0);
		  result_MAF : out STD_LOGIC_VECTOR (31 downto 0)
	);
end FLP_MAF;

architecture Behavioral of FLP_MAF is
	
	component Is_comp is
	Port (    sign_A 	  : in  STD_LOGIC;
		      sign_B 	  : in  STD_LOGIC;
		      sign_C      : in  STD_LOGIC;
		      sign_AB_int : out STD_LOGIC;
		      sign_C_int  : out STD_LOGIC;
		      comp        : out STD_LOGIC
	);
	end component;
	
	component align_calc is
	Port ( exp_A 	      : in  STD_LOGIC_VECTOR (7 downto 0);
		     exp_B 	      : in  STD_LOGIC_VECTOR (7 downto 0);
		     exp_C 	      : in  STD_LOGIC_VECTOR (7 downto 0);
		     exp_AB       : out STD_LOGIC_VECTOR (9 downto 0);
		     exp_C_int    : out STD_LOGIC_VECTOR (9 downto 0);
		     shift_amount : out STD_LOGIC_VECTOR (9 downto 0)
		 );
	end component;
	
	component align_shifter is
	Port ( mantissa_C     : in  STD_LOGIC_VECTOR (23 downto 0);
		     shift_amount : in  STD_LOGIC_VECTOR (9 downto 0);
		     comp         : in  STD_LOGIC;
		     m_C          : out STD_LOGIC_VECTOR (74 downto 0)
		 );
	end component;
	
	component mantissa_multiply is
	Port ( mantissa_A  	: in  STD_LOGIC_VECTOR (23 downto 0);
		     mantissa_B 	 : in  STD_LOGIC_VECTOR (23 downto 0);
		     mult_result  : out STD_LOGIC_VECTOR (47 downto 0)
		);
	end component;	
	
	component sign_logic is
	Port (  sign_AB		   : in  STD_LOGIC;
		      sign_C      : in  STD_LOGIC;
		      comp_add    : in  STD_LOGIC;
		      sign_MAF    : out STD_LOGIC
	);
	end component;	
	
	component exp_calc is
	Port ( exp_AB       : in  STD_LOGIC_VECTOR (9 downto 0);
		   exp_C_int    : in  STD_LOGIC_VECTOR (9 downto 0);
		   exp_MAF_int  : out STD_LOGIC_VECTOR (9 downto 0)
		 );
	end component;
	
	component adder is
	Port (  m_C     	   : in  STD_LOGIC_VECTOR (74 downto 0);
		      mult_result : in  STD_LOGIC_VECTOR (47 downto 0);
		      comp_add    : out STD_LOGIC;
		      add_result  : out STD_LOGIC_VECTOR (73 downto 0)
	);
	end component;
	
	component exp_adj is
	Port ( exp_MAF_int  : in  STD_LOGIC_VECTOR (9 downto 0);
	       LZN          : in  STD_LOGIC_VECTOR (6 downto 0);
	       exp_MAF      : out STD_LOGIC_VECTOR (7 downto 0)
		 );
	end component;
	
	component LZD is
	Port ( 	add_result : in  STD_LOGIC_VECTOR (73 downto 0);
			LZN        : out STD_LOGIC_VECTOR (6 downto 0)
	);
	end component;
	
	component Normalize is
	Port ( 	add_result   : in  STD_LOGIC_VECTOR (73 downto 0);
			LZN          : in  STD_LOGIC_VECTOR (6 downto 0);
			mantissa_MAF : out STD_LOGIC_VECTOR (22 downto 0)
	);
	end component;
	
	signal mantissa_A_i, mantissa_B_i, mantissa_C_i : STD_LOGIC_VECTOR (23 downto 0);
	signal sign_AB_i, sign_C_i, comp_i, comp_add_i : STD_LOGIC;
	signal LZN_i : STD_LOGIC_VECTOR (6 downto 0);
	signal exp_AB_i, exp_C_i, shift_amount_i, exp_MAF_int_i : STD_LOGIC_VECTOR (9 downto 0);
	signal add_result_i : STD_LOGIC_VECTOR (73 downto 0);
	signal m_C_i : STD_LOGIC_VECTOR (74 downto 0);
	signal mult_result_i : STD_LOGIC_VECTOR (47 downto 0);
	
begin

	mantissa_A_i <= '1' & A(22 downto 0);
	mantissa_B_i <= '1' & B(22 downto 0);
	mantissa_C_i <= '1' & C(22 downto 0);
	
	comp_0: component Is_comp 
	Port map( sign_A 	   => A(31),
		      sign_B 	   => B(31),
		      sign_C       => C(31),
		      sign_AB_int  => sign_AB_i,
		      sign_C_int   => sign_C_i,
		      comp         => comp_i
	);
	
	align_0: component align_calc 
	Port map( exp_A 	   =>  A(30 downto 23),
		     exp_B 	       =>  B(30 downto 23),
		     exp_C 	       =>  C(30 downto 23),
		     exp_AB        =>  exp_AB_i,
		     exp_C_int     =>  exp_C_i,
		     shift_amount  =>  shift_amount_i
		 );

	shift_0: component align_shifter 
	Port map( mantissa_C   => mantissa_C_i,
		     shift_amount  => shift_amount_i,
		     comp          => comp_i,
		     m_C           => m_C_i
		 );	
	
	mult_0: component mantissa_multiply 
	Port map( mantissa_A   => mantissa_A_i,
			  mantissa_B   => mantissa_B_i,
		      mult_result  => mult_result_i
		);
	
	sign_0: component sign_logic 
	Port map( sign_AB	   => sign_AB_i,
		      sign_C       => sign_C_i,
		      comp_add     => comp_add_i,
		      sign_MAF     => result_MAF(31)
	);
		
	exp_00: component exp_calc
	Port map( exp_AB    => exp_AB_i,
		   exp_C_int    => exp_C_i,
		   exp_MAF_int  => exp_MAF_int_i
		 );	
		
	add_00: component adder 
	Port map( m_C     	   => m_C_i,
		      mult_result  => mult_result_i,
		      comp_add     => comp_add_i,
		      add_result   => add_result_i
			);		
						
	eadj_0: component exp_adj 
	Port map( 	exp_MAF_int  => exp_MAF_int_i,
				LZN          => LZN_i,
				exp_MAF      => result_MAF(30 downto 23)
			);
			
	lzd_00: component LZD 
	Port map(add_result => add_result_i,
			 LZN        => LZN_i
			);

	norm_0: component Normalize
	Port map( 	add_result   => add_result_i,
				LZN          => LZN_i,
				mantissa_MAF => result_MAF(22 downto 0)
			);
			
end architecture;
						

	
	