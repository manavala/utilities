//##########
//command: vcs -ntb_opts uvm -sverilog simple.sv ; ./simv
//Questa
//export UVM_HOME=$QUESTA_HOME/verilog_src/uvm-1.2/src
//export QUESTA_UVM_HOME=$QUESTA_HOME/verilog_src/questa_uvm_pkg-1.2/src
//vlog simple.sv +incdir+$UVM_HOME/src $UVM_HOME/src/uvm_pkg.sv +incdir+$QUESTA_UVM_HOME $QUESTA_UVM_HOME/questa_uvm_pkg.sv
//vsim -c top -do "run -all; exit" -sv_lib $UVM_HOME/../../uvm-1.2/linux_x86_64/uvm_dpi 
//############

import uvm_pkg::*;

class test extends uvm_test;
  `uvm_component_utils (test)
  function new (string name="test", uvm_component parent=null);
    super.new (name, parent);
  endfunction
endclass

module top;
  initial run_test("test");
endmodule
