module test;

  //logic variable
  //at same time, if two drivers writes to logic, only last assignment wins
  //operation opposite to reg/wire where if two drivers with different values will not result in x
  //assignment similar to reg/wire ie continuous or procedural
  //cannot be used for tri-state assignment
  logic a=0;
  reg b=0;
  wire c=0;

  assign c = 0;
  assign c = 1;

  initial begin
    #1;
    a=0;
  end

  initial begin
    #1;
    a=1;
  end

  always@(*) b=1;
  always@(*) b=0;

  initial #1 begin
    $display("a=%0d b=%0d c=%0d" ,a,b,c);
    $finish;
  end

endmodule 
