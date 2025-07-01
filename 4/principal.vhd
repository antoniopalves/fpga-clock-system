library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity principal is
    Port ( reset : in std_logic;
           clk : in std_logic;
           algarismo : out std_logic_vector(7 downto 0);
           switch1 : in std_logic;
			  switchEDIT : in std_logic;
			  switchTIMER : in std_logic;
			  switchALARM : in std_logic;
			  switchStopWatch : IN std_logic;  
			  buttonMODE : in std_logic;
			  buttonTYPEMODE : in std_logic;
			  buttonINC : in std_logic;
			  LED_Alarm : out std_logic;
			  LED_Timer : out std_logic;
           an3 : out std_logic;
           an2 : out std_logic;
           an1 : out std_logic;
           an0 : out std_logic);
end principal;

architecture Behavioral of principal is
COMPONENT relogio
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		switchEDIT : in std_logic;
		incSec : in std_logic;
		incMin : in std_logic;
		incHour : in std_logic;	
		c_seg_u : OUT std_logic_vector(3 downto 0);
		c_seg_d : OUT std_logic_vector(3 downto 0);
		c_min_u : OUT std_logic_vector(3 downto 0);
		c_min_d : OUT std_logic_vector(3 downto 0);
		c_hour_u : OUT std_logic_vector(3 downto 0);
		c_hour_d : OUT std_logic_vector(3 downto 0);
		seg_u_aux : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT conv_displays
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		seg_u : IN std_logic_vector(3 downto 0);
		seg_d : IN std_logic_vector(3 downto 0);
		min_u : IN std_logic_vector(3 downto 0);
		min_d : IN std_logic_vector(3 downto 0);        
		an3 : OUT std_logic;
		an2 : OUT std_logic;
		an1 : OUT std_logic;
		an0 : OUT std_logic;
		algarismo : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Debouncer
	PORT(
			clk : IN std_logic;
			buttonIn : IN std_logic;
			buttonOut : OUT std_logic
	);
	END COMPONENT;
	
	COMPONENT State_machine
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		switchEDIT : IN std_logic;
		switchTIMER : IN std_logic;
		switchALARM : IN std_logic;
		buttonMODE : IN std_logic;
		buttonINC : IN std_logic;          
		incSec : OUT std_logic;
		incMin : OUT std_logic;
		incHour : OUT std_logic;
		incSecAlarm : OUT std_logic;
		incMinAlarm : OUT std_logic;
		incHourAlarm : OUT std_logic;
		incSecTimer : OUT std_logic;
		incMinTimer : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Mode_State_Machine
	PORT(
		clk : IN std_logic;
		buttonTYPEMODE : IN std_logic;          
		mode : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Alarm
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		incSecAlarm : IN std_logic;
		incMinAlarm : IN std_logic;
		incHourAlarm : IN std_logic;
		buttonSTOP : IN std_logic;
		switchALARM : IN std_logic;
		c_seg_u : IN std_logic_vector(3 downto 0);
		c_seg_d : IN std_logic_vector(3 downto 0);
		c_min_u : IN std_logic_vector(3 downto 0);
		c_min_d : IN std_logic_vector(3 downto 0);
		c_hour_u : IN std_logic_vector(3 downto 0);
		c_hour_d : IN std_logic_vector(3 downto 0);          
		a_seg_u : OUT std_logic_vector(3 downto 0);
		a_seg_d : OUT std_logic_vector(3 downto 0);
		a_min_u : OUT std_logic_vector(3 downto 0);
		a_min_d : OUT std_logic_vector(3 downto 0);
		a_hour_u : OUT std_logic_vector(3 downto 0);
		a_hour_d : OUT std_logic_vector(3 downto 0);
		alarmIsRunning : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Timer
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		switchTimer : IN std_logic;
		incSecTimer : IN std_logic;
		incMinTimer : IN std_logic;
		seg_u_aux : IN std_logic;          
		t_seg_u : OUT std_logic_vector(3 downto 0);
		t_seg_d : OUT std_logic_vector(3 downto 0);
		t_min_u : OUT std_logic_vector(3 downto 0);
		t_min_d : OUT std_logic_vector(3 downto 0);
		timerFinished : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT StopWatch
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		switchStopWatch : IN std_logic;          
		sw_mseg_u : OUT std_logic_vector(3 downto 0);
		sw_mseg_d : OUT std_logic_vector(3 downto 0);
		sw_seg_u : OUT std_logic_vector(3 downto 0);
		sw_seg_d : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
signal c_seg_u_aux, c_min_u_aux, c_hour_u_aux, c_d0_aux, c_d1_aux : std_logic_vector(3 downto 0);
signal c_seg_d_aux, c_min_d_aux, c_hour_d_aux, c_d2_aux, c_d3_aux : std_logic_vector(3 downto 0);
signal a_seg_u_aux, a_min_u_aux, a_hour_u_aux : std_logic_vector(3 downto 0);
signal a_seg_d_aux, a_min_d_aux, a_hour_d_aux : std_logic_vector(3 downto 0);
signal t_seg_u_aux, t_min_u_aux : std_logic_vector(3 downto 0);
signal t_seg_d_aux, t_min_d_aux : std_logic_vector(3 downto 0);
signal sw_mseg_u_aux, sw_mseg_d_aux, sw_seg_u_aux, sw_seg_d_aux : std_logic_vector(3 downto 0);
signal incSec_aux, incMin_aux, incHour_aux, DbuttonMODE, DbuttonINC, DbuttonTYPEMODE : std_logic;
signal incSecAlarm_aux, incMinAlarm_aux, incHourAlarm_aux, alarmIsRunning_aux : std_logic;
signal incSecTimer_aux, incMinTimer_aux, seg_u_aux, timerFinished : std_logic;
signal Mode_aux : std_logic_vector(1 downto 0);

begin

--------------- WATCH ---------------

	r : relogio
	port map(reset => reset,
			  clk => clk,
			  c_seg_u => c_seg_u_aux,
           c_seg_d => c_seg_d_aux,
			  c_min_u => c_min_u_aux,
			  c_min_d => c_min_d_aux,
			  c_hour_u => c_hour_u_aux,
			  c_hour_d => c_hour_d_aux,
			  switchEDIT => switchEDIT,
			  incSec => incSec_aux,
			  incMin => incMin_aux,
			  incHour => incHour_aux,
			  seg_u_aux => seg_u_aux
			  );

--------------- DEBOUNCERS ---------------
			  
	buttonMODE_Debouncer: Debouncer 
	PORT MAP(
		clk => clk,
		buttonIn => buttonMODE,
		buttonOut => DbuttonMODE
	);
	
	buttonINC_Debouncer: Debouncer 
	PORT MAP(
		clk => clk,
		buttonIn => buttonINC,
		buttonOut => DbuttonINC
	);
	
	button3_Debouncer: Debouncer 
	PORT MAP(
		clk => clk,
		buttonIn => buttonTYPEMODE,
		buttonOut => DbuttonTYPEMODE
	);

--------------- STATE MACHINES ---------------

	Edit_State_machine: State_machine 
	PORT MAP(
		clk => clk,
		reset => reset,
		switchEDIT => switchEDIT,
		switchTIMER => switchTIMER,
		switchALARM => switchALARM,
		buttonMODE => DbuttonMODE,
		buttonINC => DbuttonINC,
		incSec => incSec_aux,
		incMin => incMin_aux,
		incHour => incHour_aux,
		incSecAlarm => incSecAlarm_aux,
		incMinAlarm => incMinAlarm_aux,
		incHourAlarm => incHourAlarm_aux,
		incSecTimer => incSecTimer_aux,
		incMinTimer => incMinTimer_aux
	);
	
	Mode_SM: Mode_State_Machine 
	PORT MAP(
		clk => clk,
		buttonTYPEMODE => DbuttonTYPEMODE,
		mode => Mode_aux
	);
	
--------------- ALARM ---------------

	a: Alarm 
	PORT MAP(
		clk => clk,
		reset => reset,
		switchALARM => switchALARM,
		buttonSTOP => DbuttonINC,
		incSecAlarm => incSecAlarm_aux,
		incMinAlarm => incMinAlarm_aux,
		incHourAlarm => incHourAlarm_aux,
		a_seg_u => a_seg_u_aux,
		a_seg_d => a_seg_d_aux,
		a_min_u => a_min_u_aux,
		a_min_d => a_min_d_aux,
		a_hour_u => a_hour_u_aux,
		a_hour_d => a_hour_d_aux,
		c_seg_u => c_seg_u_aux,
		c_seg_d => c_seg_d_aux,
		c_min_u => c_min_u_aux,
		c_min_d => c_min_d_aux,
		c_hour_u => c_hour_u_aux,
		c_hour_d => c_hour_d_aux,
		alarmIsRunning => alarmIsRunning_aux
	);
	
	process(alarmIsRunning_aux)
		begin
			if(alarmIsRunning_aux = '1') then
				LED_Alarm <= '1';
				
			elsif(alarmIsRunning_aux = '0') then
				LED_Alarm <= '0';
			end if;
	end process;

--------------- STOPWATCH ---------------
	
	sw : StopWatch PORT MAP(
			clk => clk,
			reset => reset,
			switchStopWatch => switchStopWatch,
			sw_mseg_u => sw_mseg_u_aux,
			sw_mseg_d => sw_mseg_d_aux,
			sw_seg_u => sw_seg_u_aux,
			sw_seg_d => sw_seg_d_aux
		);
		
--------------- TIMER ---------------
	
	t: Timer PORT MAP(
		clk => clk,
		reset => reset,
		switchTimer => switchTIMER,
		incSecTimer => incSecTimer_aux,
		incMinTimer => incMinTimer_aux,
		t_seg_u => t_seg_u_aux,
		t_seg_d => t_seg_d_aux,
		t_min_u => t_min_u_aux,
		t_min_d => t_min_d_aux,
		seg_u_aux => seg_u_aux,
		timerFinished => timerFinished
	);
	
LED_Timer <= '1' when (timerFinished = '0') else '0';

--------------- DISPLAY ---------------

process(	clk, Mode_aux, switch1,
			c_d0_aux, c_d1_aux, c_d2_aux, c_d3_aux, 
			c_seg_u_aux, c_seg_d_aux, c_min_u_aux, c_min_d_aux, c_hour_u_aux, c_hour_d_aux,
			a_seg_u_aux, a_seg_d_aux, a_min_u_aux, a_min_d_aux, a_hour_u_aux, a_hour_d_aux )
	begin
	if clk'event and clk = '1' then
		if(Mode_aux = "00") then
			if(switch1 = '0') then
				c_d0_aux <= c_seg_u_aux;
				c_d1_aux <= c_seg_d_aux;
				c_d2_aux <= c_min_u_aux;
				c_d3_aux <= c_min_d_aux;
			else 
				c_d0_aux <= c_min_u_aux;
				c_d1_aux <= c_min_d_aux;
				c_d2_aux <= c_hour_u_aux;
				c_d3_aux <= c_hour_d_aux;
			end if;
		elsif(Mode_aux = "01") then
			if(switch1 = '0') then
				c_d0_aux <= a_seg_u_aux;
				c_d1_aux <= a_seg_d_aux;
				c_d2_aux <= a_min_u_aux;
				c_d3_aux <= a_min_d_aux;
			else 
				c_d0_aux <= a_min_u_aux;
				c_d1_aux <= a_min_d_aux;
				c_d2_aux <= a_hour_u_aux;
				c_d3_aux <= a_hour_d_aux;
			end if;
		elsif(Mode_aux = "10") then
				c_d0_aux <= t_seg_u_aux;
				c_d1_aux <= t_seg_d_aux;
				c_d2_aux <= t_min_u_aux;
				c_d3_aux <= t_min_d_aux;
		elsif(Mode_aux = "11") then
				c_d0_aux <= sw_mseg_u_aux;
				c_d1_aux <= sw_mseg_d_aux;
				c_d2_aux <= sw_seg_u_aux;
				c_d3_aux <= sw_seg_d_aux;
		end if;
	end if;
end process;

cd : conv_displays
	port map(reset => reset,
			  clk => clk,
			  seg_u => c_d0_aux,
			  seg_d => c_d1_aux,
			  min_u => c_d2_aux,
			  min_d => c_d3_aux,
			  algarismo => algarismo,
			  an3 => an3,
			  an2 => an2,
			  an1 => an1,
			  an0 => an0
			  ); 

end Behavioral;