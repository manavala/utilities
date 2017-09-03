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

  T cage[$];

  function void cage_d_animal(T a1);
    cage.push_back(a1);
  endfunction

  function void show_d_animals();
    foreach(cage[i])
      $display("this is %s",cage[i].get_name());
  endfunction
endclass

program test;
  animal_cage#(lion) lion_cage;
  animal_cage#(chicken) chicken_cage;
  initial begin
    lion l1,l2;
    chicken c1,c2;
    lion_cage=new();
    chicken_cage=new();

    l1=new("simba");
    lion_cage.cage_d_animal(l1);
    l2=new("kimba");
    lion_cage.cage_d_animal(l2);

    c1=new("zimba");
    chicken_cage.cage_d_animal(c1);
    c2=new("bimba");
    chicken_cage.cage_d_animal(c2);

    chicken_cage.show_d_animals();
    lion_cage.show_d_animals();
  end
endprogram
