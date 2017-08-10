//######## prints uvm base phases

import uvm_pkg::*;

class test extends uvm_test;
  `uvm_component_utils (test)
  function new (string name="test", uvm_component parent=null);
    super.new (name, parent);
  endfunction

  //all phases are polymorphed, explicity add word "virtual" for better understanding
  //don't be lazy

 virtual function void build_phase(uvm_phase phase);
   $display("%m");
 endfunction
 
 virtual function void connect_phase(uvm_phase phase);
   $display("%m");
 endfunction

 virtual function void end_of_elaboration_phase(uvm_phase phase);
   $display("%m");
 endfunction

 virtual function void start_of_simulation_phase(uvm_phase phase);
   $display("%m");
 endfunction

 virtual task run_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual function void extract_phase(uvm_phase phase);
   $display("%m");
 endfunction

 virtual function void report_phase(uvm_phase phase);
   $display("%m");
 endfunction

 virtual function void check_phase(uvm_phase phase);
   $display("%m");
 endfunction

 virtual function void final_phase(uvm_phase phase);
   $display("%m");
 endfunction

endclass

module top;
  initial run_test("test");
endmodule
