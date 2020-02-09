----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari 
-- 
-- Create Date: 04.02.2020 19:06:38
-- Design Name: 
-- Module Name: ir - Behavioral
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

entity ir_register is
  Port (
    clk, rst, tdi: in std_logic;
    irc_p_in_1,irc_p_in_2, irc_p_in_3,irc_p_in_4: in std_logic;
    irc_cs_mux_ctr, irc_csff_en, irc_1ff_en: in std_logic;
    irc_p_out_1, irc_p_out_2,irc_p_out_3,irc_p_out_4: out std_logic;
    irc_reg_out: out std_logic
  
   );
end ir_register;

architecture Behavioral of ir_register is
SIGNAL  irc_s_out_1,irc_s_out_2,irc_s_out_3: std_logic;
begin
unit_ir_register_cell0: entity work.ir_cell(Behavioral)
            port map(
                        clk => clk, rst =>rst,
                        irc_cs_mux_ctr => irc_cs_mux_ctr,
                        irc_csff_en =>irc_csff_en, irc_1ff_en =>irc_1ff_en,
                        irc_p_in =>irc_p_in_1, irc_s_in => tdi, 
                        irc_p_out =>irc_p_out_1, irc_s_out =>irc_s_out_1
            
            );
unit_ir_register_cell1: entity work.ir_cell(Behavioral)
            port map(
                        clk => clk, rst =>rst,
                        irc_cs_mux_ctr => irc_cs_mux_ctr,
                        irc_csff_en =>irc_csff_en, irc_1ff_en =>irc_1ff_en,
                        irc_p_in =>irc_p_in_2, irc_s_in => irc_s_out_1, 
                        irc_p_out =>irc_p_out_2, irc_s_out =>irc_s_out_2
                        
                        );
unit_ir_register_cell2: entity work.ir_cell(Behavioral)
            port map(
                        clk => clk, rst =>rst,
                        irc_cs_mux_ctr => irc_cs_mux_ctr,
                        irc_csff_en =>irc_csff_en, irc_1ff_en =>irc_1ff_en,
                        irc_p_in =>irc_p_in_3, irc_s_in => irc_s_out_2, 
                        irc_p_out =>irc_p_out_3, irc_s_out =>irc_s_out_3
                                                
                                                );
unit_ir_register_cell3: entity work.ir_cell(Behavioral)
            port map(
                        clk => clk, rst =>rst,
                        irc_cs_mux_ctr => irc_cs_mux_ctr,
                        irc_csff_en =>irc_csff_en, irc_1ff_en =>irc_1ff_en,
                        irc_p_in =>irc_p_in_4, irc_s_in => irc_s_out_3, 
                        irc_p_out =>irc_p_out_4, irc_s_out =>irc_reg_out
                                                            
                                                            );
end Behavioral;
