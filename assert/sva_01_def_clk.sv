package sva_lib_test;                                                                                                

  sequence sr1(req, gnt);
    //clock can be speciefied here also
    //should be edge, cannot be latch, can be gated clk like (clk && slct_sig)
    req ##2 gnt;
  endsequence

  property pr1(req, gnt, start); //Formal Arguments
    //values are "sampled" at 'preponed region' == 'value from previous time slot'
    start |-> sr1(req, gnt);
  endproperty

endpackage

module test;

  import sva_lib_test::*;

  bit clk, clk2;
  bit start, req;
  reg gnt=0;

  initial forever #5 clk = !clk;

  assign clk2 = ~clk;

  //Assertions are evaluated in observed region
  //uses default clk
  chk_req_gnt: assert property ( pr1(req, gnt, start) ) //Actual Arguments 
                  $display(" [%0t] pass",$realtime); //Action blocks - Evaluated at Reactive region
               else
                 $display(" [%0t] fail",$realtime); //Action blocks - Evaluated at Reactive region
  //uses cb2 clk
  chk_st_req: assert property ( @cb2 start |-> req )
                  $display(" [%0t] pass 1",$realtime);
               else
                 $display(" [%0t] fail 1",$realtime);

  initial begin
    stim(1);//pass
    stim(0);//fail //x,z,0 are evaluated as fail
    stim(1'bx);//fail
    stim(1'bz);//fail
    @(posedge clk);
    $finish;
  end

  //clock automatically inherits to property, sequences which doesn't have overrite clock
  default clocking cb1
    @(posedge clk);
  endclocking

  clocking cb2
    @(posedge clk2);
  endclocking

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
