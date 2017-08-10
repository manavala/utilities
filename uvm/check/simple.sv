//##########
//command: vcs -ntb_opts uvm -sverilog simple.sv ; ./simv
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
