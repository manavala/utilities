module top;
  integer a=0,b=0;
  bit clk;

  initial begin
    a=3'b100;
    b=0;
    repeat(10)@(clk);
    a=0;//'hx;
    repeat(2)@(clk);
    a=3'b100;
  end

  always #5 clk=~clk;

//before "|->", at any where "trigger can be aborted"  can get aborted
if_a_set_chk_b:  assert property ( @ (posedge clk) 
                                 
                                //before trigger/////////
                                //before trigger/////////

                                 // $rose(a) //triggered when transit from low to high
                                 // a //whenver it is one
                                 // $fell(a) // high to low
                                 // $stable(a) // pass for 0 or 1 which ever is stable for next cycle (each successive second cycle)
                                 // $past(a) is similar to $(past,1) //whenever my past 1 cycle is high
                                 // $past(a,2) //whenever my past 2 cycles are high
                                 // $isunknown(a) //whenver a is xx
                                 // $countones(a) //true if single or multiple bits are high
                                 // $onehot(a) //only one and any single bit should be 1
                                 // $onehot0(a) //only one and any single bit should be 1 or all zeros
                                 // a ##2 !a //trig whenver a is 1, at 2nd cycle if a is 0
                                 a ##1 !a ##1 a //, high one-cyc low one-cyc high then trigger else abort at any where
                                 // (a ##1 !a ##1 a) or (a##1 !a ##1 !a ##1 a)  is same as (a ##1 !a  [*1:2] ##1 a) to note 101 and 1001  [low's '0' range ]
                                 // (a ##1 !a  [*1:$] ##1 a) denotes any of     101, 1001, 10001, 100..01, ...[low's '0' range ]
                                 // (a ##1 !a  [*0:$] ##1 a) denotes any of 11, 101, 1001, 10001, 100..01, ...[low's '0' range ]

                                 //compile issues note : never end above lines ##num, always end with variable

                                 //during trigger/////////////
                                 //during trigger/////////////

                                  //|->  //check in same cycle
                                  |=>  //check in next cycle

                                  /// Error check after trigger //////////////
                                  /// Error check after trigger //////////////

                                  // b //single check
                                  // ( ##1 !b) or (##2 !b) //or condition check
                                  // ##2 !b //delayed check
                                  // (!a [*2:$] ##1 a) and (b [*2:$] ##1 !b) //and condition check
                                  // (!a [*2:$] ##1 a) intersect (b [*2:$] ##1 !b) //both condition should match at same time
                                   );

                                   //assert property(a!=3) //single cycle example
                                   //assert property(a==2 ##2 a==4 ) //multi cycle example



  initial
    begin
      #100 $stop; 
    end


endmodule
