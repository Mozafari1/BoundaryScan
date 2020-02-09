----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari

-- Create Date: 04.02.2020 14:42:21
-- Design Name: 
-- Module Name: tb_bscell - Behavioral
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

entity tb_bscell is
--  Port ( );
end tb_bscell;

architecture Behavioral of tb_bscell is
    COMPONENT bscell
    PORT (
            -- using the same port as it is in the cell1 
            clk, rst: in std_logic;
            bsc_p_in, bsc_s_in: in std_logic;
            bsc_cs_mux_ctr, bsc_1_mux_ctr, bsc_csff_en, bsc_1_ff_en: in std_logic;
            bsc_s_out, bsc_p_out: out std_logic
    
    );
        END COMPONENT;

CONSTANT clk_period : time := 10ns;
        SIGNAL clk, rst: std_logic :='0';
        SIGNAL bsc_p_in, bsc_s_in: std_logic :='0';
        SIGNAL bsc_cs_mux_ctr, bsc_1_mux_ctr, bsc_csff_en, bsc_1_ff_en: std_logic :='0';
        SIGNAL bsc_s_out, bsc_p_out: std_logic;
        
        begin
            -- Inistantate the uut
            uut: bscell PORT MAP(
                 clk => clk, rst => rst,bsc_p_in =>bsc_p_in, bsc_s_in=> bsc_s_in, 
                 bsc_cs_mux_ctr=>bsc_cs_mux_ctr,  bsc_1_mux_ctr => bsc_1_mux_ctr, bsc_csff_en => bsc_csff_en, bsc_1_ff_en => bsc_1_ff_en,
                 bsc_s_out => bsc_s_out, bsc_p_out => bsc_p_out
            );
            
            -- processing for clk period
            ck_period: process
            begin 
                clk <='0';
                wait for clk_period/2;
                clk <= '1';
                wait for clk_period/2;
            end process;
            -- run stimulus process
            stimulus: process
            begin 
            rst <= '1';
            wait for 100 ns;
                rst <= '0';
            wait for clk_period*10;
                bsc_p_in <= '0';
                bsc_s_in <= '1';
                bsc_csff_en <= '1';
                bsc_cs_mux_ctr <= '1';       -- setting this to shift mode
                wait for clk_period;
                bsc_1_ff_en <='1';
                bsc_1_mux_ctr <= '1';       -- setting to test mode
                wait for clk_period;
                bsc_1_mux_ctr <='0';        -- setting to normal mode
               wait;
               end process;
               
end Behavioral;
