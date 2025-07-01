----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:12 11/02/2023 
-- Design Name: 
-- Module Name:    State_machine - Behavioral 
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

entity State_machine is
--Insert the following in the architecture before the begin keyword
	Port (
		clk : in std_logic;
		reset : in std_logic;
		switchEDIT : in std_logic;
		switchTIMER : in std_logic;
		switchALARM : in std_logic;
		buttonMODE : in std_logic;
		buttonINC : in std_logic;
		incSec : out std_logic;
		incMin : out std_logic;
		incHour : out std_logic;
		incSecAlarm : out std_logic;
		incMinAlarm : out std_logic;
		incHourAlarm : out std_logic;
		incSecTimer : out std_logic;
		incMinTimer : out std_logic
	);
	end State_machine;
	
	architecture Behavioral of State_machine is

   --Use descriptive names for the states, like st1_reset, st2_search
   type state_type is (	st0_idle, st1_seconds, st2_minutes, st3_hours, st4_incsec, st5_incmin, st6_inchour, 
								secAlarm, minAlarm, hourAlarm, SincSecAlarm, SincMinAlarm, SincHourAlarm,
								secTimer, minTimer, SincSecTimer, SincMinTimer); 
   signal state, next_state : state_type; 

   --Declare internal signals for all outputs of the state-machine
   signal incSec_i : std_logic;
   signal incMin_i : std_logic;
   signal incHour_i : std_logic;
	
	signal incSecAlarm_i : std_logic;
   signal incMinAlarm_i : std_logic;
   signal incHourAlarm_i : std_logic;
	
	signal incSecTimer_i : std_logic;
   signal incMinTimer_i : std_logic;
   
	--other outputs
begin

