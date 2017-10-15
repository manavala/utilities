/// set file='../uvm_primer_12.sv' ; vcs -full64 -sverilog $file -ntb_opts uvm ; if ( $status == 0 ) ./simv +UVM_TESTNAME=hello_world_test +uvm_set_config_string=uvm_test_top,message,'Hello World!' -l sim.log

program test;
  import uvm_pkg::*;

  class hello_world_test extends uvm_test;

    string msg;
    `uvm_component_utils(hello_world_test)

    function new(string name ,uvm_component parent );
      super.new(name, parent);
      msg="message";
    endfunction
    
    virtual task run_phase(uvm_phase phase);
      uvm_config_db#(string)::get(this,"","message",msg);
      `uvm_info("demo",msg,UVM_NONE);
    endtask
  
  endclass
  
  initial begin
    run_test();
  end

endprogram
