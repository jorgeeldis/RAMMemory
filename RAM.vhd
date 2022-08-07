library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity RAM is
port (
clock : in std_logic;
we : in std_logic;
address : in std_logic_vector(3 downto 0);
datain : in std_logic_vector(3 downto 0);
dataout : out std_logic_vector(3 downto 0)
);
end entity RAM;

architecture Behavioral of RAM is

type ram_type is array (7 downto 0) of std_logic_vector(3 downto 0);
signal ram : ram_type;

begin
process (clock)
begin 
		if (clock'event and clock='1') then
			if (we='1') then
			ram(conv_integer (address)) <=datain;
		else
			dataout <= ram(conv_integer(address));
			end if;
		end if;
end process;

end Behavioral;