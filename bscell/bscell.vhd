----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari 
-- 
-- Create Date: 03.02.2020 19:41:37
-- Design Name: BoundaryScan cell
-- Module Name: bscell - Behavioral
-- Project Name: CCW1, this is a course project
-- Target Devices:  basys3 board
-- Tool Versions:  1.0 version
-- Description:  Creating a boundaryScan cell. firstly we need to create the the main cell such it is inside the boundaryscan cell, then we are can make a top file to create a boundaryscan cells with 6 cells.

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

entity bscell is
  Port (clk, rst: std_logic;
        bsc_p_in, bsc_s_in: in std_logic;
        bsc_cs_mux_ctr, bsc_1_mux_ctr: in std_logic;
        bsc_csff_en, bsc_1_ff_en: std_logic;
        bsc_s_out, bsc_p_out: out std_logic
        );
end bscell;

architecture Behavioral of bscell is
signal bsc_csff_nxt, bsc_csff_reg, bsc_1_ff_nxt, bsc_1_ff_reg, bsc_cs_mux_out: std_logic;

begin
    -- Capture and shift mode
    process(clk, rst)
        begin
            if (rst='1') then 
                bsc_csff_reg <= '0';
            elsif(clk'event and clk ='1') then
                bsc_csff_reg <= bsc_csff_nxt;
            end if;
    end process;
    bsc_csff_nxt <= bsc_cs_mux_out when bsc_csff_en ='1' else bsc_csff_reg;
    bsc_cs_mux_out <= bsc_s_in when bsc_cs_mux_ctr ='1' else bsc_p_in;

    -- normal test mode
    process(clk, rst) 
        begin   
            if(rst='1')then 
                bsc_1_ff_reg <='0';
            elsif(clk'event and clk ='1') then 
                bsc_1_ff_reg <= bsc_1_ff_nxt;
            end if;
    end process;
    
    bsc_1_ff_nxt    <= bsc_csff_reg when bsc_1_ff_en ='1' else bsc_1_ff_reg;
    bsc_p_out<= bsc_1_ff_reg when bsc_1_mux_ctr ='1' else bsc_p_in;
    bsc_s_out <= bsc_csff_reg;
end Behavioral;
