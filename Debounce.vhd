library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
	Port ( clk,reset : in STD_LOGIC;
	sw : in STD_LOGIC;
	db_level,db_tick : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
constant N: integer:=21; 
type estados is (cero,espera0,uno,espera1);
signal estado_reg,estado_next:estados;
signal q_reg,q_next:unsigned(N-1 downto 0);

begin
process(clk,reset)
begin
if(reset='1') then
estado_reg <= cero;
q_reg <= (others=>'0');
elsif(clk'event and clk='1') then
estado_reg <= estado_next;
q_reg <= q_next;
end if;
end process;
process(estado_reg,q_reg,sw,q_next)
begin
estado_next <= estado_reg;
q_next <= q_reg;
db_tick <= '0';
case estado_reg is
when cero =>
db_level <= '0';
if(sw = '1') then
estado_next <= espera1;
q_next <= (others=>'1');
end if;
when espera1 =>
db_level <= '0';
if(sw = '1') then
q_next <= q_reg - 1;
if(q_next = 0) then
estado_next <= uno;
db_tick <= '1';
end if;
else -- sw='0'
estado_next <= cero;
end if;
when uno =>
db_level <= '1';
if(sw = '0') then
estado_next <= espera0;
q_next <= (others=>'1');
end if;
when espera0 =>
db_level <= '1';
if(sw = '0') then
q_next <= q_reg - 1;
if(q_next = 0) then
estado_next <= cero;
end if;
else -- sw='1'
estado_next <= uno;
end if;
end case;
end process;
end Behavioral;