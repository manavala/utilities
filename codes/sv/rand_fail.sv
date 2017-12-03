class test;

  logic [31:0] a=0;

  //constraint constr_a { a<10; a>10; };
  //whether variables can be declared as rand or not, randomize works
  //if constraints condition fails for the varaible value, the "randomize" function also fails
  constraint constr_a { a>10; };

  //randomize is "built-in" function modify will return compile error
  //function int randomize();
  //  $display("%m");
  //endfunction
  
endclass

program top;
  
  test t1;
  
  initial begin
    t1=new();
    //$display(t1.randomize(a)); //randomize' arguement takes class' varibale and
    //randomize it explicitly whether the variable is declared as random or not
    $display(t1.randomize());
    $display(t1.a);
  end

endprogram 
