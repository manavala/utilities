--vcom print_check.vhd; vsim -c check -do "run -all; exit"

LIBRARY STD;
  USE STD.textio.ALL;

entity check is
end check;

architecture behavior of check is
begin
  simulation : process
  begin
    report "hi";
    wait;
  end process;
end behavior;
