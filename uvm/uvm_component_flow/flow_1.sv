//vcs -R -sverilog -full64 -ntb_opts uvm file.sv

import uvm_pkg::*;
class test extends uvm_test;
  `uvm_component_utils(test);
  function new(string name="test", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  virtual task run_phase(uvm_phase phase);
    $display("test working");
  endtask
endclass

class test2 extends uvm_test;
  `uvm_component_utils(test2);
  function new(string name="test2", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  virtual task run_phase(uvm_phase phase);
    $display("test2 working");
  endtask
endclass

program top;
  initial begin
    test t1=new();
    test2 t2=new();
    run_test;
  end
endprogram
