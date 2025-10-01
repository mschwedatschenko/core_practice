library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myCore is 
	port(
		clk : in std_logic; --clock input 
		volt_in : in std_logic_vector(13 downto 0); --example input
		volt_out : out std_logic_vector(13 downto 0); -- bit truncated output
		new_out : out std_logic_vector(27 downto 0); -- not truncated output
		);

end entity myCore;

architecture behavior of myCore is

signal dummy_int : integer:=8;

--14 bit register
signal dummy_stdVec : std_logic_vector(13 downto 0) := (others => '0');

--28 bit register
signal dummy_volt : std_logic_vector(27 downto 0);

begin --begins the architecture behavior

--truncate
volt_out <= dummy_volt (13 downto 0);

--connects 1 bit of the dummy volt to an led
--led <= dummy_volt(20);

--scale process updates dummy stdvec every clock cycle
scale_proc : process(clk) is
	begin --begins the process
		if rising_edge(clk) then -- if clock edge rising (increasing)

		--multiplies volt in by stdvec and adds int
		dummy_stdVec<=std_logic_vector(signed(volt_in)*signed(dummy_stdVec)+to_signed(dummy_int,14));
		end if;
	end process scale_proc;

--math process updates dummyvolt each clock cycle
math_proc : process(clk) is 
begin -- begins the process
	if rising_edge(clk) then
		dummy_volt<= std_logic_vector(signed(volt_in)*signed(dummy_stdVec)+to_signed(dummy_int,27));
		
		--converts dummy volt to the untruncated value for the fpga
		new_out <= dummy_volt;
	end if;
end process;

	
end architecture behavior;