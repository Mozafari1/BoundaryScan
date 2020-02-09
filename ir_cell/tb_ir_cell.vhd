----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari 
-- 
-- Create Date: 04.02.2020 18:37:29
-- Design Name: 
-- Module Name: tb_ir_cells - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ir_cell is
--  Port ( );
end tb_ir_cell;

architecture Behavioral of tb_ir_cell is
component ir_cell
    port(
        clk, rst: in std_logic;
        irc_p_in, irc_s_in: in std_logic;
        irc_cs_mux_ctr, irc_csff_en, irc_1ff_en: in std_logic;
        irc_p_out, irc_s_out: out std_logic
    );
    end component;
signal clk, rst: std_logic :='0';
signal irc_p_in, irc_s_in: std_logic :='0';
signal irc_cs_mux_ctr, irc_csff_en, irc_1ff_en: std_logic :='0';
signal irc_p_out, irc_s_out : std_logic :='0';
CONSTANT clk_period : time :=10ns;
BEGIN
-- inistantate for UUT
    uut: ir_cell port map(
        clk => clk, rst => rst,
        irc_p_in => irc_p_in, irc_s_in => irc_s_in, 
        irc_cs_mux_ctr => irc_cs_mux_ctr,
        irc_csff_en => irc_csff_en, irc_1ff_en => irc_1ff_en,
        irc_p_out => irc_p_out, irc_s_out => irc_s_out
    );

-- processing for clk period
clk_process: process
begin
clk <= '0';
wait for clk_period/2;
clk <= '1';
wait for clk_period/2;
end process;

-- running stimulus process
stimulus: process
begin
    rst <= '1';
    wait for clk_period*10;
    rst <='0';
    wait for clk_period*10;
    irc_p_in <= '0';
    irc_s_in <= '1';
    irc_csff_en <= '1';
    irc_cs_mux_ctr <= '1'; -- setting to shift mode
    wait for clk_period;
    irc_1ff_en <= '1';
    wait for clk_period;
    irc_1ff_en <= '0';
    wait;
    end process;
    

end Behavioral;
