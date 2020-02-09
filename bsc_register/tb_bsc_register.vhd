----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari
-- 
-- Create Date: 04.02.2020 15:18:06
-- Design Name: 
-- Module Name: tb_register - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_bsc_register is
--  Port ( );
end tb_bsc_register;

architecture Behavioral of tb_bsc_register is
Component bsc_register
    PORT(
        clk, rst, tdi: in std_logic;
        bsc_p_in0,bsc_p_in1, bsc_p_in2,bsc_p_in3,bsc_p_in4,bsc_p_in5: in std_logic;
        bsc_cs_mux_ctr, bsc_1_mux_ctr, bsc_csff_en, bsc_1_ff_en: in std_logic;
        bsc_p_out0,bac_p_out1,bsc_p_out2,bsc_p_out3,bsc_p_out4,bsc_p_out5:out std_logic;
        bs_reg_out: out std_logic
    );
   end Component;
signal        clk, rst, tdi: std_logic :='0';
signal        bsc_p_in0,bsc_p_in1, bsc_p_in2,bsc_p_in3,bsc_p_in4,bsc_p_in5:  std_logic :='0';
signal        bsc_cs_mux_ctr, bsc_1_mux_ctr, bsc_csff_en, bsc_1_ff_en: std_logic :='0';
signal        bsc_p_out0,bac_p_out1,bsc_p_out2,bsc_p_out3,bsc_p_out4,bsc_p_out5: std_logic :='0';
signal        bs_reg_out:  std_logic;
constant clk_period : time := 10ns;
begin
 uut: bsc_register port map(
 clk => clk, rst=>rst, tdi =>tdi,
 bsc_p_in0 => bsc_p_in0, bsc_p_in1 => bsc_p_in1,
 bsc_p_in2 => bsc_p_in2, bsc_p_in3 => bsc_p_in3,
 bsc_p_in4 => bsc_p_in4, bsc_p_in5 => bsc_p_in5,
 bsc_cs_mux_ctr => bsc_cs_mux_ctr, bsc_1_mux_ctr => bsc_1_mux_ctr,
 bsc_csff_en => bsc_csff_en, bsc_1_ff_en => bsc_1_ff_en,
 bsc_p_out0 => bsc_p_out0, bac_p_out1 => bac_p_out1,
 bsc_p_out2 => bsc_p_out2, bsc_p_out3 => bsc_p_out3,
 bsc_p_out4 => bsc_p_out4, bsc_p_out5 => bsc_p_out5,
 bs_reg_out => bs_reg_out
 
);
clk_process :process
begin 
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
    

end process;

stimulus: process
    begin
        rst <='1';
        wait for 100ns;
        rst <= '0';
        wait for  clk_period*2;
        bsc_cs_mux_ctr <= '1';       -- shift mode
        bsc_1_mux_ctr <= '0';       -- normal mode mux on the right side
        bsc_csff_en <= '1';     -- shift or capture mode, mux on left side between the ff and first mux
        bsc_1_ff_en <= '0';    -- the small mux in the right side
        tdi <= '1';             -- serial input
        wait for clk_period;
        tdi <= '0';
        wait for clk_period;
        tdi <= '1';
        wait for clk_period;
        tdi <= '0';
        wait for clk_period;
        tdi <= '1';
        wait for clk_period;
        tdi <= '0';
        wait for clk_period;
        bsc_csff_en <= '0';       -- neither in cap mode 
        bsc_1_ff_en <= '1';       -- in update mode
        wait for clk_period*2;
        bsc_1_mux_ctr <= '1';          -- test mode
        wait;
        end process;
        
        

end Behavioral;
