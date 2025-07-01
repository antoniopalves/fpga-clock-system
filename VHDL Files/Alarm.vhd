----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:23:16 11/14/2023 
-- Design Name: 
-- Module Name:    Alarm - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Alarm is
    Port ( 	clk : in  std_logic;
				reset : in  std_logic;
				incSecAlarm : in std_logic;
				incMinAlarm : in std_logic;
				incHourAlarm : in std_logic;
				buttonSTOP : in std_logic;
				switchALARM : in std_logic;
				c_seg_u : in std_logic_vector(3 downto 0);
				c_seg_d : in std_logic_vector(3 downto 0);
				c_min_u : in std_logic_vector(3 downto 0);
				c_min_d : in std_logic_vector(3 downto 0);
				c_hour_u : in std_logic_vector(3 downto 0);
				c_hour_d : in std_logic_vector(3 downto 0);
				a_seg_u : out std_logic_vector(3 downto 0);
				a_seg_d : out std_logic_vector(3 downto 0);
				a_min_u : out std_logic_vector(3 downto 0);
				a_min_d : out std_logic_vector(3 downto 0);
				a_hour_u : out std_logic_vector(3 downto 0);
				a_hour_d : out std_logic_vector(3 downto 0);
				alarmIsRunning : out std_logic
			);
end Alarm;

architecture Behavioral of Alarm is

signal cont_seg_u, cont_min_u, cont_hour_u : integer range 0 to 9;
signal cont_seg_d, cont_min_d, cont_hour_d : integer range 0 to 9;
signal c_seg_u_aux, c_seg_d_aux, c_min_u_aux, c_min_d_aux, c_hour_u_aux, c_hour_d_aux : std_logic_vector(3 downto 0);
signal seg_d, min_d, hour_d: std_logic;

begin

--------------------- ALARM IS RUNNING ---------------------
process(clk) 
	begin
	if clk'event and clk = '1' then
		if (switchALARM = '0') then
			if (std_logic_vector(to_unsigned(cont_seg_u,a_seg_u'length)) = c_seg_u_aux and 
										std_logic_vector(to_unsigned(cont_seg_d,a_seg_d'length)) = c_seg_d_aux and 
										std_logic_vector(to_unsigned(cont_min_u,a_min_u'length)) = c_min_u_aux and 
										std_logic_vector(to_unsigned(cont_min_d,a_min_d'length)) = c_min_d_aux and 
										std_logic_vector(to_unsigned(cont_hour_u,a_hour_u'length)) = c_hour_u_aux and 
										std_logic_vector(to_unsigned(cont_hour_d,a_hour_d'length)) = c_hour_d_aux) then
				alarmIsRunning <= '1';
			elsif ((buttonSTOP = '1') or (std_logic_vector(to_unsigned(cont_seg_u,a_seg_u'length)) = c_seg_u_aux and 
										std_logic_vector(to_unsigned(cont_seg_d,a_seg_d'length)) = c_seg_d_aux and 
										std_logic_vector(to_unsigned(cont_min_u,a_min_u'length)) = c_min_u_aux and 
										std_logic_vector(to_unsigned(cont_min_d,a_min_d'length)) = c_min_d_aux and 
										std_logic_vector(to_unsigned(cont_hour_u+1,a_hour_u'length)) = c_hour_u_aux and 
										std_logic_vector(to_unsigned(cont_hour_d,a_hour_d'length)) = c_hour_d_aux)) then
				alarmIsRunning <= '0';
			end if;
		end if;
	end if;	
end process;

--------------------- ALARM EDIT ---------------------
process (clk, reset, incSecAlarm)
	begin
		if reset = '1' then
		 cont_seg_u <= 0;
			
	  elsif clk'event and clk = '1' then
		 if incSecAlarm = '1' then
			if cont_seg_u = 9 then
			  cont_seg_u <= 0;
			else cont_seg_u <= cont_seg_u + 1;
			end if;
		 end if;
	  end if;
	  
end process;

seg_d <= '1' when cont_seg_u = 9 and incSecAlarm = '1' else '0';
a_seg_u <= std_logic_vector(to_unsigned(cont_seg_u,a_seg_u'length));

process (clk, reset)
	begin
	  if reset = '1' then
		 cont_seg_d <= 0;
		 
	  elsif clk'event and clk = '1' then
		 if seg_d = '1' then
			if cont_seg_d = 5 then
			  cont_seg_d <= 0;
			else cont_seg_d <= cont_seg_d + 1;
			end if;
		 end if;
	  end if;
end process;

a_seg_d <= std_logic_vector(to_unsigned(cont_seg_d,a_seg_d'length));


process (clk, reset, incMinAlarm)
	begin
	  if reset = '1' then
		 cont_min_u <= 0;
			 
	  elsif clk'event and clk = '1' then
		 if incMinAlarm = '1' then
			if cont_min_u = 9 then
			  cont_min_u <= 0;
			else cont_min_u <= cont_min_u + 1;
			end if;
		 end if;
	  end if;
end process;

min_d <= '1' when cont_min_u = 9 and incMinAlarm = '1' else '0';
a_min_u <= std_logic_vector(to_unsigned(cont_min_u,a_min_u'length));


process (clk, reset)
	begin
	  if reset = '1' then
		 cont_min_d <= 0;
		 
	  elsif clk'event and clk = '1' then
		 if min_d = '1' then
			if cont_min_d = 5 then
			  cont_min_d <= 0;
			else cont_min_d <= cont_min_d + 1;
			end if;
		 end if;
	  end if;
end process;

a_min_d <= std_logic_vector(to_unsigned(cont_min_d,a_min_d'length));


process (clk, reset, incHourAlarm)
	begin
	  if reset = '1' then
		 cont_hour_u <= 0;
			 
	  elsif clk'event and clk = '1' then
		 if incHourAlarm = '1' then
			if cont_hour_d = 2 and cont_hour_u = 3 then
				cont_hour_u <=0;
			elsif cont_hour_u = 9 then
			  cont_hour_u <= 0;
			else cont_hour_u <= cont_hour_u + 1;
			end if;
		 end if;
	  end if;
end process;

hour_d <= '1' when (cont_hour_u = 9 or (cont_hour_u = 3 and cont_hour_d = 2)) and incHourAlarm = '1' else '0'; --or (cont_hour_u = 3 and cont_hour_d = 2)) 
a_hour_u <= std_logic_vector(to_unsigned(cont_hour_u,a_hour_u'length));


process (clk, reset)
	begin
	  if reset = '1' then
		 cont_hour_d <= 0;
		 
	  elsif clk'event and clk = '1' then
		 if hour_d = '1' then
			if cont_hour_d = 2 and cont_hour_u = 3 then
			  cont_hour_d <= 0;
			else cont_hour_d <= cont_hour_d + 1;
			end if;
		 end if;
	  end if;
end process;

a_hour_d <= std_logic_vector(to_unsigned(cont_hour_d,a_hour_d'length));


process(clk)
	begin
	if(clk'event and clk = '1') then
		c_hour_d_aux <= c_hour_d;
		c_hour_u_aux <= c_hour_u;
		c_min_d_aux <= c_min_d;
		c_min_u_aux <= c_min_u;
		c_seg_d_aux <= c_seg_d;
		c_seg_u_aux <= c_seg_u;
	end if;
end process;

end Behavioral;

