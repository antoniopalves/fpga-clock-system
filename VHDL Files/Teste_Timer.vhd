--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:46:58 11/18/2023
-- Design Name:   
-- Module Name:   /home/sl/Desktop/csdblab1_1611semWarnings/Teste_Timere.vhd
-- Project Name:  csdblab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Timer
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
 
ENTITY Teste_Timere IS
END Teste_Timere;
 
ARCHITECTURE behavior OF Teste_Timere IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Timer
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         switchTimer : IN  std_logic;
         incSecTimer : IN  std_logic;
         incMinTimer : IN  std_logic;
         t_seg_u : OUT  std_logic_vector(3 downto 0);
         t_seg_d : OUT  std_logic_vector(3 downto 0);
         t_min_u : OUT  std_logic_vector(3 downto 0);
         t_min_d : OUT  std_logic_vector(3 downto 0);
         seg_u_aux : IN  std_logic;
         timerFinished : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal switchTimer : std_logic := '0';
   signal incSecTimer : std_logic := '0';
   signal incMinTimer : std_logic := '0';
   signal seg_u_aux : std_logic := '0';

 	--Outputs
   signal t_seg_u : std_logic_vector(3 downto 0);
   signal t_seg_d : std_logic_vector(3 downto 0);
   signal t_min_u : std_logic_vector(3 downto 0);
   signal t_min_d : std_logic_vector(3 downto 0);
   signal timerFinished : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Timer PORT MAP (
          clk => clk,
          reset => reset,
          switchTimer => switchTimer,
          incSecTimer => incSecTimer,
          incMinTimer => incMinTimer,
          t_seg_u => t_seg_u,
          t_seg_d => t_seg_d,
          t_min_u => t_min_u,
          t_min_d => t_min_d,
          seg_u_aux => seg_u_aux,
          timerFinished => timerFinished
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
		switchTimer <= '1';
		incSecTimer <= '1';
		incMinTimer <= '1';
		wait for clk_period*10;
		incSecTimer <= '0';
		--wait for clk_period;
		incMinTimer <= '0';
		switchTimer <= '0';

      wait;
   end process;
	
	-- Seg update
	seg_u_aux_process :process
   begin
		seg_u_aux <= '0';
		wait for clk_period/2;
		seg_u_aux <= '1';
		wait for clk_period/2;
   end process;

END;
