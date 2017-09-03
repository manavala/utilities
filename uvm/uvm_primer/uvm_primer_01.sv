virtual
  class animal;
  int age;
  function new(int a);
    age=a;
  endfunction

  pure
    virtual function make_sound();
    //$fatal("generic animal can't make sound");
  //endfunction

endclass : animal

class lion extends animal;
  function new(int a);
    super.new(a);
  endfunction

  function make_sound();
    $display("roar");
  endfunction
endclass : lion

class chicken extends animal;
  function new(int a);
    super.new(a);
  endfunction

  function make_sound();
    $display("becaww");
  endfunction
endclass:chicken

program test;

  animal a;
  lion l;
  chicken c;

  initial begin
    l=new(15);
    c=new(1);
    //a=new(10);

    a=l;
    a.make_sound();
    a=c;
    a.make_sound();
  end

endprogram
