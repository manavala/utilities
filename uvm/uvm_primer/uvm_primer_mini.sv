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
