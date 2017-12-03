//Kavish Shah Youtube

class eyes;
  int no_eyes;
endclass

class living_things;
  int legs=4;
  eyes e=new;
endclass

module top;

  living_things animal,human;

  initial begin
    animal=new;
    
    //handle is copied to another handle
    //both handle shares the common memory for variable and if any handle inside it has
    //if value changes, it will reflects on both
    
    human = animal;
    human.legs=2;
    human.e.no_eyes=2;
    $display("animal: legs = %0d eyes = %0d", animal.legs, animal.e.no_eyes);
    $display("human: legs = %0d eyes = %0d", human.legs, human.e.no_eyes);
    $finish;
  end

endmodule 
