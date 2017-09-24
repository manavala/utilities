//## Level 1
class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item);
  function new(string name="seq_tem");
    super.new(name);
  endfunction
endclass

module top;
  seq_item seq1;
  initial begin
    seq1=seq_item::type_id::create("seq1");
    seq1.print();
  end
endmodule


//## Level 2

class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item);
  function new(string name="seq_item");
    super.new(name);
  endfunction
endclass

class seq_item_0 extends seq_item;
  `uvm_object_utils(seq_item_0);
  function new(string name="seq_item_0");
    super.new(name);
  endfunction
endclass

module top;
  seq_item_0 seq1;
  initial begin
    seq1=seq_item_0::type_id::create("seq1");
    seq1.print();
    seq1.set_depth(5);
    $display(" get_depth()  %0d" ,seq1.get_depth());
    $display(" is_item() %0d" ,seq1.is_item());
    $display(" get_root_sequence_name() %s",seq1.get_root_sequence_name());
    $display(" get_sequence_path() %s",seq1.get_sequence_path());
  end
endmodule


////Level 3
class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item);
  function new(string name="seq_item");
    super.new(name);
  endfunction
endclass

class seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(seq);
  function new(string name="seq");
    super.new(name);
  endfunction
  //UVM warning: body defintion undefined
  task body;
  endtask
endclass

typedef uvm_sequencer #(seq_item) sequencer;

class drv extends uvm_driver #(seq_item);
  `uvm_component_utils(drv);
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction
endclass

class test extends uvm_test;
  `uvm_component_utils(test);
  seq_item trans;
  drv drv_h;
  sequencer seqr_h;
  seq seq_h;
  function new(string name="test", uvm_component parent=null);
    super.new(name,parent);
    trans = seq_item::type_id::create("seq_h");
    seq_h = seq::type_id::create("seq_h");
    drv_h = drv::type_id::create("drv_h",this); //new("drv_h");
    seqr_h= sequencer::type_id::create("seqr",this); //new("seqr_h",this);
    //ignore if connect is attempt  at or after end_of_elaboration phase
    drv_h.seq_item_port.connect(seqr_h.seq_item_export);
  endfunction
    function void end_of_elaboration();
    uvm_top.print_topology (); 
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq_h.start(seqr_h); //error start() method not found
    phase.drop_objection(this);
  endtask
endclass

module top;
  initial begin
    run_test("test");
  end
endmodule

///// Level 4
/*******************************************************************
** sequence_item: abstracted package of the transaction
//
*******************************************************************/
class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item);
  function new(string name="seq_item");
    super.new(name);
  endfunction
endclass

/*******************************************************************
** sequence:  protocol or actual test sequence 
**            or individual or sequence of seqeuces
*******************************************************************/
class seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(seq);
  function new(string name="seq");
    super.new(name);
  endfunction
  //UVM warning: body defintion undefined
  task body;
    seq_item trans;
    trans = seq_item::type_id::create("trans");
    //start_item //finish_item //uvm_do //randomize
    trans.print();
  endtask
endclass

/*******************************************************************
** sequencer: mostly not needed unless something need to extend 
//
*******************************************************************/
typedef uvm_sequencer #(seq_item) sequencer;

/*******************************************************************
** driver:  protocol specific of dut, directly talks with dut with 
**          virtual (pointer) interface
*******************************************************************/
class drv extends uvm_driver #(seq_item);
  `uvm_component_utils(drv);
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction
endclass

/*******************************************************************
** monitor: monitor dut transactions as same as driver method,
**          this won't drive just monitors
**          can email subscribers to scoreboard / checkers
*******************************************************************/
class mon extends uvm_monitor;
  `uvm_component_utils(mon);
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction
endclass

/*******************************************************************
** agent: controls whether this interface/protocol specific agent is
**        just monitor or also drives
*******************************************************************/
class agent extends uvm_agent;
  `uvm_component_utils(agent);
  drv drv_h;
  sequencer seqr_h;
  mon mon_h;
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    drv_h = drv::type_id::create("drv_h",this);
    seqr_h= sequencer::type_id::create("seqr_h",this);
    mon_h = mon::type_id::create("mon_h",this);
  endfunction
  function void connect_phase(uvm_phase phase);
    //ignore if connect is attempt  at or after end_of_elaboration phase
    drv_h.seq_item_port.connect(seqr_h.seq_item_export);
  endfunction
endclass

/*******************************************************************
** env: decides whether its agents can be drive or just monitors
**      single driver and multiple montior agents are possible
*******************************************************************/
class env extends uvm_env;
  `uvm_component_utils(env);
  agent agnt_h;
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    agnt_h = agent::type_id::create("agnt_h",this);
  endfunction
endclass

/*******************************************************************
** test: 1. instantiate structure componet(env and its inside)
**          which will be available throught sim
**       2. create data part sequences and which may be deleted once
**          sent and not required anymore to save memory
*******************************************************************/
class base_test extends uvm_test;
  `uvm_component_utils(base_test);
  sequencer seqr_h;
  env env_h;
  seq seq_h;
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    env_h = env::type_id::create("env_h",this);
    seq_h = seq::type_id::create("seq_h");
  endfunction
  function void end_of_elaboration_phase(uvm_phase phase);
    if(!$cast(seqr_h,uvm_top.find("*.env_h.agnt_h.seqr_h")))
      $fatal("can't copy handle");
    uvm_top.print_topology();
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq_h.start(seqr_h);
    `uvm_info(get_full_name(),"test completed",UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass

module top;
  initial begin
    run_test("base_test");
  end
endmodule

