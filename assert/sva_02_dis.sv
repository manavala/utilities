module test;

  bit reset=0,clk,sig;

  always #5 clk=~clk;

  chk_rst: assert property ( @(posedge clk)
                             disable iff (reset) //reset sample asynchrously, not depends on clk
                             $rose(sig) |-> sig[*2])
                              $display( " [%0t] pass ", $time);
                           else
                              $display( " [%0t] fail ", $time);

  initial begin
    @(posedge clk);

    //pass
    sig = 1;
    @(posedge clk);
    @(posedge clk);
    sig = 0;
    @(posedge clk);

    //fail
    sig = 1;
    @(posedge clk);
    sig = 0;
    @(posedge clk);

    //fail with reset disable
    sig = 1;
    @(posedge clk);
    sig = 0;
    @(posedge clk);
    //comment this to check two fial condition                                                       
    reset = 1;

    @(posedge clk);
    $finish;
  end 

  initial $monitor(" [%0t] clk=%0d rst=%0d sig=%0d",$time,clk,reset,sig);

endmodule
