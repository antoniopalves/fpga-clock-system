--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:02:22 11/18/2023
-- Design Name:   
-- Module Name:   /home/sl/Desktop/csdblab1_1611semWarnings/Teste_Relogio.vhd
-- Project Name:  csdblab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: relogio
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
 
ENTITY Teste_Relogio IS
END Teste_Relogio;
 
ARCHITECTURE behavior OF Teste_Relogio IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT relogio
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         switchEDIT : IN  std_logic;
         incSec : IN  std_logic;
         incMin : IN  std_logic;
         incHour : IN  std_logic;
         c_seg_u : OUT  std_logic_vector(3 downto 0);
         c_seg_d : OUT  std_logic_vector(3 downto 0);
         c_min_u : OUT  std_logic_vector(3 downto 0);
         c_min_d : OUT  std_logic_vector(3 downto 0);
         c_hour_u : OUT  std_logic_vector(3 downto 0);
         c_hour_d : OUT  std_logic_vector(3 downto 0);
         seg_u_aux : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal switchEDIT : std_logic := '0';
   signal incSec : std_logic := '0';
   signal incMin : std_logic := '0';
   signal incHour : std_logic := '0';

 	--Outputs
   signal c_seg_u : std_logic_vector(3 downto 0);
   signal c_seg_d : std_logic_vector(3 downto 0);
   signal c_min_u : std_logic_vector(3 downto 0);
   signal c_min_d : std_logic_vector(3 downto 0);
   signal c_hour_u : std_logic_vector(3 downto 0);
   signal c_hour_d : std_logic_vector(3 downto 0);
   signal seg_u_aux : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: relogio PORT MAP (
          clk => clk,
          reset => reset,
          switchEDIT => switchEDIT,
          incSec => incSec,
          incMin => incMin,
          incHour => incHour,
          c_seg_u => c_seg_u,
          c_seg_d => c_seg_d,
          c_min_u => c_min_u,
          c_min_d => c_min_d,
          c_hour_u => c_hour_u,
          c_hour_d => c_hour_d,
          seg_u_aux => seg_u_aux
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
		reset <= '1';
      wait for 100 ns;-- hold reset state for 100 ns.
		reset <= '0';
      wait for clk_period*40;
		switchEDIT <= '1';
		incSec <= '1';
		wait for clk_period*5;
		incSec <= '0';
		incMin <= '1';
		wait for clk_period*2;
		incMin<= '0';
		switchEDIT <= '0';
		wait;
   end process;END;
