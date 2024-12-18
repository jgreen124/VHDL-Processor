library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity clock_div_tb is
end clock_div_tb;

architecture testbench of clock_div_tb is

    signal tb_clk : std_logic := '0';
    signal tb_en  : std_logic := '0';

    
    component clock_div_uart is
        port(
        
            clk  : in std_logic;        -- 125 Mhz clock
            en   : out std_logic

        );
    end component;

    component clock_div_image_top is
        port(
        
            clk  : in std_logic;        -- 125 Mhz clock
            en   : out std_logic

        );
    end component;    

begin

--------------------------------------------------------------------------------
-- procs
--------------------------------------------------------------------------------

    -- simulate a 125 Mhz clock
    clk_gen_proc: process
    begin
    
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';
    
    end process clk_gen_proc;
    
    dut : clock_div_uart port map (
    clk => tb_clk,
    en => tb_en);   

    dut1 : clock_div_uart port map (
    clk => tb_clk,
    en => tb_en); 

    
end testbench; 
