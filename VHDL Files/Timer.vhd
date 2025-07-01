----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:22 11/17/2023 
-- Design Name: 
-- Module Name:    Timer - Behavioral 
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

entity Timer is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  switchTimer : in std_logic;
			  incSecTimer : in std_logic;
			  incMinTimer : in std_logic;
           t_seg_u : out std_logic_vector(3 downto 0);
           t_seg_d : out std_logic_vector(3 downto 0);
           t_min_u : out std_logic_vector(3 downto 0);
           t_min_d : out std_logic_vector(3 downto 0);
			  seg_u_aux : in std_logic;
			  timerFinished : out std_logic
			  );
end Timer;

architecture Behavioral of Timer is

signal cont_seg_u, cont_min_u: integer range 0 to 9;
signal cont_seg_d, cont_min_d: integer range 0 to 9;
signal iseg_d, imin_d, dseg_d, dmin_u, dmin_d, timerFinished_aux : std_logic;

begin

-------------------- RUNNING TIMER ---------------------

process(clk, cont_seg_u, cont_min_u, cont_seg_d, cont_min_d)
	begin
		if(cont_seg_u = 0 and cont_seg_d = 0 and cont_min_u = 0 and cont_min_d = 0) then
			timerFinished_aux <= '1';
		else 
			timerFinished_aux <= '0';
		end if;
end process;

timerFinished <= timerFinished_aux;

---------------------- EDIT TIMER ----------------------

process (clk, reset)
	begin
		if reset = '1' then
		 cont_seg_u <= 0;
		 
		elsif clk'event and clk = '1' then
		-- ACERTO DOS SEGUNDOS UNIDADES --
		 if incSecTimer = '1' then
			if cont_seg_u = 9 then
			  cont_seg_u <= 0;
			else cont_seg_u <= cont_seg_u + 1;
			end if;
			
		-- TIMER A DECREMENTAR -- 
		 elsif seg_u_aux = '1' and timerFinished_aux = '0' and switchTimer = '0' then
			if cont_seg_u = 0 then
			  cont_seg_u <= 9;
			else cont_seg_u <= cont_seg_u - 1;
			end if;
		 end if;
	  end if;
	  
end process;

iseg_d <= '1' when cont_seg_u = 9 and incSecTimer = '1' else '0';
dseg_d <= '1' when (cont_seg_u = 0 and timerFinished_aux = '0' and switchTimer = '0' and (cont_seg_d > 0 or cont_min_u > 0 or cont_min_d > 0)) else '0';
t_seg_u <= std_logic_vector(to_unsigned(cont_seg_u,t_seg_u'length));

process (clk, reset)
	begin
	  if reset = '1' then
		 cont_seg_d <= 0;
	  elsif clk'event and clk = '1' then
		 if iseg_d = '1' then
			if cont_seg_d = 5 then
			  cont_seg_d <= 0;
			else cont_seg_d <= cont_seg_d + 1;
			end if;
		 elsif seg_u_aux = '1' and dseg_d = '1' then
			if cont_seg_d = 0 then
			  cont_seg_d <= 5;
			else cont_seg_d <= cont_seg_d - 1;
			end if;
		 end if;
	  end if;
end process;

dmin_u <= '1' when ((cont_seg_d = 0 and cont_seg_u = 0) and timerFinished_aux = '0' and switchTimer = '0' and (cont_min_u > 0 or cont_min_d > 0)) else '0';
t_seg_d <= std_logic_vector(to_unsigned(cont_seg_d,t_seg_d'length));

process (clk, reset)
	begin
	  if reset = '1' then
		 cont_min_u <= 0;
	  elsif clk'event and clk = '1' then
		 if incMinTimer = '1' then
			if cont_min_u = 9 then
			  cont_min_u <= 0;
			else cont_min_u <= cont_min_u + 1;
			end if;
		 elsif seg_u_aux = '1' and dmin_u = '1' then
			if cont_min_u = 0 then
			  cont_min_u <= 9;
			else cont_min_u <= cont_min_u - 1;
			end if;
		 end if;
	  end if;
end process;

imin_d <= '1' when cont_min_u = 9 and incMinTimer = '1' else '0';
dmin_d <= '1' when ((cont_min_u = 0 and cont_seg_d = 0 and cont_seg_u = 0) and timerFinished_aux = '0' and switchTimer = '0' and cont_min_d > 0) else '0';
t_min_u <= std_logic_vector(to_unsigned(cont_min_u,t_min_u'length));

process (clk, reset)
	begin
	  if reset = '1' then
		 cont_min_d <= 0;
	  elsif clk'event and clk = '1' then
		 if imin_d = '1' then
			if cont_min_d = 5 then
			  cont_min_d <= 0;
			else cont_min_d <= cont_min_d + 1;
			end if;
		 elsif seg_u_aux = '1' and dmin_d = '1' then
			if cont_min_d = 0 then
			  cont_min_d <= 5;
			else cont_min_d <= cont_min_d - 1;
			end if;
		 end if;
	  end if;
end process;

t_min_d <= std_logic_vector(to_unsigned(cont_min_d,t_min_d'length));

end Behavioral;

