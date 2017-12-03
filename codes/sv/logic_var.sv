program test;

  //at same time, if two drivers writes to logic, only last assignment wins
  //operation opposite to reg/wire where if two drivers with different values will not result in x
  //assignment similar to reg/wire ie continuous or procedural
  //cannot be used for tri-state assignment
  logic a;

  initial a=0;
  initial a=1;

endprogram
