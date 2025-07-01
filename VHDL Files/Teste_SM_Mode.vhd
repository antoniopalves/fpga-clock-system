--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:52:13 11/19/2023
-- Design Name:   
-- Module Name:   /home/sl/Desktop/csdblab1_1611semWarnings/Teste_SM_Mode.vhd
-- Project Name:  csdblab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mode_State_Machine
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
 
ENTITY Teste_SM_Mode IS
END Teste_SM_Mode;
 
ARCHITECTURE behavior OF Teste_SM_Mode IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mode_State_Machine
    PORT(
         clk : IN  std_logic;
         buttonTYPEMODE : IN  std_logic;
         mode : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal buttonTYPEMODE : std_logic := '0';

 	--Outputs
   signal mode : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mode_State_Machine PORT MAP (
          clk => clk,
          buttonTYPEMODE => buttonTYPEMODE,
          mode => mode
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
		
		buttonTYPEMODE <= '1';
		wait for clk_period;
		buttonTYPEMODE <= '0';
		wait for clk_period*10;

      wait;
   end process;

END;
