//#!/bin/csh
//set file='../uvm_primer_10.sv' ; \
//vcs -full64 -sverilog -debug_access+all -lca ../uvm_primer_10.sv -ntb_opts uvm ; \
//if ( $status == 0 ) bsub -Ip ./simv -l sim.log 


//Level 1

class test_for_cfg extends uvm_test;

  `uvm_component_utils(test_for_cfg)

  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    int b;
    $display("%m");
    if(!uvm_config_db #(int)::get(this, "", "a", b))
      $fatal("cannot get");
    $display(b);
  endfunction
                                                                                                                                                                                                       
endclass

module top;
  int a;
  initial begin
    uvm_config_db #(int)::set(null, "uvm_test_top", "a", 5);
    run_test("test_for_cfg");
  end
endmodule


//Level 2

class dummy;
  function void dis();
    $display("it is dummy");
  endfunction
endclass

class test_for_cfg extends uvm_test;

  `uvm_component_utils(test_for_cfg)

  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    dummy d2;
    $display("%m");
    if(!uvm_config_db #(dummy)::get(this, "", "dummy", d2))
      $fatal("cannot get");
    d2.dis();
  endfunction

endclass

module top;
  dummy d1;
  initial begin
    d1=new();
    //uvm_config_db #(dummy)::set(null, "uvm_test_top", "dummy", d1); //only uvm_test_top can access it
    uvm_config_db #(dummy)::set(null, "*", "dummy", d1); //anybody can access
    //uvm_config_db #(dummy)::set(null, "test_for_cfg", "dummy", d1); //uvm_fatal_at get method
    run_test("test_for_cfg");
  end   
endmodule

