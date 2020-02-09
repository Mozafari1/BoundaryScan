----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari
-- 
-- Create Date: 07.02.2020 07:31:05
-- Design Name: 
-- Module Name: tb_tap - Behavioral
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

entity tb_tap is
--  Port ( );
end tb_tap;

architecture Behavioral of tb_tap is
    component tap
                    port (
                         tms,clk, rst: in std_logic;
                        tlr_on,capt_dr_on, shift_dr_on, updt_dr_on, shift_ir_on, updt_ir_on,capt_ir_on : out std_logic
                        
                        );
    end component;
    
    --- Signal 
    signal tms, clk, rst: std_logic :='0';
   
    signal tlr_on,capt_dr_on, shift_dr_on, updt_dr_on, shift_ir_on, updt_ir_on,capt_ir_on: std_logic :='0';
    
    constant clk_period: time :=10ns;
    
begin
        -- UUT
        uut: tap port map(
                           tms => tms, clk => clk, rst => rst,
                           tlr_on => tlr_on, 
                           capt_dr_on => capt_dr_on, shift_dr_on => shift_dr_on, updt_dr_on => updt_dr_on,
                           capt_ir_on => capt_ir_on, shift_ir_on => shift_ir_on, updt_ir_on => updt_ir_on
                           
        
                            );
-- clock process 
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2; 
    end process;
    
    -- stimulus process
    
    stimulus: process
        begin
        rst  <='1';
        wait for clk_period*5;
        rst <= '0';
        wait for clk_period*2;
        --- EXTEST
        tms <= '0';
        wait for clk_period;
        tms <= '0';
        wait for clk_period;
        tms <= '0';
        wait for clk_period;
        tms <= '0';
        ------ SP
        wait for clk_period;
        tms <= '1';
        wait for clk_period;
        tms <= '0';
        wait for clk_period;
        tms <= '0';
        wait for clk_period;
        tms <= '1';
        wait for clk_period;       
        --- BYPASS
        tms <= '1';
        wait for clk_period;
        tms <= '1';
        wait for clk_period;
        tms <= '1';
        wait for clk_period;
        tms <= '1';
       wait;
        end process;
end Behavioral;
