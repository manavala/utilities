//synopsys hierarchical-testbench-configuration-using-uvm.pdf

class env extends uvm_env;

  int i4;

  `uvm_component_utils_begin(env)
    `uvm_field_int(i4,UVM_ALL_ON)
  `uvm_component_utils_end

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    $display("i4 %0d",i4);
  endfunction

endclass

class test extends uvm_test;

  `uvm_component_utils(test);

  env env_0;

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_0 = env::type_id::create("env_0",this);
    uvm_config_db#(int)::set(this,"env_0","i4",1111);
  endfunction

endclass

program top;
  initial run_test("test");
endprogram
