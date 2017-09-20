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
