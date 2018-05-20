//// assertion triggers the coverage module
/// qverilog codes.sv

module top;

  bit a;
  bit from_assert;

  bit clk;

  always #5 clk = ~clk;

   covergroup cg;
     sig: coverpoint a;
   endgroup

   cg cg_inst =new();

   always@(from_assert) cg_inst.sample();

   sequence var_assign;
     1;
   endsequence

   property test_var;
     @(posedge clk) var_assign;
   endproperty

   assert property(test_var) from_assert = ~from_assert;

   initial #10000 $finish;

   initial #100 a=~a;  
   
   final begin
    $display("Instance coverage is %0d",cg_inst.get_coverage());
   end

endmodule
