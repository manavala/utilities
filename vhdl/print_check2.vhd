--in questa, vcom file_name; vsim -c top_entity_name -do 'run -all; exit'

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;   -- function conv_integer
use IEEE.std_logic_textio.all;
use IEEE.numeric_std.all;
LIBRARY STD;
USE STD.textio.ALL;

entity check is                         
  end check;

architecture behavior of check is
begin
  
  simulation : process is
    variable A : integer :=10;
    variable B : std_logic := '1';
    variable vectB : std_logic_vector(3 downto 0) := "1000";
    variable s : line;
    variable cnt : integer:=0;           
  begin
    report "hi";
    report "A value is" & integer'image(A);
    report "B value is" & std_logic'image(B);            
    for i in 0 to vectB'LENGTH-1 loop
      report "vectB("&integer'image(i)&") value is" & std_logic'image(vectB(i));
    end loop;  
    for i in 0 to 15 loop
      cnt:=cnt+1;
      write(s,string'("Count "));
      write(s,i);
      write(s,string'(" "));
      write(s,cnt);
      writeline(output,s);
    end loop;
    wait;
  end process;
end behavior;
