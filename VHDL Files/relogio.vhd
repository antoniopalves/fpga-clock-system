library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity relogio is
    Port ( clk : in std_logic;
           reset : in std_logic;
			  switchEDIT : in std_logic;
			  incSec : in std_logic;
			  incMin : in std_logic;
			  incHour : in std_logic;
           c_seg_u : out std_logic_vector(3 downto 0);
           c_seg_d : out std_logic_vector(3 downto 0);
           c_min_u : out std_logic_vector(3 downto 0);
           c_min_d : out std_logic_vector(3 downto 0);
           c_hour_u : out std_logic_vector(3 downto 0);
           c_hour_d : out std_logic_vector(3 downto 0);
			  seg_u_aux : out std_logic
			  );
end relogio;

architecture Behavioral of relogio is

signal cont_subseg : integer range 0 to 50000000;

signal cont_seg_u, cont_min_u, cont_hour_u : integer range 0 to 9;
signal cont_seg_d, cont_min_d, cont_hour_d : integer range 0 to 9;
signal seg_u, seg_d, min_u, min_d, hour_u, hour_d : std_logic;

begin

process (clk, reset)
begin
	if reset = '1' then
    cont_subseg <= 0;
	elsif clk'event and clk = '1' and switchEdit = '0' then
		if cont_subseg = 49999999 then--49999999 --4
      cont_subseg <= 0;
		else cont_subseg <= cont_subseg + 1;
    end if;
  end if;
end process;

seg_u <= '1' when cont_subseg = 49999999 else '0';--49999999 --4
seg_u_aux <= seg_u;

process (clk, reset)
begin
	if reset = '1' then
    cont_seg_u <= 0;
		
  elsif clk'event and clk = '1' then
    if seg_u = '1' or incSec = '1' then
      if cont_seg_u = 9 then
        cont_seg_u <= 0;
      else cont_seg_u <= cont_seg_u + 1;
      end if;
    end if;
  end if;
end process;

seg_d <= '1' when cont_seg_u = 9 and (seg_u = '1' or incSec = '1') else '0';
c_seg_u <= std_logic_vector(to_unsigned(cont_seg_u,c_seg_u'length));

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

min_u <= '1' when cont_seg_d = 5 and seg_d = '1' and incSec = '0' else '0';
c_seg_d <= std_logic_vector(to_unsigned(cont_seg_d,c_seg_d'length));

process (clk, reset)
begin
  if reset = '1' then
    cont_min_u <= 0;
		 
  elsif clk'event and clk = '1' then
    if min_u = '1' or incMin = '1' then
      if cont_min_u = 9 then
        cont_min_u <= 0;
      else cont_min_u <= cont_min_u + 1;
      end if;
    end if;
  end if;
end process;

min_d <= '1' when cont_min_u = 9 and (min_u = '1' or incMin = '1') else '0';
c_min_u <= std_logic_vector(to_unsigned(cont_min_u,c_min_u'length));

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

hour_u <= '1' when cont_min_d = 5 and min_d = '1' and incMin = '0' else '0';
c_min_d <= std_logic_vector(to_unsigned(cont_min_d,c_min_d'length));

process (clk, reset)
begin
  if reset = '1' then
    cont_hour_u <= 0;
		 
  elsif clk'event and clk = '1' then
    if hour_u = '1' or incHour = '1' then
		if cont_hour_d = 2 and cont_hour_u = 3 then
			cont_hour_u <=0;
      elsif cont_hour_u = 9 then
        cont_hour_u <= 0;
      else cont_hour_u <= cont_hour_u + 1;
      end if;
    end if;
  end if;
end process;

hour_d <= '1' when (cont_hour_u = 9 or (cont_hour_u = 3 and cont_hour_d = 2)) and (hour_u = '1' or incHour = '1') else '0'; --or (cont_hour_u = 3 and cont_hour_d = 2)) 
c_hour_u <= std_logic_vector(to_unsigned(cont_hour_u,c_hour_u'length));

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

c_hour_d <= std_logic_vector(to_unsigned(cont_hour_d,c_hour_d'length));

end Behavioral;