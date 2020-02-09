----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari 
-- 
-- Create Date: 09.02.2020 10:37:07
-- Design Name: 
-- Module Name: toplevel - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevel is
 Port ( 
        clk, rst, tms, tdi: in std_logic;
        --d_mux_in0, d_mux_in1, d_mux_ctr: in std_logic;
        -- d_mux_out: out std_logic;
        --di_mux_in0, di_mux_in1, di_mux_ctr: in std_logic;
        -- di_mux_out: out std_logic;
        --bypass_on, sp_on, extest_on: out std_logic;
        tdo: out std_logic
        
        );
end toplevel;

architecture Behavioral of toplevel is
-- BS cell register
component bsc_register
    Port(
        clk, rst, tdi: in std_logic;
        bsc_p_in0,bsc_p_in1, bsc_p_in2,bsc_p_in3,bsc_p_in4,bsc_p_in5: in std_logic;
        bsc_cs_mux_ctr, bsc_1_mux_ctr, bsc_csff_en, bsc_1_ff_en: in std_logic;
        bsc_p_out0,bsc_p_out1,bsc_p_out2,bsc_p_out3,bsc_p_out4,bsc_p_out5:out std_logic;
        bs_reg_out: out std_logic
            );
        end component;
 signal bsc_p_in0,bsc_p_in1, bsc_p_in2,bsc_p_in3,bsc_p_in4,bsc_p_in5: std_logic;
 signal bsc_cs_mux_ctr, bsc_1_mux_ctr, bsc_csff_en, bsc_1_ff_en:  std_logic;
 signal bsc_p_out0,bsc_p_out1,bsc_p_out2,bsc_p_out3,bsc_p_out4,bsc_p_out5: std_logic;
 signal bs_reg_out: std_logic;
 --- D_MUX 
 signal d_mux_in0, d_mux_in1, d_mux_ctr: std_logic;
 -- DI_MUX
 signal di_mux_in0, di_mux_in1, di_mux_ctr: std_logic; 
 signal d_mux_out, di_mux_out: std_logic;
 -- GATES
 signal bypass_on, sp_on, extest_on: std_logic;
 --  IR rigister 
component ir_register
Port (
    clk, rst, tdi: in std_logic;
    irc_p_in_1,irc_p_in_2, irc_p_in_3,irc_p_in_4: in std_logic;
    irc_cs_mux_ctr, irc_csff_en, irc_1ff_en: in std_logic;
    irc_p_out_1, irc_p_out_2,irc_p_out_3,irc_p_out_4: out std_logic;
    irc_reg_out: out std_logic
  
   );
   end component;
signal irc_p_in_1,irc_p_in_2, irc_p_in_3,irc_p_in_4:  std_logic;
signal irc_cs_mux_ctr, irc_csff_en, irc_1ff_en:  std_logic;
signal irc_p_out_1, irc_p_out_2,irc_p_out_3,irc_p_out_4:  std_logic;
signal irc_reg_out:  std_logic;   
-- BYPASS Cell
component bp_cell
Port ( clk, rst: in std_logic;
       bpc_p_in, bpc_s_in: in std_logic;
       bpc_csff_en: in std_logic;            
       bpc_cs_mux_ctr: in std_logic;
       bpc_s_out: out std_logic
    );
end component;
signal bpc_p_in, bpc_s_in,bpc_csff_en,bpc_cs_mux_ctr: std_logic;
signal bpc_s_out: std_logic;
-- TAP controller
component tap
Port (
        tms, rst, clk: in std_logic;
        tlr_on,capt_dr_on, shift_dr_on, updt_dr_on: out std_logic;
        shift_ir_on, updt_ir_on,capt_ir_on : out std_logic
   );
end component;
--signal tlr_on,capt_dr_on, shift_dr_on, updt_dr_on: std_logic;
--signal shift_ir_on, updt_ir_on,capt_ir_on: std_logic;
begin
bsc_register_unit: bsc_register
port map(
        clk => clk, rst => rst, tdi => tdi,
        bsc_p_in0=>bsc_p_in0, bsc_p_in1=>bsc_p_in1, bsc_p_in2=>bsc_p_in2, bsc_p_in3=>bsc_p_in3,bsc_p_in4=>bsc_p_in4, bsc_p_in5=>bsc_p_in5,
        bsc_cs_mux_ctr =>bsc_cs_mux_ctr, bsc_1_mux_ctr=>bsc_1_mux_ctr, bsc_csff_en=>bsc_csff_en, bsc_1_ff_en=>bsc_1_ff_en,
        bsc_p_out0=>bsc_p_out0, bsc_p_out1=>bsc_p_out1,bsc_p_out2 =>bsc_p_out2, bsc_p_out3=>bsc_p_out3, bsc_p_out4=>bsc_p_out4, bsc_p_out5 =>bsc_p_out5,
        bs_reg_out => bs_reg_out

        );
ir_register_unit: ir_register
    port map(
                clk => clk, rst => rst, tdi =>tdi,
                irc_p_in_1=>irc_p_in_1, irc_p_in_2=>irc_p_in_2, irc_p_in_3=>irc_p_in_3, irc_p_in_4=>irc_p_in_4,
                irc_cs_mux_ctr =>irc_cs_mux_ctr, irc_csff_en=>irc_csff_en, irc_1ff_en =>irc_1ff_en,
                irc_p_out_1=>irc_p_out_1, irc_p_out_2=>irc_p_out_2, irc_p_out_3=>irc_p_out_3, irc_p_out_4 =>irc_p_out_4,
                irc_reg_out =>irc_reg_out
            );
            
 bypass_unit: bp_cell
    port map(
                clk => clk, rst =>rst, 
                bpc_p_in=>bpc_p_in, bpc_s_in=>bpc_s_in,
                bpc_csff_en =>bpc_csff_en, bpc_cs_mux_ctr =>bpc_cs_mux_ctr,
                bpc_s_out => bpc_s_out
            );
tap_ctr_unit: tap
    port map(   
                clk => clk, rst =>rst, tms =>tms,
                tlr_on=>di_mux_ctr, 
                capt_dr_on =>di_mux_ctr, shift_dr_on=>di_mux_ctr, updt_dr_on =>di_mux_ctr,
                shift_ir_on=>di_mux_ctr, updt_ir_on =>di_mux_ctr, capt_ir_on =>di_mux_ctr
    
            );
d_mux_in0 <= bs_reg_out;
di_mux_in1 <= irc_reg_out;
d_mux_in1 <=  bpc_s_out;       
bypass_on<= irc_p_out_1 and irc_p_out_2 and irc_p_out_3 and irc_p_out_4;
sp_on<= irc_p_out_1 and (not irc_p_out_2) and (not irc_p_out_3) and irc_p_out_4;
extest_on<= (not irc_p_out_1) and (not irc_p_out_2) and (not irc_p_out_3) and (not irc_p_out_4);
d_mux_ctr <= bypass_on;
d_mux_ctr <= sp_on;
d_mux_ctr <= extest_on;
d_mux_out <= d_mux_in1 when d_mux_ctr ='1' else d_mux_in0;
di_mux_in0 <= d_mux_out;
di_mux_out <= di_mux_in1 when di_mux_ctr ='1' else di_mux_in0;
tdo <= di_mux_out;
end Behavioral;
