module test;
                                                                                                                                                                                                                                                                                                                              
  bit clk,done;

  always #5 clk = ~clk;

  reg[31:0] a=32'hx;
  reg[0:31] b=32'hz;
  //x,z,0->1 "rose"
  //x,z,1->0 "fell"

  event e1,e2;

  initial begin
    @(posedge clk);
    a[0]=1;
    @(posedge clk);
    if($rose(a,@(posedge clk))) $display("A rised");
    b[31]=1;
    @(posedge clk);
    if($rose(b,@(posedge clk))) $display("B rised");
    @(posedge clk);
    ->e1;
  end 

  initial begin
    @(e1.triggered);//can escape with glitch, cause when @ & -> act at 'exact' same time, if @ happens before -> in 'fork', then there is a change to miss
    //wait(e1.triggered);//wait for that event until time slot end, safe and glitch free
    @(posedge clk);
    a[0]=0;
    b[31]=0;
    @(posedge clk);
    if($fell(a,@(posedge clk))) $display("A falled");
    if($fell(b,@(posedge clk))) $display("B falled");
    @(posedge clk);
    ->e2;
  end 

  initial begin
    //wait_order(e1,e2) else $display("not in order");
    wait(e2.triggered);
    @(posedge clk);// for 'strong' at line no 68
    $finish;
  end 

  always@(posedge clk) begin
    done=$rose(a);//clk inferred from always
    if(done) $display("A rose");
    done=$rose(b);
    if(done) $display("B rose");
    done=$fell(a) & $fell(b);
    if(done) $display("A & B fall");
  end 

  default clocking cb1 @(posedge clk);
  endclocking

  // default clock inferred
  //concurrent always uses clock
  //pass
  check_a_pass: assert property ($rose(a) |=> $rose(b)); 
  //fail
  check_a_fail: assert property ($rose(b) |=> $rose(a)); 

  sequence b_fell;
    $fell(b);
  endsequence

  sequence a_fell;
    $fell(a);
  endsequence

  //pass
  check_ab_pass: assert property ($fell(a) |-> $fell(b));
  //fail
  //if strong not used simulation will end before completing this assert and fail will be screened
  //check_ab_fail: assert property (strong ( a_fell_then_b_fell ) ); 
  //syntax
  //strong(sequence)
  //weak(sequence) // don't use implication, use only sequece 
  check_ab_fail: assert property ( a_fell |=> strong ( b_fell ) ); 

endmodule
