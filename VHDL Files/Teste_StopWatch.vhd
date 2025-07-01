--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:09:07 11/18/2023
-- Design Name:   
-- Module Name:   /home/sl/Desktop/csdblab1_1611semWarnings/Teste_StopWatch.vhd
-- Project Name:  csdblab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: StopWatch
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Teste_StopWatch IS
END Teste_StopWatch;
 
ARCHITECTURE behavior OF Teste_StopWatch IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT StopWatch
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         switchStopWatch : IN  std_logic;
         sw_mseg_u : OUT  std_logic_vector(3 downto 0);
         sw_mseg_d : OUT  std_logic_vector(3 downto 0);
         sw_seg_u : OUT  std_logic_vector(3 downto 0);
         sw_seg_d : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal switchStopWatch : std_logic := '0';

 	--Outputs
   signal sw_mseg_u : std_logic_vector(3 downto 0);
   signal sw_mseg_d : std_logic_vector(3 downto 0);
   signal sw_seg_u : std_logic_vector(3 downto 0);
   signal sw_seg_d : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: StopWatch PORT MAP (
          clk => clk,
          reset => reset,
          switchStopWatch => switchStopWatch,
          sw_mseg_u => sw_mseg_u,
          sw_mseg_d => sw_mseg_d,
          sw_seg_u => sw_seg_u,
          sw_seg_d => sw_seg_d
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*40;
		
		switchStopWatch <= '1';
		wait for clk_period*5;
		switchStopWatch <= '0';
		
		wait for clk_period*12;
		
		reset <= '1';
		wait for clk_period;
		reset <= '0';

      wait;
   end process;

END;
