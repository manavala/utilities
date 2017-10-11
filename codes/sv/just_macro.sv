//vcs -R -full64 -sverilog def_mac.sv

module top;

  `define FINAL(w,x,y,z)\
  top.abc``w``.def``x``.var``y``= VAL``z``;

  typedef enum{VAL0, VAL1, VAL2} val_e;

  `define CHOOSE_Z(w,x,y,z)\
  if(z==0) `FINAL(w,x,y,0)\
  if(z==1) `FINAL(w,x,y,1)\
  if(z==2) `FINAL(w,x,y,2)

  `define CHOOSE_Y(w,x,y,z)\
  if(y==0) `CHOOSE_Z(w,x,0,z)\
  if(y==1) `CHOOSE_Z(w,x,1,z)\
  if(y==2) `CHOOSE_Z(w,x,2,z)

  `define CHOOSE_X(w,x,y,z)\
  if(x==0) `CHOOSE_Y(w,0,y,z)\
  if(x==1) `CHOOSE_Y(w,1,y,z)\
  if(x==2) `CHOOSE_Y(w,2,y,z)

  `define CHOOSE_W(w,x,y,z)\
  if(w==0) `CHOOSE_X(0,x,y,z)\
  if(w==1) `CHOOSE_X(1,x,y,z)\
  if(w==2) `CHOOSE_X(2,x,y,z)

  `define DECL(x)\
  begin:def``x``\
    val_e var0;\
    val_e var1;\
    val_e var2;\
    $display("%m");\
    #100;\
  end\

  `define INIT_MACRO(w)\
  initial begin:abc``w``\
    fork\
      `DECL(0)\
      `DECL(1)\
      `DECL(2)\
    join\
  end

  `INIT_MACRO(0);
  `INIT_MACRO(1);
  `INIT_MACRO(2);

  int p,q,r,s=3;

  initial begin
    for(p=0; p<s; p++) begin
      for(q=0; q<s; q++) begin
        for(r=0; r<s; r++) begin
          `CHOOSE_W(p,q,r,r);
          #1;
        end
      end
    end
    $finish;
  end

endmodule
