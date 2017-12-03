program top;
  logic [3:0] minus; //unsigned
  int minus1=-2; //signed
  initial begin
    minus = -10; //value display as ( 16 -10) = 6
    $display(minus);
    $display(minus1);//works fine
  end
endprogram
