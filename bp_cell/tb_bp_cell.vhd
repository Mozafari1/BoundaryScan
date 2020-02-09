----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari 
-- 
-- Create Date: 09.02.2020 10:32:00
-- Design Name: 
-- Module Name: tb_bp_cell - Behavioral
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

entity tb_bp_cell is
--  Port ( );
end tb_bp_cell;

architecture Behavioral of tb_bp_cell is
component bp_cell
	port(
		clk,rst: in std_logic; 
		bpc_p_in,bpc_s_in: in std_logic; 
		bpc_csff_en,bpc_cs_mux_ctr: in std_logic;
		bpc_s_out: out std_logic
		);
	end component;
	
    --inputs
    signal clk,rst: std_logic := '0';
    signal bpc_p_in,bpc_s_in: std_logic := '0';
    signal bpc_csff_en,bpc_cs_mux_ctr: std_logic := '0';
    
    --outputs
    signal bpc_s_out: std_logic;
    
    --clock period definitions
    constant clk_period : time := 10 ns;
begin
--instantiate the Unit Under Test (UUT)
	uut: bp_cell Port map (
		clk => clk,
		rst => rst,
		bpc_p_in => bpc_p_in,
		bpc_s_in => bpc_s_in,
		bpc_csff_en => bpc_csff_en,
		bpc_cs_mux_ctr => bpc_cs_mux_ctr,
		bpc_s_out => bpc_s_out
		);
		
	--clock process definitions
	clk_process: process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	
	--stimulus process
	stim_proc: process
begin
            rst <= '1';
            wait for 100 ns;
                rst <= '0';
            wait for clk_period*10;
                bpc_p_in <= '0';
                bpc_s_in <= '1';     --TDI
                bpc_csff_en <= '1';
                bpc_cs_mux_ctr <= '0';     -- '1' for Shift mode, '0' for Capture mode
            wait;
        end process;

end Behavioral;
