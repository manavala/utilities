
//vcs -full64 -sverilog -debug_access+all -lca -ntb_opts uvm file.sv
//./simv +UVM_TESTNAME=test

//This code is with virtual sequence

//************************************************************/
// Code for axi agent, actual protocol not used, just for
//virtual sequence connectivity checking
//************************************************************/

class axi_mseq_item extends uvm_sequence_item;
  rand logic [3:0] trans;
  `uvm_object_utils_begin(axi_mseq_item)
    `uvm_field_int(trans, UVM_ALL_ON)
  `uvm_object_utils_end
    function new(string name="axi_mseq_item");
      super.new(name);
    endfunction
endclass

class axi_mseq extends uvm_sequence#(axi_mseq_item);
  `uvm_object_utils(axi_mseq);
  function new(string name="axi_mseq");
    super.new(name);
  endfunction
  virtual task body();
    `uvm_do(req);
  endtask
endclass

class axi_mseqr extends uvm_sequencer#(axi_mseq_item);
  `uvm_component_utils(axi_mseqr);
  function new(string name="axi_mseqr", uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

class axi_mdrv extends uvm_driver#(axi_mseq_item);
  `uvm_component_utils(axi_mdrv);
  function new(string name="axi_mdrv", uvm_component parent);
    super.new(name,parent);
  endfunction
  task run_phase(uvm_phase  phase);
    seq_item_port.get_next_item(req);
    req.print();
    seq_item_port.item_done();
  endtask
endclass

class axi_mmon extends uvm_monitor;
  uvm_analysis_port #(axi_mseq_item) transaction_port;
  `uvm_component_utils(axi_mmon);
  function new(string name="axi_mmon", uvm_component parent);
    super.new(name, parent);
    transaction_port = new("transaction_port",this);
  endfunction
endclass

class axi_magt extends uvm_agent;
  axi_mseqr m_seqr;
  axi_mdrv m_drvr;
  axi_mmon m_mon;
  uvm_active_passive_enum is_active;
  `uvm_component_utils(axi_magt);
  function new(string name="axi_magt",uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    m_mon = axi_mmon::type_id::create("m_mon",this);
    if(is_active == UVM_ACTIVE) begin
      m_drvr = axi_mdrv::type_id::create("m_drvr",this);
      m_seqr = axi_mseqr::type_id::create("m_seqr",this);
    end
  endfunction
  function void connect_phase(uvm_phase phase);
    if(is_active == UVM_ACTIVE) begin
      m_drvr.seq_item_port.connect(m_seqr.seq_item_export);
    end
  endfunction

endclass


//************************************************************/
// Code for ahb agent, actual protocol not used, just for
//virtual sequence connectivity checking
//************************************************************/

class ahb_mseq_item extends uvm_sequence_item;
  rand logic [3:0] trans;
  `uvm_object_utils_begin(ahb_mseq_item)
    `uvm_field_int(trans, UVM_ALL_ON)
  `uvm_object_utils_end
    function new(string name="ahb_mseq_item");
      super.new(name);
    endfunction
endclass

class ahb_mseq extends uvm_sequence#(ahb_mseq_item);
  `uvm_object_utils(ahb_mseq);
  function new(string name="ahb_mseq");
    super.new(name);
  endfunction
  virtual task body();
    `uvm_do(req);
  endtask
endclass

class ahb_mseqr extends uvm_sequencer#(ahb_mseq_item);
  `uvm_component_utils(ahb_mseqr);
  function new(string name="ahb_mseqr", uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

class ahb_mdrv extends uvm_driver#(ahb_mseq_item);
  `uvm_component_utils(ahb_mdrv);
  function new(string name="ahb_mdrv", uvm_component parent);
    super.new(name,parent);
  endfunction
  task run_phase(uvm_phase  phase);
    seq_item_port.get_next_item(req);
    req.print();
    seq_item_port.item_done();
  endtask
endclass

class ahb_mmon extends uvm_monitor;
  uvm_analysis_port #(ahb_mseq_item) transaction_port;
  `uvm_component_utils(ahb_mmon);
  function new(string name="ahb_mmon", uvm_component parent);
    super.new(name, parent);
    transaction_port = new("transaction_port",this);
  endfunction
endclass

class ahb_magt extends uvm_agent;
  ahb_mseqr m_seqr;
  ahb_mdrv m_drvr;
  ahb_mmon m_mon;
  uvm_active_passive_enum is_active;
  `uvm_component_utils(ahb_magt);
  function new(string name="ahb_magt",uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    m_mon = ahb_mmon::type_id::create("m_mon",this);
    if(is_active == UVM_ACTIVE) begin
      m_drvr = ahb_mdrv::type_id::create("m_drvr",this);
      m_seqr = ahb_mseqr::type_id::create("m_seqr",this);
    end
  endfunction
  function void connect_phase(uvm_phase phase);
    if(is_active == UVM_ACTIVE) begin
      m_drvr.seq_item_port.connect(m_seqr.seq_item_export);
    end
  endfunction

endclass


//************************************************************/
// Code for env with thw two agents
//************************************************************/


class ahb_env extends uvm_env;
  `uvm_component_utils(ahb_env);
  ahb_magt ahb_magt_h;
  axi_magt axi_magt_h;
  function new(string name="ahb_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  function void build_phase(uvm_phase phase);
    ahb_magt_h = ahb_magt::type_id::create("ahb_magt_h",this);
    axi_magt_h = axi_magt::type_id::create("axi_magt_h",this);
    ahb_magt_h.is_active = UVM_ACTIVE;
    axi_magt_h.is_active = UVM_ACTIVE;
  endfunction
endclass

//************************************************************/
// Code for virtual sequence
//************************************************************/
class base_vseq extends uvm_sequence#(uvm_sequence_item);
  `uvm_object_utils(base_vseq);
  ahb_mseqr ahb_mseqr_h;
  axi_mseqr axi_mseqr_h;
  function new(string name="base_vseq");
    super.new(name);
  endfunction
endclass

class my_vseq extends base_vseq;
  `uvm_object_utils(my_vseq)

    /// Constructor
    function new (string name = "my_vseq");
      super.new(name);
    endfunction: new

    /// Sequence Body Task
    task body();

      ahb_mseq ahb_seq;
      axi_mseq axi_seq;

      ahb_seq = ahb_mseq::type_id::create("ahb_seq");
      axi_seq = axi_mseq::type_id::create("axi_seq");

      fork
        ahb_seq.start(ahb_mseqr_h);
        axi_seq.start(axi_mseqr_h);
      join
    endtask

endclass: my_vseq

//************************************************************/
// Code for env inst with testto exectue with the two agents
//************************************************************/

class test extends uvm_test;
  `uvm_component_utils(test);
  ahb_env env;
  //ahb_mseq ahb_mseq_h;
  //axi_mseq axi_mseq_h;
  my_vseq new_vseq;
  function new(string name="test",uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    env = ahb_env::type_id::create("env", this);
    //ahb_mseq_h = ahb_mseq::type_id::create("ahb_mseq_h",this);
    //axi_mseq_h = axi_mseq::type_id::create("axi_mseq_h",this);
    new_vseq = my_vseq::type_id::create("new_vseq",this);
  endfunction
  function void init_vseq(base_vseq vseq);
    vseq.ahb_mseqr_h = env.ahb_magt_h.m_seqr;
    vseq.axi_mseqr_h = env.axi_magt_h.m_seqr;
  endfunction
  function void end_of_elaboration_phase(uvm_phase phase);
    print();
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    init_vseq (new_vseq);
    `uvm_info(get_full_name(),"test starts",UVM_MEDIUM);
    //ahb_mseq_h.start(env.ahb_magt_h.m_seqr);
    //axi_mseq_h.start(env.axi_magt_h.m_seqr);
    new_vseq.start(null);
    `uvm_info(get_full_name(),"test ends",UVM_MEDIUM);
    phase.drop_objection(this);
  endtask
endclass

module top;
  initial run_test();
endmodule