SYNC_PROC: process (clk)
   begin
      if (clk'event and clk = '1') then
         if (reset = '1') then
            state <= st0_idle;
            incSec <= '0';
            incMin <= '0';
            incHour <= '0';
				incSecAlarm <= '0';
            incMinAlarm <= '0';
            incHourAlarm <= '0';
				incSecTimer <= '0';
            incMinTimer <= '0';
         else
            state <= next_state;
            incSec <= incSec_i;
            incMin <= incMin_i;
            incHour <= incHour_i;
				incSecAlarm <= incSecAlarm_i;
            incMinAlarm <= incMinAlarm_i;
            incHourAlarm <= incHourAlarm_i;
				incSecTimer <= incSecTimer_i;
            incMinTimer <= incMinTimer_i;
         -- assign other outputs to internal signals
         end if;        
      end if;
   end process;
 
   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state)
   begin
      --insert statements to decode internal output signals
      --below is simple example
      if state = st3_hours then
      else
      end if;
   end process;
 
   NEXT_STATE_DECODE: process (state, buttonMODE, switchEDIT, switchALARM, switchTIMER, buttonINC)
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  
      case (state) is
			when st0_idle =>
				if switchEDIT = '1' then
					next_state <= st1_seconds;
				elsif switchALARM = '1' then
					next_state <= secAlarm;
				elsif switchTIMER = '1' then
					next_state <= secTimer;
				else 
					next_state <=st0_idle;
				end if;
				
			-- WATCH STATE MACHINE PART -- 	
         when st1_seconds =>
				if switchEDIT = '0' then
					next_state <= st0_idle;
				elsif buttonINC = '1' then
					next_state <= st4_incsec;
            elsif buttonMODE = '1' then
               next_state <= st2_minutes;
				else 
					next_state <=st1_seconds;
            end if;
				
         when st2_minutes =>
				if switchEDIT = '0' then
					next_state <= st0_idle;
				elsif buttonINC = '1' then
					next_state <= st5_incmin;
            elsif buttonMODE = '1' then
               next_state <= st3_hours;
					else 
					next_state <=st2_minutes;
            end if;
				
         when st3_hours =>
				if switchEDIT = '0' then
					next_state <= st0_idle;
				elsif buttonINC = '1' then
					next_state <= st6_inchour;
            elsif buttonMODE = '1' then
					next_state <= st1_seconds;
					else 
					next_state <=st3_hours;
				end if;
			
			when st4_incsec =>
				if buttonINC = '0' then
					next_state <= st1_seconds;
					else 
					next_state <=st4_incsec;
				end if;
				
			when st5_incmin =>
				if buttonINC = '0' then
					next_state <= st2_minutes;
					else 
					next_state <=st5_incmin;
				end if;
				
			when st6_inchour =>
				if buttonINC = '0' then
					next_state <= st3_hours;
					else 
					next_state <=st6_inchour;
				end if;
				
			-- ALARM STATE MACHINE PART --
			when secAlarm => 
				if switchALARM = '0' then
					next_state <= st0_idle;
				elsif buttonINC = '1' then
					next_state <= SincSecAlarm;
            elsif buttonMODE = '1' then
					next_state <= minAlarm;
					else 
					next_state <=secAlarm;
				end if;
				
			when minAlarm => 
				if switchALARM = '0' then
					next_state <= st0_idle;
				elsif buttonINC = '1' then
					next_state <= SincMinAlarm;
            elsif buttonMODE = '1' then
					next_state <= hourAlarm;
					else 
					next_state <=minAlarm;
				end if;
				
			when hourAlarm => 
				if switchALARM = '0' then
					next_state <= st0_idle;
				elsif buttonINC = '1' then
					next_state <= SincHourAlarm;
            elsif buttonMODE = '1' then
					next_state <= secAlarm;
					else 
					next_state <=hourAlarm;
				end if;	
			
			when SincSecAlarm =>
				if buttonINC = '0' then
					next_state <= secAlarm;
					else 
					next_state <=SincSecAlarm;
				end if;
				
			when SincMinAlarm =>
				if buttonINC = '0' then
					next_state <= minAlarm;
					else 
					next_state <=SincMinAlarm;
				end if;
				
			when SincHourAlarm =>
				if buttonINC = '0' then
					next_state <= hourAlarm;
					else 
					next_state <=SincHourAlarm;
				end if;
			
			-- TIMER STATE MACHINE PART -- 	
         when secTimer =>
				if switchTIMER = '0' then
					next_state <= st0_idle;
				elsif buttonINC = '1' then
					next_state <= SincSecTimer;
            elsif buttonMODE = '1' then
               next_state <= minTimer;
				else 
					next_state <=secTimer;
            end if;
				
         when minTimer =>
				if switchTIMER = '0' then
					next_state <= st0_idle;
				elsif buttonINC = '1' then
					next_state <= SincMinTimer;
            elsif buttonMODE = '1' then
               next_state <= secTimer;
				else 
					next_state <= minTimer;
            end if;
			
			when SincSecTimer =>
				if buttonINC = '0' then
					next_state <= secTimer;
				else 
					next_state <= SincSecTimer;
				end if;
				
			when SincMinTimer =>
				if buttonINC = '0' then
					next_state <= minTimer;
				else 
					next_state <=SincMinTimer;
				end if;
			
         when others =>
            next_state <= st0_idle;
      end case;      
   end process;

incSec_i <= '1' when (state = st1_seconds and buttonINC = '1') else '0';
incMin_i <= '1' when (state = st2_minutes and buttonINC = '1') else '0';
incHour_i <= '1' when (state = st3_hours and buttonINC = '1') else '0';

incSecAlarm_i <= '1' when (state = secAlarm and buttonINC = '1') else '0';
incMinAlarm_i <= '1' when (state = minAlarm and buttonINC = '1') else '0';
incHourAlarm_i <= '1' when (state = hourAlarm and buttonINC = '1') else '0';

incSecTimer_i <= '1' when (state = secTimer and buttonINC = '1') else '0';
incMinTimer_i <= '1' when (state = minTimer and buttonINC = '1') else '0';

end Behavioral;

