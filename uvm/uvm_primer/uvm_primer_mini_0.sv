/*******************************************************************
** seq_item: abstracted package of the transaction
**
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
**
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
  uvm_analysis_port #(seq_item) ap;
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    ap=new("ap",this);
  endfunction
  task run_phase(uvm_phase phase);
    //remember don't link/depend with driver
    //in passive, this has to run independently
    //actually this is not required, to send fake pkt, adding here
    //actually virtual interface will be instantiated
    //from that analysed automatically
    seq_item s1;
    forever begin
      ap.write(s1);
      #10;
    end
  endtask
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
    uvm_config_db #(mon)::set(null,"*","mon",mon_h);
  endfunction
  function void connect_phase(uvm_phase phase);
    //ignore if connect is attempt  at or after end_of_elaboration phase
    drv_h.seq_item_port.connect(seqr_h.seq_item_export);
  endfunction
endclass


/*******************************************************************
** coverage : one of uvm subscriber
**
*******************************************************************/
class coverage extends uvm_subscriber#(seq_item);
  `uvm_component_utils(coverage);
  function new(string name,uvm_component parent);
    super.new(name,parent);
    //create cov instance
  endfunction
  function void write(seq_item t);
    `uvm_info(get_full_name(),"will sample",UVM_NONE);
  endfunction
endclass

/*******************************************************************
** scoreboard : other uvm subscriber
**
*******************************************************************/
class scoreboard extends uvm_subscriber#(seq_item);
  `uvm_component_utils(scoreboard);
  uvm_tlm_analysis_fifo #(seq_item) seq_fifo;
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    seq_fifo = new("seq_fifo",this);
  endfunction
  function void write(seq_item t);
    `uvm_info(get_full_name(),"will check",UVM_NONE);
    //if just tx, check protocol
    //if rx, verify with sent saved tx from seq_fifo
    $display(seq_fifo.is_empty());
  endfunction
endclass

/*******************************************************************
** env: decides whether its agents can be drive or just monitors
**      single driver and multiple montior agents are possible
*******************************************************************/
class env extends uvm_env;
  `uvm_component_utils(env);
  agent agnt_h;
  scoreboard chk_h;
  coverage cov_h;
  mon mon_h;
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    agnt_h  = agent::type_id::create("agnt_h",this);
    cov_h   = coverage::type_id::create("cov_h",this);
    chk_h   = scoreboard::type_id::create("chk_h",this);
  endfunction
  function void connect_phase(uvm_phase phase);
    if(!uvm_config_db#(mon)::get(this,"","mon",mon_h))
      $fatal("failed to get monitor from agent");
    mon_h.ap.connect(cov_h.analysis_export);
    mon_h.ap.connect(chk_h.analysis_export);
    mon_h.ap.connect(chk_h.seq_fifo.analysis_export);
  endfunction
endclass

/*******************************************************************
** test: 1. instantiate structure componet(env and its inside)
**          which will be available throught sim
**       2. create data part sequences and which may be deleted once
**          sent and not required anymore to save memory
*******************************************************************/
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
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    env_h = env::type_id::create("env_h",this);
  endfunction
  function void end_of_elaboration_phase(uvm_phase phase);
    //this doesn't need casting
    if(!$cast(seqr_h,uvm_top.find("*.env_h.agnt_h.seqr_h")))
      $fatal("can't copy handle");
  endfunction
endclass

/*******************************************************************
** test: just to 'start' actual sequence for actual test
*******************************************************************/
class test extends base_test;
  `uvm_component_utils(test);
  seq seq_h;
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq_h = seq::type_id::create("seq_h");
  endfunction
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
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
    run_test("test");
  end
endmodule
