----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2024 8:11:51 PM
-- Design Name: 
-- Module Name: regs_tb - Behavioral
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

entity regs_tb is
    --  Port ( );
end regs_tb;

architecture Behavioral of regs_tb is


    component regs1 is
        Port ( clk, en, rst : in STD_LOGIC;
             id1, id2 : in STD_LOGIC_VECTOR (4 downto 0);
             wr_en1, wr_en2 : in STD_LOGIC;
             din1, din2 : in STD_LOGIC_VECTOR (15 downto 0);
             dout1, dout2 : out STD_LOGIC_VECTOR (15 downto 0));
    end component regs1;

    component clock_div_uart is

        port (
            clk : in std_logic;
            en  : out std_logic
        );
    end component clock_div_uart;

    signal clk, en, rst : std_logic := '0';
    signal id1, id2 : std_logic_vector(4 downto 0) := (others => '0');
    signal wr_en1, wr_en2 : std_logic := '0';
    signal din1, din2 : std_logic_vector(15 downto 0) := x"aaaa";
    signal dout1, dout2 : std_logic_vector(15 downto 0) := (others => '0');



begin

    clockdiv : clock_div_uart port map(
            clk => clk,
            en => en
        );

    dut : regs1 port map(
            clk => clk,
            en => en,
            rst => rst,
            id1 => id1,
            id2 => id2,
            wr_en1 => wr_en1,
            wr_en2 => wr_en2,
            din1 => din1,
            din2 => din2,
            dout1 => dout1,
            dout2 => dout2
        );


    process begin
        clk <= '0';
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
    end process;

--    process begin
--        id1 <= std_logic_vector(unsigned(id1) + 1);
--        wait for 17 us;
--    end process;

    process begin
        wait for 2 us;
        din1 <= x"0101";
        wr_en1 <= '1';
        wait for 5 us;
        wr_en1 <= '0';
        din1 <= X"be40";
        wr_en1 <= '1';
        wait for 4 ns;
        wr_en1 <= '0';
    end process;
end Behavioral;
