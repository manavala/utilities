
import uvm_pkg::*;

class seq extends uvm_sequence;
  `uvm_object_utils(seq);
  function new(string name="seq");
    super.new(name);
  endfunction
  string msg;
  task body;
    if (uvm_config_db #(string) :: get (null, "*", "message", msg))
      `uvm_info ("SEQ", $sformatf ("Message is %s", msg), UVM_MEDIUM)
  endtask
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  seq s1;
  function new(string name, uvm_component parent);
    super.new(name,parent);
    s1 = seq::type_id::create("seq");
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1.start(null);
    phase.drop_objection(this);
  endtask
endclass

module top;
  initial run_test("test");
  initial uvm_config_db #(string) :: set (null, "*", "message", "***from_top***");
endmodule
