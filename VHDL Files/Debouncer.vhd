----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:10:37 11/09/2023 
-- Design Name: 
-- Module Name:    Debouncer - Behavioral 
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

entity Debouncer is
    Port ( 	clk : in  STD_LOGIC;
				buttonIn : in STD_LOGIC;
				buttonOut : out STD_LOGIC
	 );
end Debouncer;

architecture Behavioral of Debouncer is

	signal lastButtonState    : std_logic := '0';
	signal buttonState    : std_logic := '0';
	signal counter : integer range 0 to 10000 := 0;

begin
	process(clk)
	begin
	  if(clk'event and clk = '1') then
			if(buttonIn = '1') then      --assuming active-high
				if counter < 10000 then
					counter <= counter + 1;
				else 
					buttonState <= '1';
				end if;
			else 
				if counter > 0 then 
					counter <= counter - 1;
				else 
					buttonState <= '0';
				end if;
		 end if;
	 end if;
	end process;
	
	process(clk)
	begin
		if(clk'event and clk = '1') then
			if buttonState = '1' and lastButtonState = '0' then
				buttonOut <= '1';
			else
				buttonOut <= '0';
			end if;
			lastButtonState <= buttonState;
		end if;
	end process;

end Behavioral;

