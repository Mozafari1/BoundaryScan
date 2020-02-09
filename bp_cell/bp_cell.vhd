----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari

-- Create Date: 09.02.2020 10:29:00
-- Design Name: 
-- Module Name: bp_cell - Behavioral
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

entity bp_cell is
	Port ( clk, rst: in std_logic;
       bpc_p_in, bpc_s_in: in std_logic;
       bpc_csff_en,bpc_cs_mux_ctr: in std_logic;
       bpc_s_out: out std_logic
    );
end bp_cell;

architecture Behavioral of bp_cell is
	signal bpc_csff_reg, bpc_csff_next, bpc_cs_mux_out: std_logic;
begin
        --Capture/Shift part
        process(clk, rst)
        begin
            if(rst = '1') then
                bpc_csff_reg <= '0';
            elsif (clk'event and clk='1') then
                bpc_csff_reg <= bpc_csff_next;
            end if;
        end process;
        
        --Bypass cell capture/shift FlipFlop next logic
        bpc_csff_next <= bpc_cs_mux_out when bpc_csff_en = '1' else bpc_csff_reg;
        
        --CS MUX out logic
        bpc_cs_mux_out <= bpc_s_in when bpc_cs_mux_ctr = '1' else bpc_p_in;
        
        --Serial out
        bpc_s_out <= bpc_csff_reg;

end Behavioral;
