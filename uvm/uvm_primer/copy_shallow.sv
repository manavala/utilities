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
    //with the shallow copy new assignment, first object is created then
    // it copies the values from other handle
    // for varaibles declared inside has seperate memory
    // but the class handle inside shares the common handle/memory
    human = new animal;
    human.legs=2;
    human.e.no_eyes=2;
    $display("animal: legs = %0d eyes = %0d", animal.legs, animal.e.no_eyes);
    $display("human: legs = %0d eyes = %0d", human.legs, human.e.no_eyes);
    $finish;
  end

endmodule
