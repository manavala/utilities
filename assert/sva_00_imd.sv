package sva_lib;                                                                                     

  sequence sr1(req,gnt);
    req ##2 gnt;
  endsequence

  property pr1(clk, req, gnt, start);
    @(posedge clk) start |-> sr1(req, gnt);
  endproperty

endpackage

module test;

  import sva_lib::*;

  bit clk;
  bit start, req, gnt;

  initial forever #5 clk = !clk;

  chk_req_gnt: assert property ( pr1(clk, req, gnt, start) ) $display("pass"); 
                                 else $display("fail"); 
  initial begin
    stim(1);//pass
    stim(0);//fail
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

  initial $monitor(" clk %0d start=%0d req=%0d gnt=%0d",clk,start,req,gnt);

endmodule
