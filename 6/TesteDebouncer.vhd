--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:29:48 11/19/2023
-- Design Name:   
-- Module Name:   /home/sl/Desktop/csdlab1_V3/TesteDebouncer.vhd
-- Project Name:  csdblab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Debouncer
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
 
ENTITY TesteDebouncer IS
END TesteDebouncer;
 
ARCHITECTURE behavior OF TesteDebouncer IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Debouncer
    PORT(
         clk : IN  std_logic;
         buttonIn : IN  std_logic;
         buttonOut : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal buttonIn : std_logic := '0';

 	--Outputs
   signal buttonOut : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Debouncer PORT MAP (
          clk => clk,
          buttonIn => buttonIn,
          buttonOut => buttonOut
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
		buttonIn <= '1';

      wait;
   end process;

END;
