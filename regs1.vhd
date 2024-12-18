----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2024 7:10:27 PM
-- Design Name: 
-- Module Name: regs1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity regs1 is
    Port(
        clk, en, rst : in std_logic;
        id1, id2 : in STD_LOGIC_VECTOR (4 downto 0);
        wr_en1, wr_en2 : in STD_LOGIC;
        din1, din2 : in STD_LOGIC_VECTOR (15 downto 0);
        dout1, dout2 : out STD_LOGIC_VECTOR (15 downto 0));
end regs1;

architecture Behavioral of regs1 is

    type registers is array (0 to 31) of std_logic_vector(15 downto 0);
    signal regs : registers := (others =>(others=>'0')); --Initialize every vector in the array to 0s

begin

    dout1 <= regs(to_integer(unsigned(id1)));
    dout2 <= regs(to_integer(unsigned(id2)));

    process(clk)
    begin

        if(rising_edge(clk)) then
            regs(0)<= (others=>'0');
            if(rst = '1') then
                regs <= (others =>(others=>'0'));
            elsif (en = '1') then
                if(wr_en1 = '1') then
                    regs(to_integer(unsigned(id1))) <= din1;
                end if;
                if(wr_en2 = '1') then
                    regs(to_integer(unsigned(id2))) <= din2;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
