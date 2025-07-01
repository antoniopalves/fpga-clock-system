--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:58:12 11/19/2023
-- Design Name:   
-- Module Name:   /home/sl/Desktop/csdblab1_1611semWarnings/Teste_Edit_SM.vhd
-- Project Name:  csdblab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: State_machine
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
 
ENTITY Teste_Edit_SM IS
END Teste_Edit_SM;
 
ARCHITECTURE behavior OF Teste_Edit_SM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT State_machine
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         switchEDIT : IN  std_logic;
         switchTIMER : IN  std_logic;
         switchALARM : IN  std_logic;
         buttonMODE : IN  std_logic;
         buttonINC : IN  std_logic;
         incSec : OUT  std_logic;
         incMin : OUT  std_logic;
         incHour : OUT  std_logic;
         incSecAlarm : OUT  std_logic;
         incMinAlarm : OUT  std_logic;
         incHourAlarm : OUT  std_logic;
         incSecTimer : OUT  std_logic;
         incMinTimer : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal switchEDIT : std_logic := '0';
   signal switchTIMER : std_logic := '0';
   signal switchALARM : std_logic := '0';
   signal buttonMODE : std_logic := '0';
   signal buttonINC : std_logic := '0';

 	--Outputs
   signal incSec : std_logic;
   signal incMin : std_logic;
   signal incHour : std_logic;
   signal incSecAlarm : std_logic;
   signal incMinAlarm : std_logic;
   signal incHourAlarm : std_logic;
   signal incSecTimer : std_logic;
   signal incMinTimer : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: State_machine PORT MAP (
          clk => clk,
          reset => reset,
          switchEDIT => switchEDIT,
          switchTIMER => switchTIMER,
          switchALARM => switchALARM,
          buttonMODE => buttonMODE,
          buttonINC => buttonINC,
          incSec => incSec,
          incMin => incMin,
          incHour => incHour,
          incSecAlarm => incSecAlarm,
          incMinAlarm => incMinAlarm,
          incHourAlarm => incHourAlarm,
          incSecTimer => incSecTimer,
          incMinTimer => incMinTimer
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
		
		wait for clk_period*3;
		
		switchALARM <= '1';
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
		switchALARM <= '0';
		
		wait for clk_period*3;
		
		switchTIMER <= '1';
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
		switchTIMER <= '0';

      wait;
   end process;

END;
