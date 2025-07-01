--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:34:48 11/18/2023
-- Design Name:   
-- Module Name:   /home/sl/Desktop/csdblab1_1611semWarnings/Teste_Principal.vhd
-- Project Name:  csdblab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: principal
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
 
ENTITY Teste_Principal IS
END Teste_Principal;
 
ARCHITECTURE behavior OF Teste_Principal IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT principal
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         algarismo : OUT  std_logic_vector(7 downto 0);
         switch1 : IN  std_logic;
         switchEDIT : IN  std_logic;
         switchTIMER : IN  std_logic;
         switchALARM : IN  std_logic;
         switchStopWatch : IN  std_logic;
         buttonMODE : IN  std_logic;
         buttonTYPEMODE : IN  std_logic;
         buttonINC : IN  std_logic;
         LED_Alarm : OUT  std_logic;
         LED_Timer : OUT  std_logic;
         an3 : OUT  std_logic;
         an2 : OUT  std_logic;
         an1 : OUT  std_logic;
         an0 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal switch1 : std_logic := '0';
   signal switchEDIT : std_logic := '0';
   signal switchTIMER : std_logic := '0';
   signal switchALARM : std_logic := '0';
   signal switchStopWatch : std_logic := '0';
   signal buttonMODE : std_logic := '0';
   signal buttonTYPEMODE : std_logic := '0';
   signal buttonINC : std_logic := '0';

 	--Outputs
   signal algarismo : std_logic_vector(7 downto 0);
   signal LED_Alarm : std_logic;
   signal LED_Timer : std_logic;
   signal an3 : std_logic;
   signal an2 : std_logic;
   signal an1 : std_logic;
   signal an0 : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: principal PORT MAP (
          reset => reset,
          clk => clk,
          algarismo => algarismo,
          switch1 => switch1,
          switchEDIT => switchEDIT,
          switchTIMER => switchTIMER,
          switchALARM => switchALARM,
          switchStopWatch => switchStopWatch,
          buttonMODE => buttonMODE,
          buttonTYPEMODE => buttonTYPEMODE,
          buttonINC => buttonINC,
          LED_Alarm => LED_Alarm,
          LED_Timer => LED_Timer,
          an3 => an3,
          an2 => an2,
          an1 => an1,
          an0 => an0
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

      wait for clk_period*10;

      -- insert stimulus here 
		switch1 <= '1';
		wait for clk_period*10;
		switch1 <= '0';
		wait for clk_period;
		switchEDIT <= '1';
		wait for clk_period;
		buttonINC <= '1';
		wait for clk_period;
		buttonINC <= '0';
		wait for clk_period;
		buttonMODE <= '1';
		wait for clk_period;
		buttonMODE <= '0';
		wait for clk_period;
		buttonINC <= '1';
		wait for clk_period;
		buttonINC <= '0';
		wait for clk_period;
		buttonMODE <= '1';
		wait for clk_period;
		buttonMODE <= '0';
		wait for clk_period;
		buttonINC <= '1';
		wait for clk_period;
		buttonINC <= '0';
		switchEDIT <= '0';
		wait for clk_period*10;
		buttonTYPEMODE <= '1';
		wait for clk_period;
		buttonTYPEMODE <= '0';
		wait for clk_period*10;
		buttonTYPEMODE <= '1';
		wait for clk_period;
		buttonTYPEMODE <= '0';
		wait for clk_period*10;
		buttonTYPEMODE <= '1';
		wait for clk_period;
		buttonTYPEMODE <= '0';
		wait for clk_period*10;
		switchStopWatch <= '1';
		wait for clk_period*3;
		switchStopWatch <= '0';
		buttonTYPEMODE <= '1';
		wait for clk_period;
		buttonTYPEMODE <= '0';

      wait;
   end process;

END;
