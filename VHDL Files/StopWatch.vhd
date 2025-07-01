----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:38:42 11/17/2023 
-- Design Name: 
-- Module Name:    StopWatch - Behavioral 
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

entity StopWatch is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  switchStopWatch : in std_logic;
           sw_mseg_u : out std_logic_vector(3 downto 0);
           sw_mseg_d : out std_logic_vector(3 downto 0);
           sw_seg_u : out std_logic_vector(3 downto 0);
           sw_seg_d : out std_logic_vector(3 downto 0));
end StopWatch;

architecture Behavioral of StopWatch is

signal cont_msubseg : integer range 0 to 500000;

signal cont_mseg_u, cont_seg_u : integer range 0 to 9;
signal cont_mseg_d, cont_seg_d : integer range 0 to 9;
signal mseg_u, mseg_d, seg_u, seg_d : std_logic;

begin

process (clk, reset)
begin
	if reset = '1' then
    cont_msubseg <= 0;
	elsif clk'event and clk = '1' and switchStopWatch = '0' then
		if cont_msubseg = 4 then--499999 --4
      cont_msubseg <= 0;
		else cont_msubseg <= cont_msubseg + 1;
    end if;
  end if;
end process;

mseg_u <= '1' when cont_msubseg = 4 else '0';--499999 --4

process (clk, reset)
begin
	if reset = '1' then
    cont_mseg_u <= 0;
  elsif clk'event and clk = '1' then
    if mseg_u = '1' then
      if cont_mseg_u = 9 then
        cont_mseg_u <= 0;
      else cont_mseg_u <= cont_mseg_u + 1;
      end if;
    end if;
  end if;
end process;

mseg_d <= '1' when cont_mseg_u = 9 and mseg_u = '1' else '0';
sw_mseg_u <= std_logic_vector(to_unsigned(cont_mseg_u,sw_mseg_u'length));

process (clk, reset)
begin
  if reset = '1' then
    cont_mseg_d <= 0;
  elsif clk'event and clk = '1' then
    if mseg_d = '1' then
      if cont_mseg_d = 9 then
        cont_mseg_d <= 0;
      else cont_mseg_d <= cont_mseg_d + 1;
      end if;
    end if;
  end if;
end process;

seg_u <= '1' when cont_mseg_d = 9 and mseg_d = '1' else '0';
sw_mseg_d <= std_logic_vector(to_unsigned(cont_mseg_d,sw_mseg_d'length));

process (clk, reset)
begin
  if reset = '1' then
    cont_seg_u <= 0;
		 
  elsif clk'event and clk = '1' then
    if seg_u = '1' then
      if cont_seg_u = 9 then
        cont_seg_u <= 0;
      else cont_seg_u <= cont_seg_u + 1;
      end if;
    end if;
  end if;
end process;

seg_d <= '1' when cont_seg_u = 9 and seg_u = '1' else '0';
sw_seg_u <= std_logic_vector(to_unsigned(cont_seg_u,sw_seg_u'length));

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

sw_seg_d <= std_logic_vector(to_unsigned(cont_seg_d,sw_seg_d'length));

end Behavioral;

