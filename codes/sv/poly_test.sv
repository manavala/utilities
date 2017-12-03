
//From testbench.in
class A ;
  virtual task disp (); 
    $display(" This is class A "); 
  endtask 
endclass 

class EA extends A ; 
  task disp (); 
    $display(" This is Extended class A "); 
  endtask 
endclass 

program main ; 
  EA my_ea; 
  A my_a; 

  initial 
    begin 
      my_a = new(); 
      my_a.disp(); 

      my_ea = new(); 
      my_a = my_ea; 
      //if virtual is used for Class A disp task virtually calls Class EA's task
      //if virtual is not used, Class A's handle always shows Class A's disp task only
      my_a.disp(); 
    end 
endprogram 
