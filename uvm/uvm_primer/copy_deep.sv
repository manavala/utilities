
//Kavish Shah Youtube

class eyes;
  int no_eyes;
endclass

class living_things;
  int legs=4;
    eyes e=new;
  function void copy(living_things l1);
    this.e =new l1.e;
    this.legs = l1.legs;
  endfunction
endclass

module top;

  living_things animal,human;

  initial begin
    animal=new;
    human = new;
    //if any properties of animal is changed, that can be copied to human using below function
    human.copy(animal);
    //other than handle assign or shallow copy, it has own handles for all the properties
    //so the value/property changes of one handle's will not affect other
    human.legs=2;
    human.e.no_eyes=2;
    $display("animal: legs = %0d eyes = %0d", animal.legs, animal.e.no_eyes);
    $display("human: legs = %0d eyes = %0d", human.legs, human.e.no_eyes);
    $finish;
  end

endmodule
