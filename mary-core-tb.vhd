--test bench for mary core!! =)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myCore_tb is 
end entity myCore_tb;

architecture behavior of myCore_tb is
	component myCore_tb is
	port(
		signal clk : std_logic := '0';
		signal volt_in : std_logic_vector(13 downto 0) := (others => '0');
		signal volt_out : std_logic_vector(13 downto 0);
		signal new_out : std_logic_vector(27 downto 0);
		);
	end component myCore_tb;

	signal clk : std_logic := '0';
	signal volt_in : std_logic_vector(13 downto 0) := (others => '0');
	signal volt_out : std_logic_vector(13 downto 0);
	signal new_out : std_logic_vector(27 downto 0);

	signal increment : integer := 0;

	--clock
	constant Clk_period : time := 10 ns;
	signal Clk : std_logic := '1';

begin

DUT: entity work.myCore
	port map (
		clk => Clk,
		volt_in => volt_in,
		volt_out => volt_out,
		new_out => new_out

	);
	Clk <= not Clk after Clk_period/2;

	WaveGen_proc : process
	begin
		volt_in <= std_logic_vector(to_signed(300+2*increment, 14));
		wait until Clk = '1';
	end process WaveGen_proc;

	increment_proc: process is
  	begin
    	wait for Clk_period;
    	increment <= increment + 1;
  	end process increment_proc;

end architecture behavior;

configuration myCore_tb_behavior_cfg of myCore_tb is 
	for behavior
	end for;
end myCore_tb_behavior_cfg;
