----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2024 05:51:38 PM
-- Design Name: 
-- Module Name: vga_ctrl - vga_ctrl_arch
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

entity vga_ctrl is
    Port (
        signal clk : in std_logic;
        signal clk_en : in std_logic;
        signal hcount, vcount : out std_logic_vector(9 downto 0) := (others => '0');
        signal vid : out std_logic;
        signal hs, vs  : out std_logic
    );
end vga_ctrl;

architecture vga_ctrl_arch of vga_ctrl is
    signal hor_counter : std_logic_vector(9 downto 0) := (others => '0');
    signal ver_counter : std_logic_vector(9 downto 0) := (others => '0');


begin

    hcount <= hor_counter;
    vcount <= ver_counter;

    counter_proc : process(clk) begin
        if(rising_edge(clk)) then
            if(clk_en = '1') then
                if(unsigned(hor_counter) < 799) then
                    hor_counter <= std_logic_vector(unsigned(hor_counter) + 1); --incrememnt horizontal counter by 1
                else
                    hor_counter <= (others => '0'); --reset horizontal counter back to 0
                    if(unsigned(ver_counter) < 524) then
                        ver_counter <= std_logic_vector(unsigned(ver_counter) + 1);
                    else
                        ver_counter <= (others => '0');
                    end if;
                end if;
            end if;
        end if;



    end process counter_proc;


    vid_proc : process(hor_counter, ver_counter) begin
        if((unsigned(hor_counter)>63 or unsigned(ver_counter)>63)) then
            vid <= '0';
        else
            vid <= '1';
        end if;
    end process vid_proc;

    hs_proc : process(hor_counter) begin
        if((unsigned(hor_counter)>655 and unsigned(hor_counter)<752)) then
            hs <= '0';
        else
            hs <= '1';
        end if;
    end process hs_proc;

    vs_proc : process(ver_counter) begin
        if(unsigned(ver_counter) = 490 or unsigned(ver_counter) = 491) then
            vs <= '0';
        else
            vs <= '1';
        end if;
    end process vs_proc;

end vga_ctrl_arch;