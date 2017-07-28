package sva_lib_test;                                                                                

  sequence sr1(req, gnt);
    //clock can be speciefied here also
    //should be edge, cannot be latch, can be gated clk like (clk && slct_sig)
    req ##2 gnt;
  endsequence

  property pr1(clk, req, gnt, start); //Formal Arguments
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
