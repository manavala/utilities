package sva_lib_test;                                                                                

  //building block, cannot triggers on its own, need 'assert'
  //implication operator not allowed
  //can be decl in mod, prog, pack, intf, scope, checker, generate, clk blk and not in "class"
  sequence sr1(req, gnt);
    //clock can be speciefied here also
    //should be edge, cannot be latch, can be gated clk like (clk && slct_sig)
    req ##2 gnt;
  endsequence

  //decl rules same seq
  //cannot act itself, needs 'assert'
  property pr1(clk, req, gnt, start); //Formal Arguments --> 'formal' .. In formal verification, the formal values are exercised by 
    //for formal algorithm by formal tools
    //values are "sampled" at 'preponed region' == 'value from previous time slot'
    @(posedge clk) start |-> sr1(req, gnt);
  endproperty

endpackage

module test;

  import sva_lib_test::*;

  bit clk;
  bit start, req;
  reg gnt=0;

  initial forever #5 clk = !clk;

  //Following are examples of immediate assertions
  //initial assert(0);
  //always @() .. assert (??)
  
  //Following is concurrent assertion
  //Assertions are evaluated in observed region
  chk_req_gnt: assert property ( pr1(clk, req, gnt, start) ) //Actual Arguments 
                  $display(" [%0t] pass",$realtime); //Action blocks - Evaluated at Reactive region
               else
                 $display(" [%0t] fail",$realtime); //Action blocks - Evaluated at Reactive region

  initial begin
    stim(1);//pass
    stim(0);//fail //x,z,0 are evaluated as fail
    stim(1'bx);//fail
    stim(1'bz);//fail
    @(posedge clk);
    $finish;
  end
  
  task stim(input bit stat);
    @(posedge clk);
    start = 1;
    req = 1;
    @(posedge clk);
    start = 0;
    req = 0;
    @(posedge clk);
    gnt = stat;
    @(posedge clk);
  endtask
  
  initial $monitor(" [%0t] clk %0d start=%0d req=%0d gnt=%0d",$realtime,clk,start,req,gnt);

endmodule
