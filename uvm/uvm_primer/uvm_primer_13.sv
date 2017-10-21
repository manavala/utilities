// set file='../uvm_primer_13.sv' ; vcs -full64 -sverilog -debug_access+all -lca $file -ntb_opts uvm ;\
//if ( $status == 0 ) ./simv +UVM_TESTNAME=test +UVM_NO_RELNOTES +uvm_set_inst_override=agt_1,agt_2,uvm_test_top.e1.a \
//+uvm_set_inst_override=agt_1,agt_3,uvm_test_top.e1.b +uvm_set_type_override=agt_1,agt_4,1 +uvm_set_type_override=agt_1,agt_5,0

import uvm_pkg::*;

`define UVM_AGT(class_name, type)\
class class_name extends type;\
  `uvm_component_utils(class_name);\
  function new(string name, uvm_component parent);\
    super.new(name,parent);\
    `uvm_info(get_full_name(), `"``class_name``_new`", UVM_MEDIUM);\
  endfunction\
  virtual function void hello();\
    `uvm_info(get_full_name(), `"``class_name``_hello`", UVM_MEDIUM);\
  endfunction\
endclass

`UVM_AGT(agt_1, uvm_agent);
`UVM_AGT(agt_2, agt_1);
`UVM_AGT(agt_3, agt_1);
`UVM_AGT(agt_4, agt_1);
`UVM_AGT(agt_5, agt_1);
`UVM_AGT(agt_6, agt_1);
`UVM_AGT(agt_7, agt_1);
`UVM_AGT(agt_8, agt_1);
`UVM_AGT(agt_9, agt_1);

class env extends uvm_env;
  `uvm_component_utils(env);

  agt_1 a,b,c,d,e,f,g,h;

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    a=agt_1::type_id::create("a",this);
    b=agt_1::type_id::create("b",this);
    c=agt_1::type_id::create("c",this);
    d=agt_1::type_id::create("d",this);
    e=agt_1::type_id::create("e",this);
    f=agt_1::type_id::create("f",this);
    g=agt_1::type_id::create("g",this);
    h=agt_1::type_id::create("h",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    a.hello();
    b.hello();
    c.hello();
    d.hello();
    e.hello();
    f.hello();
    g.hello();
    h.hello();
  endfunction

endclass

class test extends uvm_test;
  `uvm_component_utils(test);
  env e1;

  function new(string name="test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e1 = env::type_id::create("e1", this);

    //override using full instance
    factory.set_inst_override_by_name("agt_1","agt_6","uvm_test_top.e1.e");
    factory.set_inst_override_by_type(agt_1::get_type(),agt_7::get_type(),{get_full_name(),".","e1.f"});

    //override using type
    factory.set_type_override_by_name("agt_1","agt_8"); //will replace all instead of particular instance 
    // if both type and inst act, first type method override applied and then inst method again overrides on top of that
    factory.set_type_override_by_type(agt_1::get_type(),agt_9::get_type()); //will replace all instead of particular instance 

  endfunction

endclass

program top;
  initial run_test();
endprogram 
