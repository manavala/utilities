
/////////////////////////////////////////////////
//without action
//rm simv; vcs -ntb_opts uvm -sverilog simple.sv ; ./simv
//with action
//rm simv; vcs -ntb_opts uvm -sverilog simple.sv +plusarg_save +uvm_set_action="*,_ALL_,UVM_ERROR,UVM_EXIT" ; ./simv
/////////////////////////////////////////////////

//One problem with this, quit simulation immediately, it will be good if it can quit after some delay

import uvm_pkg::*;

class test extends uvm_test;
  `uvm_component_utils (test)                                                                                                                                                                                       
  function new (string name="test", uvm_component parent=null);
    super.new (name, parent);
    //just for understanding, don't be lazy, this code not good here, 
    //you will find something interesting if 'uvm_error' set before build, diff logs by commenting below uvm_error line
    `uvm_info   ( "id2",  " before error" , UVM_NONE )
    `uvm_error  ( "id2",  "err print"  )
    `uvm_info   ( "id2",  " after error" , UVM_NONE )
  endfunction

endclass

module top;
  initial run_test("test");
endmodule
                                 
