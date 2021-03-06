class rectangle;
  int length;
  int width;

  //If function new argument is modified, child should have and call this constructor
  function new(int l, int w);
    length=l;
    width=w;
  endfunction

  function area();
    $display("area of rectable is %d",length*width);
  endfunction

endclass

class square extends rectangle;

  //If new function argument is not used, automatically "super.new" will be called
  //if argumented, should fullfill argument requirements
  function new(int s);
    super.new(.l(s),.w(s));
  endfunction

endclass

program test;
  rectangle r1;
  square s1;
  initial begin
    r1=new(10,20);
    s1=new(10);
    r1.area();
    s1.area();
  end
endprogram
