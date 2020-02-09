----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari 
-- 
-- Create Date: 03.02.2020 20:22:00
-- Design Name: BoundaryScan cell register
-- Module Name: bsc_register - Behavioral
-- Project Name: CCW1, course work project
-- Target Devices:  Basys3 board
-- Tool Versions:  1.0 version   -
-- Description:  This is a top file of boundary scan cell. With the help of this is top file I'm able to create a 6 cells boundary scan cells. 
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

entity bsc_register is
  Port ( 
    clk, rst, tdi: in std_logic;
    bsc_p_in0,bsc_p_in1, bsc_p_in2,bsc_p_in3,bsc_p_in4,bsc_p_in5: in std_logic;
    bsc_cs_mux_ctr, bsc_1_mux_ctr, bsc_csff_en, bsc_1_ff_en: in std_logic;
    bsc_p_out0,bsc_p_out1,bsc_p_out2,bsc_p_out3,bsc_p_out4,bsc_p_out5:out std_logic;
    bs_reg_out: out std_logic
  );
end bsc_register;

architecture Behavioral of bsc_register is
SIGNAL bsc_s_out0,bsc_s_out1,bsc_s_out2,bsc_s_out3,bsc_s_out4: std_logic;

begin
    unit_cell0: entity work.bscell(Behavioral)
        port map(
        clk => clk, rst=> rst,
        bsc_cs_mux_ctr => bsc_cs_mux_ctr, bsc_1_mux_ctr => bsc_1_mux_ctr,
        bsc_csff_en => bsc_csff_en, bsc_1_ff_en => bsc_1_ff_en,
        bsc_p_in => bsc_p_in0, bsc_s_in => tdi,
        bsc_p_out => bsc_p_out0, bsc_s_out => bsc_s_out0

       );
        unit_cell1: entity work.bscell(Behavioral)
        port map(
                clk => clk, rst=> rst,
                bsc_cs_mux_ctr => bsc_cs_mux_ctr, bsc_1_mux_ctr => bsc_1_mux_ctr,
                bsc_csff_en => bsc_csff_en, bsc_1_ff_en => bsc_1_ff_en,
                bsc_p_in => bsc_p_in1, bsc_s_in => bsc_s_out0,
                bsc_p_out => bsc_p_out1, bsc_s_out => bsc_s_out1
        );    
       unit_cell2: entity work.bscell(Behavioral)
        port map(
                clk => clk, rst=> rst,
                bsc_cs_mux_ctr => bsc_cs_mux_ctr, bsc_1_mux_ctr => bsc_1_mux_ctr,
                bsc_csff_en => bsc_csff_en, bsc_1_ff_en => bsc_1_ff_en,
                bsc_p_in => bsc_p_in2, bsc_s_in => bsc_s_out1,
                bsc_p_out => bsc_p_out2, bsc_s_out => bsc_s_out2
        );    
         unit_cell3: entity work.bscell(Behavioral)
         port map(
                 clk => clk, rst=> rst,
                 bsc_cs_mux_ctr => bsc_cs_mux_ctr, bsc_1_mux_ctr => bsc_1_mux_ctr,
                 bsc_csff_en => bsc_csff_en, bsc_1_ff_en => bsc_1_ff_en,
                 bsc_p_in => bsc_p_in3, bsc_s_in => bsc_s_out2,
                 bsc_p_out => bsc_p_out3, bsc_s_out => bsc_s_out3
         );
                unit_cell4: entity work.bscell(Behavioral)
          port map(
                  clk => clk, rst=> rst,
                  bsc_cs_mux_ctr => bsc_cs_mux_ctr, bsc_1_mux_ctr => bsc_1_mux_ctr,
                  bsc_csff_en => bsc_csff_en, bsc_1_ff_en => bsc_1_ff_en,
                  bsc_p_in => bsc_p_in4, bsc_s_in => bsc_s_out3,
                  bsc_p_out => bsc_p_out4, bsc_s_out => bsc_s_out4
          );
          unit_cell5: entity work.bscell(Behavioral)
           port map(
                   clk => clk, rst=> rst,
                   bsc_cs_mux_ctr => bsc_cs_mux_ctr, bsc_1_mux_ctr => bsc_1_mux_ctr,
                   bsc_csff_en => bsc_csff_en, bsc_1_ff_en => bsc_1_ff_en,
                   bsc_p_in => bsc_p_in5, bsc_s_in => bsc_s_out4,
                   bsc_p_out => bsc_p_out5, bsc_s_out => bs_reg_out
           );
end Behavioral;