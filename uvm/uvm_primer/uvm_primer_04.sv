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
  bit itisme=1;
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

class animal_factory;

  static function animal make_animal(string species,
                                     int age, string name);
  lion lion_h;
  chicken chicken_h;
  case(species)
    "lion": begin
      lion_h=new(name);
      return lion_h;
    end
    "chicken": begin
      chicken_h=new(name);
      return chicken_h;
    end
    default:
      $fatal("there is no such animal");
  endcase
  endfunction
endclass

program test;
  animal_cage#(lion) lion_cage;
  animal_cage#(chicken) chicken_cage;
  initial begin
    lion l1,l2;
    chicken c1,c2;
    animal a;
    lion_cage=new();
    chicken_cage=new();

    //l1=new("simba"); instead of creating new modules separately each, use factory
    a=animal_factory::make_animal("lion",1,"simba");
    if(!$cast(l1,a))
      $fatal("failed to fcast");

    if(l1.itisme)
      $display("lion is ok");
    else
      $display("lion is not ok");

    lion_cage.cage_d_animal(l1);
    //l2=new("kimba");
    a=animal_factory::make_animal("lion",1,"kimba");
    $cast(l2,a);
    lion_cage.cage_d_animal(l2);

    //c1=new("zimba");
    $cast(c1,animal_factory::make_animal("chicken",1,"zimba"));
    chicken_cage.cage_d_animal(c1);
    //c2=new("bimba");
    $cast(c2,animal_factory::make_animal("chicken",1,"bimba"));
    chicken_cage.cage_d_animal(c2);

    chicken_cage.show_d_animals();
    lion_cage.show_d_animals();
  end
endprogram
