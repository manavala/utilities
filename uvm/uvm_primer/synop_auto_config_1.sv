

//Questa
//To compile
//vlog synop_auto_config_1.sv
//To set at uvm_test
// vsim -voptargs="+acc" -c top +UVM_TESTNAME=test  +uvm_set_config_int=uvm_test_top.env_0,a,4 -do 'run -all; exit' +uvm_set_config_string=uvm_test_top.env_0,color,blue^C
//To set at uvm_env
// vsim -voptargs="+acc" -c top +UVM_TESTNAME=test  +uvm_set_config_int=uvm_test_top,a,4 -do 'run -all; exit' +uvm_set_config_string=uvm_test_top,color,blue^C


//VCS:
//vcs -R -sverilog config_test.sv +UVM_TESTNAME=test +uvm_set_config_int=uvm_test_top.env_0,a,5 +uvm_set_config_string=uvm_test_top.env_0,color,blue -ntb_opts uvm
//vcs -R -sverilog config_test.sv +UVM_TESTNAME=test +uvm_set_config_int=uvm_test_top,a,5 +uvm_set_config_string=uvm_test_top,color,blue -ntb_opts uvm



//synopsys hierarchical-testbench-configuration-using-uvm.pdf

import uvm_pkg::*;
`include "uvm_macros.svh"

class env extends uvm_env;

  int i4;
  int a;
  string color;

  `uvm_component_utils_begin(env)
    `uvm_field_int(i4,UVM_ALL_ON)
    `uvm_field_int(a,UVM_ALL_ON)
    `uvm_field_string(color,UVM_ALL_ON)
  `uvm_component_utils_end

    function new(string name, uvm_component parent);
      super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
      //must call super.build_phase if automatic configuration required
      //make sure, uvm_field_* is set and other than UVM_READ_ONLY permission
      super.build_phase(phase);
      //get method for i4 variable is not required
      //if(!uvm_config_db#(uvm_bitstream_t)::get(this,"","a",a))
      //  `uvm_error(get_type_name(),"a config database not set");
      //if(!uvm_config_db#(string)::get(this,"","color",color))
      //  `uvm_error(get_type_name,"color config database not set");
    endfunction

    function void connect_phase(uvm_phase phase);
      $display("%s i4  %0d",get_type_name(), i4);
      $display("%s a   %0d",get_type_name(), a);
      $display("%s col %s",get_type_name(), color);
    endfunction

endclass

class test extends uvm_test;

    env env_0;
    int a=3;
    int i4;
    string color="red";

  //`uvm_component_utils(test);
  `uvm_component_utils_begin(test)
    `uvm_field_int(i4,UVM_ALL_ON)
    `uvm_field_int(a,UVM_ALL_ON)
    `uvm_field_string(color,UVM_ALL_ON)
  `uvm_component_utils_end

    function new(string name, uvm_component parent);
      super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_0 = env::type_id::create("env_0",this);
      uvm_config_db#(int)::set(this,"env_0","i4",1111);
      //comment below two lines if using from command line
      //uvm_config_db#(uvm_bitstream_t)::set(this,"env_0","a",a);
      //uvm_config_db#(string)::set(this,"env_0","color",color);
    endfunction

    function void connect_phase(uvm_phase phase);
      $display("%s i4  %0d",get_type_name(), i4);
      $display("%s a   %0d",get_type_name(), a);
      $display("%s col %s",get_type_name(), color);
    endfunction

endclass

module top;
  initial begin
    //comment below two lines if using from command line
    //Below two lines modifies for all ** uvm component classes that are factory registered uvm_feild_* for below macros
    //with the same variables that are used with super.build_phase
    //set_config_int("*","a",4);
    //set_config_string("*","color","blue");
    run_test();
    $finish;
  end
endmodule 
