
//will execute the phases in "alphabetical order" as there is no parent associated for bottom_top or top_bottom flows
//vcs -R -full65 -sverilog -ntb_opts uvm file.sv

import uvm_pkg::*;

`define CLASS_TEMP(cl_name,cl_type)\
class cl_name extends cl_type;\
  `uvm_component_utils(cl_name);\
  function new(string name="``cl_name``",uvm_component parent=null);\
    super.new(name,parent);\
  endfunction\
  virtual task run_phase(uvm_phase phase);\
    print();\
    $display("%0s running",m_name);\
  endtask\
endclass

`CLASS_TEMP(seqr, uvm_sequencer);
`CLASS_TEMP(drvr, uvm_driver);
`CLASS_TEMP(mon,uvm_monitor);
`CLASS_TEMP(agt,uvm_agent);
`CLASS_TEMP(env, uvm_env);
`CLASS_TEMP(test, uvm_test);

program top;
  initial begin
    seqr s1=new("seqr_s1");
    drvr d1=new("drvr_d1");
    mon  m1=new("mon_m1");
    agt  a1=new("agt_a1");
    test t1=new("test_t1");
    run_test;
  end
endprogram 
