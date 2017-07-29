module dff(dd, dq, clk);
  input dd,clk;
  output reg dq=0;
  always@(posedge clk) dq<=dd;
  //wire x,y;
endmodule
module test;

  //bind syntax
  //bind module/inst_name prop_module new_inst_name_for_prop (ports);
  //internal signals of module (x,y) is visible in port assignments
  //bind dff prop_dff prop_dff_inst(.dd(x),.dq(y),.clk(clk));

 bind dff prop_dff prop_dff_inst(.*);//positional, implicit or explicit named, wildcard

 // bind dff_1 prop_dff prop_dff_inst(.*); 

  bit td,tclk;
  wire tq;

  always #5 tclk = ~tclk;

  dff dff_1(td,tq,tclk);

  initial begin
    td=0;
    @(posedge tclk);
    td=1;
    @(posedge tclk);
    td=0;
    @(posedge tclk);
    $finish;
  end

  initial $monitor(" [%0t] tclk=%0d td=%0d tq=%0d",$time,tclk,td,tq);

endmodule
//about Checker:
//Can pass sequence in formal arguments
//its' instance can be declared inside or outside of the procedual block
//takes only input arguments
//can be declared in module, interface, package, generate, program, interface, compilation unit scope

  //Make sure the port names exactly same as the DUT module
  //if port names are different use "name based port names association"

  //TODO questa gives error, if this checker block pasted on top of this file. cmd: qverilog filename.sv
  checker prop_dff(dd,dq,clk);//cannot be 'type','local', can be initialized with $infereed_clock $inferred_disable
  //module prop_dff(dd,dq,clk);                                                                                                                                                                                                                                                 
    //input dd,dq,clk;

    dff_check : assert property ( @ (posedge clk)
                                  1 |-> $past(dd) == dq )
                                    $display(" [%0t] pass",$realtime);
                                  else
                                    $display(" [%0t] fail sampled dq =%0d dd =%0d",$realtime, $past(dd), $sampled(dq));

  //Checker body
  //can contain all types of assertions. except immediate ( immediate allowed in action blocks)
  //'let', seq, prop, nested checker and instance, always/_comb/_latch/_ff, init, final
  //if,case,for not allowed. In always only checker variable assignment, @, concurrent or defferred assertions
  //clocking, disable iff, covergroup, generate blocks allowed

  endchecker
