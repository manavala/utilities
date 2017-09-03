                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
import uvm_pkg::*;  `include "uvm_macros.svh"

class mem_seq_item extends uvm_sequence_item;

  //control variable
  rand bit wr_en;
  rand bit rd_en;
  rand bit [3:0] addr;

  //payload
  rand bit [7:0] wdata;

  //analysis
  bit [7:0] rdata;

  //utility and field macros
  `uvm_object_utils_begin(mem_seq_item)
    `uvm_field_int(wr_en,UVM_ALL_ON)
    `uvm_field_int(rd_en,UVM_ALL_ON)
    `uvm_field_int(addr ,UVM_ALL_ON)
    `uvm_field_int(wdata,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name ="mem_seq_item");
    super.new(name);
  endfunction

  constraint wr_rd_c { wr_en != rd_en; };

endclass

class mem_sequence extends uvm_sequence # (mem_seq_item);

  `uvm_object_utils(mem_sequence);

  function new(string name = "mem_sequence");
    super.new(name);
  endfunction

  virtual task body();
  /*0*/  req = mem_seq_item::type_id::create("req");
  /*1*/  wait_for_grant();
  /*2*/  req.randomize();
  /*3*/  send_request(req);
  /*4*/  wait_for_item_done();
  /*5*/  get_response(rsp);
  endtask

/*
  virtual task body();
    `uvm_do(req);
///////
`uvm_do(req);
/////
`uvm_create(req);
req.randomeize();
`uvm.send(req);
/////
`uvm_create(req);
`uvm_rand_send(req);
///
`uvm_do_with(req,{wr_en == 1;});
///
`uvm_create();
`uvm_rand_send_with(req,{rd_en==1;});
///
  endtask
*/
endclass
/*
class wr_rd_seq extends uvm_sequence #(mem_seq_item);
  write_sequence wr_seq;
  read_sequence rd_seq;

  `uvm_object_utils(wr_rd_seq);

  function new(string name="wr_rd_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_do(wr_seq);
    `uvm_do(rd_seq);
  endtask

endclass
*/
//copy needs created
//clone = copy + create

module seq_item_tb;

  mem_seq_item seq_item;
  mem_seq_item seq_item_1;

  initial begin
    //create method
    seq_item = mem_seq_item::type_id::create();
    //seq_item_1 = mem_seq_item::type_id::create();

    void'(seq_item.randomize());

    seq_item.print();

    //seq_item_1.copy(seq_item);

    $cast(seq_item_1, seq_item.clone());

    seq_item_1.addr = 2;

    seq_item_1.print();

    if(seq_item.compare(seq_item_1)) `uvm_info("","mtach",UVM_LOW)
    else `uvm_error("","mismatch")

    seq_item_1.addr = seq_item.addr;

    if(seq_item.compare(seq_item_1)) `uvm_info("","mtach",UVM_LOW)
    else `uvm_error("","mismatch")

  end

endmodule
