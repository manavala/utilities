class test;

  static int i;

  //Static function:
  //can use only static variable
  //share common memory between all the handles
  //available to access before the object creation since the memory is static
  //can be accessed with scope resolution operator with class name itself
  static function incr_i();
    i++;
  endfunction

  static function show_i();
    $display("i %0d",i);
  endfunction

endclass

program top;

  test t1;

  initial begin
    test::incr_i;
    test::show_i;
  end

endprogram
