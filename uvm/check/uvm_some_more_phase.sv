
import uvm_pkg::*;

class test extends uvm_test;

  `uvm_component_utils (test)

  function new (string name="test", uvm_component parent=null);
    super.new (name, parent);
  endfunction

 virtual function void phase_started (uvm_phase phase);
   $display("%m");
 endfunction

 virtual function void phase_ready_to_end (uvm_phase phase);
   $display("%m");
 endfunction

 virtual function void phase_ended (uvm_phase phase);
   $display("%m");
 endfunction

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
 
 virtual task pre_reset_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task reset_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task post_reset_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task pre_configure_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task configure_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task post_configure_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task pre_main_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task main_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task post_main_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task pre_shutdown_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task shutdown_phase(uvm_phase phase);
   $display("%m");
 endtask

 virtual task post_shutdown_phase(uvm_phase phase);
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
