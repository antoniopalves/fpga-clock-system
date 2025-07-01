----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:25:32 11/14/2023 
-- Design Name: 
-- Module Name:    Mode_State_Machine - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mode_State_Machine is
    Port ( 
			clk : in  STD_LOGIC ;
			buttonTYPEMODE : in STD_LOGIC ; 
			mode : out STD_LOGIC_VECTOR(1 DOWNTO 0) 
			);
	 end Mode_State_Machine;
	 
	 architecture Behavioral of Mode_State_Machine is
	--Use descriptive names for the states, like st1_reset, st2_search
	type state_type is (watch, alarm, timer, stopwatch); --
	signal state, next_state : state_type; 
	
	--Declare internal signals for all outputs of the state-machine
	signal mode_i : std_logic_vector(1 downto 0); 
	
	--signal mode_aux : integer range 0 to 2;

begin

SYNC_PROC: process (clk)
   begin
      if (clk'event and clk = '1') then
            state <= next_state;	
				--mode_i <= std_logic_vector(to_unsigned(mode_aux,mode_i'length));
            mode <= mode_i;
         -- assign other outputs to internal signals
      end if;
   end process;
 
   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state)
   begin
      --insert statements to decode internal output signals
      --below is simple example
      if state = watch then
      else
      end if;
   end process;
 
   NEXT_STATE_DECODE: process (state, buttonTYPEMODE)
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
         when watch =>
				mode_i <= "00";
            if buttonTYPEMODE = '1' then
               next_state <= alarm;
				else
					next_state <= watch;
            end if;
         when alarm =>
				mode_i <= "01";
            if buttonTYPEMODE = '1' then
               next_state <= timer;
				else 
					next_state <= alarm;
            end if;
         when timer =>
				mode_i <= "10";
				if buttonTYPEMODE = '1' then
               next_state <= stopwatch;
				else
					next_state <= timer;
            end if;
			when stopwatch =>
				mode_i <= "11";
				if buttonTYPEMODE = '1' then
               next_state <= watch;
				else
					next_state <= stopwatch;
            end if;
         when others =>
            next_state <= watch;
      end case;      
   end process;


end Behavioral;

