--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:22:23 11/16/2023
-- Design Name:   
-- Module Name:   /home/sl/csdblab1/teste_alarm.vhd
-- Project Name:  csdblab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Alarm
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
 
ENTITY teste_alarm IS
END teste_alarm;
 
ARCHITECTURE behavior OF teste_alarm IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alarm
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         incSecAlarm : IN  std_logic;
         incMinAlarm : IN  std_logic;
         incHourAlarm : IN  std_logic;
         buttonSTOP : IN  std_logic;
         switchALARM : IN  std_logic;
         c_seg_u : IN  std_logic_vector(3 downto 0);
         c_seg_d : IN  std_logic_vector(3 downto 0);
         c_min_u : IN  std_logic_vector(3 downto 0);
         c_min_d : IN  std_logic_vector(3 downto 0);
         c_hour_u : IN  std_logic_vector(3 downto 0);
         c_hour_d : IN  std_logic_vector(3 downto 0);
         a_seg_u : OUT  std_logic_vector(3 downto 0);
         a_seg_d : OUT  std_logic_vector(3 downto 0);
         a_min_u : OUT  std_logic_vector(3 downto 0);
         a_min_d : OUT  std_logic_vector(3 downto 0);
         a_hour_u : OUT  std_logic_vector(3 downto 0);
         a_hour_d : OUT  std_logic_vector(3 downto 0);
         alarmIsRunning : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal incSecAlarm : std_logic := '0';
   signal incMinAlarm : std_logic := '0';
   signal incHourAlarm : std_logic := '0';
   signal buttonSTOP : std_logic := '0';
   signal switchALARM : std_logic := '0';
   signal c_seg_u : std_logic_vector(3 downto 0) := (others => '0');
   signal c_seg_d : std_logic_vector(3 downto 0) := (others => '0');
   signal c_min_u : std_logic_vector(3 downto 0) := (others => '0');
   signal c_min_d : std_logic_vector(3 downto 0) := (others => '0');
   signal c_hour_u : std_logic_vector(3 downto 0) := (others => '0');
   signal c_hour_d : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal a_seg_u : std_logic_vector(3 downto 0);
   signal a_seg_d : std_logic_vector(3 downto 0);
   signal a_min_u : std_logic_vector(3 downto 0);
   signal a_min_d : std_logic_vector(3 downto 0);
   signal a_hour_u : std_logic_vector(3 downto 0);
   signal a_hour_d : std_logic_vector(3 downto 0);
   signal alarmIsRunning : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alarm PORT MAP (
          clk => clk,
          reset => reset,
          incSecAlarm => incSecAlarm,
          incMinAlarm => incMinAlarm,
          incHourAlarm => incHourAlarm,
          buttonSTOP => buttonSTOP,
          switchALARM => switchALARM,
          c_seg_u => c_seg_u,
          c_seg_d => c_seg_d,
          c_min_u => c_min_u,
          c_min_d => c_min_d,
          c_hour_u => c_hour_u,
          c_hour_d => c_hour_d,
          a_seg_u => a_seg_u,
          a_seg_d => a_seg_d,
          a_min_u => a_min_u,
          a_min_d => a_min_d,
          a_hour_u => a_hour_u,
          a_hour_d => a_hour_d,
          alarmIsRunning => alarmIsRunning
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
		switchAlarm <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;

      wait for clk_period*10;

      -- insert stimulus here
		incSecAlarm <= '1';
		wait for clk_period*10;
		incSecAlarm <= '0';
		switchAlarm <= '0';	
		wait for clk_period*10;
		c_seg_u <= a_seg_u;
      c_seg_d <= a_seg_d;
		wait for clk_period*10;

      wait;
   end process;

END;
