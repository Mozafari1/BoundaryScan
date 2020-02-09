
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari
-- 
-- Create Date: 09.02.2020 14:59:36
-- Design Name: Boundary Scan
-- Module Name: tb_toplevel - Behavioral
-- Project Name: Boundary Scan 
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

entity tb_toplevel is
--  Port ( );
end tb_toplevel;

architecture Behavioral of tb_toplevel is
component toplevel
    port(
             clk, rst, tms, tdi: in std_logic;
             tdo: out std_logic
        );
end component;
SIGNAL clk, rst, tms, tdi: std_logic :='0';
signal tdo: std_logic;
CONSTANT clk_period : time :=10ns;

begin
 -- UUT
    uut: toplevel port map(
                    clk => clk, rst => rst, tms => tms, tdi =>tdi, tdo =>tdo
                  );
clk_process :process
                  begin
                      clk <='0';
                      wait for clk_period/2;
                      clk <='1';
                      wait for clk_period/2;
            end process;      
            
-- stimulus process
stimulus :process
                begin
                rst <= '1';
                wait for clk_period*5;
                rst <='0';
                wait for clk_period*2;
                tdi <= '1';
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
