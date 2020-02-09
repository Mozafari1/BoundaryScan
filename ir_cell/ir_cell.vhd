----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari
-- 
-- Create Date: 04.02.2020 17:04:41
-- Design Name: 
-- Module Name: ir_cells - Behavioral
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

entity ir_cell is
  Port ( 
        clk, rst: std_logic;
        irc_p_in, irc_s_in: in std_logic;
        irc_cs_mux_ctr, irc_csff_en, irc_1ff_en: in std_logic;
        irc_p_out, irc_s_out: out std_logic
  
  );
end ir_cell;

architecture Behavioral of ir_cell is
signal irc_cs_mux_out, irc_csff_next, irc_csff_reg, irc_1ff_next, irc_1ff_reg: std_logic;

begin
process(clk, rst)
begin   
    if (rst ='1')then 
    irc_csff_reg <= '0';
    elsif (clk'event and clk='1') then 
    irc_csff_reg <= irc_csff_next;
    end if;
    end process;
    irc_csff_next <= irc_cs_mux_out when irc_csff_en ='1' else irc_csff_reg;
    irc_cs_mux_out <= irc_s_in when irc_cs_mux_ctr ='1' else irc_p_in;

process(clk, rst)
begin
    if (rst ='1') then 
    irc_1ff_reg <= '0';
    elsif  (clk'event and clk='1') then
    irc_1ff_reg <= irc_1ff_next;
    end if;
    end process;
    irc_1ff_next <= irc_csff_reg when irc_1ff_en ='1' else irc_1ff_reg;
    irc_p_out <= irc_1ff_reg;
    irc_s_out <= irc_csff_reg;
    
         

end Behavioral;
