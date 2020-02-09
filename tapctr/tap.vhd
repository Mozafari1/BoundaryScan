----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Rahmat Mozafari 
-- 
-- Create Date: 05.02.2020 07:39:59
-- Design Name: 
-- Module Name: tap - Behavioral
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

entity tap is
  Port (
        tms, rst, clk: in std_logic;
        tlr_on,capt_dr_on, shift_dr_on, updt_dr_on: out std_logic;
        shift_ir_on, updt_ir_on,capt_ir_on : out std_logic
   );
end tap;

architecture Behavioral of tap is
type state_type is (
                    tlr,rti,
                    sldr, cpdr, shdr,ex1dr, padr,ex2dr, updr,
                    slir, cpir, shir,ex1ir, pair,ex2ir, upir
);
signal state_reg, state_nxt: state_type;


begin
process (clk, rst)
begin
    if (rst ='1') then
        state_reg <=tlr;
    elsif (clk'event and clk ='1')then
        state_reg <= state_nxt;    
   end if;
   end process;
   
process(state_reg, tms)
begin
   state_nxt <= state_reg;  -- Defualt value
   tlr_on <= '0';
   capt_dr_on<='0';
   shift_dr_on<='0'; 
   updt_dr_on <='0';
   capt_ir_on <= '0'; 
   shift_ir_on<='0'; 
   updt_ir_on <='0';
    
     case state_reg is
        when tlr => 
            tlr_on <= '1';  -- TLR
            if (tms ='0')then 
                state_nxt <= rti;
           
             end if;
        when rti =>
            if (tms ='1') then
                state_nxt <= sldr;
           
            end if;
         when sldr => 
            if (tms= '1') then
                state_nxt <= slir;
            else
                state_nxt <= cpdr;
            end if;
        when slir => 
            if (tms ='1') then 
                state_nxt <= tlr;
            else
                state_nxt <= cpir;
            end if;    
       when cpir => 
            capt_ir_on <= '1';
            if (tms ='1') then
                state_nxt <= ex1ir;
            else
                state_nxt <= shir;
            end if;
       when shir => 
            shift_ir_on <= '1';
            if(tms='1') then 
                state_nxt <= ex1ir;
            
            end if;
       when ex1ir =>
            if(tms ='1') then 
                state_nxt <= upir;
            else 
                state_nxt <= pair;
            end if ;
      when pair => 
            if(tms ='1') then 
                state_nxt <= ex2ir;
           
           end if;                           
      when ex2ir =>
        if (tms='1') then 
            state_nxt <= upir;
        else
            state_nxt <= shir;
        end if;
     when upir =>
        updt_ir_on <='1';
            if(tms ='1') then 
                state_nxt <= sldr;
            else 
                state_nxt <= rti;
            end if;

                when cpdr =>
                capt_dr_on <= '1';
                    if (tms ='1') then 
                       state_nxt <= ex1dr;
                    else
                       state_nxt <= shdr;
                   end if;
                   
             when shdr =>
             shift_dr_on <= '1';
                if(tms ='1') then 
                    state_nxt <= ex1dr;
                
                end if;
              when ex1dr =>
                if (tms='1') then 
                    state_nxt <= updr;
                else
                    state_nxt <= padr;
                end if;
               when padr =>
                    if (tms ='1') then 
                        state_nxt <= ex2dr;
                    
                    end if;
              when ex2dr =>
                if (tms ='1') then 
                    state_nxt <= updr;
                else 
                    state_nxt <= cpdr;
                end if;
                
              when updr =>
                updt_dr_on <= '1';
                    if (tms ='1') then 
                        state_nxt <= sldr;
                    else
                        state_nxt <= rti;
                   end if;               
        end case;
        end process;
end Behavioral;
