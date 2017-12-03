class test;
  static 
    int a=10;
  function new();
    a++;
  endfunction
endclass

program top;

  test t1,t2;
  initial begin
    //access using class name without object creation
    $display(test::a);
    //static  variable is shared memory for all the handles/objects
    // will not be initialized for each object/handle
    t1=new();
    $display(t1.a);
    t2=new();
    $display(t2.a);
  end


endprogram 
