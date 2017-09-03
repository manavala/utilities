class animal;
  string name;
  function new(string n);
    name=n;
  endfunction

  function string get_name();
    return name;
  endfunction
endclass

class lion extends animal;
  function new(string n);
    super.new(n);
  endfunction
endclass

class chicken extends animal;
  function new(string n);
    super.new(n);
  endfunction
endclass

//looks like "type T" gets "new instantiate" for each type
class animal_cage #(type T);

  static T cage[$];

  static function void cage_d_animal(T a1); 
    cage.push_back(a1);
  endfunction

  static function void show_d_animals();
    foreach(cage[i])
      $display("this is %s",cage[i].get_name());
  endfunction
endclass

program test;
  initial begin
    lion l1,l2;
    chicken c1,c2;

    l1=new("simba");
    animal_cage#(lion)::cage_d_animal(l1);
    l2=new("kimba");
    animal_cage#(lion)::cage_d_animal(l2);

    c1=new("zimba");
    animal_cage#(chicken)::cage_d_animal(c1);
    c2=new("bimba");
    animal_cage#(chicken)::cage_d_animal(c2);

    animal_cage#(chicken)::show_d_animals();
    animal_cage#(lion)::show_d_animals();
  end
endprogram
