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
