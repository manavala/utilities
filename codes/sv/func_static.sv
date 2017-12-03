class test;

  //Function static:
  //same shared memory for all the objects
  //variables declared inside function automatically,implicitly static
  //cannot access the way same as "static function" ie scope resolution
  //only via handle/object name
  function static show_i();
    int i=10;
    i++;
    $display("i %0d",i);
  endfunction

endclass

program top;

  test t1,t2;

  initial begin
    t1=new();
    t2=new();
    t1.show_i;
    t2.show_i;
  end

endprogram
