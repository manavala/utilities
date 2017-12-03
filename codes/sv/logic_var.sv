program test;

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
    a=0;
    b=0;
  end
  
  initial begin
    a=1;
    b=1;
  end

endprogram
