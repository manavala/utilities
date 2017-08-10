// Usage
// vcs –sverilog –ntb_opts uvm –debug_all -l sim.log config_db_syn_eg.sv +UVM_TESTNAME=test_a

import uvm_pkg::*;

module dut;
  int dut_int = 10;
  initial uvm_config_db#(int)::set(uvm_root::get(),
                                   "*",
                                   "from_dut",
                                   dut_int
                                  );
endmodule

module top;
  initial run_test();
  dut i_dut();
endmodule

class agent extends uvm_component;
  int i1_agent, i2_agent, i3_agent; // to receive values from uvm_config_db
  int i4; // to use automatic configuration
  uvm_event new_values; // to signal new step in test (env->agent)
  `uvm_component_utils_begin (agent)
    `uvm_field_int(i4, UVM_ALL_ON)
  `uvm_component_utils_end
    function new (string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      uvm_config_db#(uvm_event)::get(this, "", "new_values", new_values);
      if (new_values == null)
        `uvm_fatal(get_name(),
                   "new_values must be set in uvm_config_db"
                  );
        $display(" Agent \"%0s\" got Automatic configuration: i4=%0d",
                 get_name(),
                 i4
                );
    endfunction
    task run_phase (uvm_phase phase);
      while (1)
        begin
          uvm_config_db#(int)::get(this,
                                   "",
                                   "i_of_env",
                                   i1_agent
                                  );
          //Hierarchal Testbench Configuration Using uvm_config_db 11
          uvm_config_db#(int)::get(uvm_root::get(),
                                   "uvm_test_top.env.name_agent_1",
                                   "i_of_env",
                                   i2_agent
                                  );
          $display(" Agent \"%0s\" got: %0d (and stole %0d from agent1)",
                   get_name(),
                   i1_agent,
                   i2_agent
                  );
          uvm_config_db#(int)::get(this, "", "from_dut", i3_agent);
          $display(" Agent \"%0s\" got %0d from DUT",
                   get_name(),
                   i3_agent
                  );
          new_values.wait_trigger();

        end
    endtask
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
    agent agent_1, agent_2, agent_3;
  int i1_env=1, i2_env=2, i3_env=3,
    i4_env=4, i5_env=5, i6_env=6,
      i7_env=7, i8_env=8;
    uvm_event new_values;
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    function void build_phase (uvm_phase phase);
      agent_1 = agent::type_id::create("name_agent_1", this);
      agent_2 = agent::type_id::create("name_agent_2", this);
      agent_3 = agent::type_id::create("name_agent_3", this);
      set_config_int("name_agent_1", "i4", 1111);
      set_config_int("name_agent_2", "i4", 2222);
      set_config_int("name_agent_3", "i4", 3333);
      new_values = new("new_values");
      //Share event through uvm_config_db with agents
      uvm_config_db#(uvm_event)::set(this,
                                     "name_agent_*",
                                     "new_values",
                                     new_values
                                    );
    endfunction
    task run_phase (uvm_phase phase);
      phase.raise_objection(this);
      //uvm_config: share data with one specific object
      $display(" --- 1, 2, 3 to every agent separately --- ");
      uvm_config_db#(int)::set(agent_1,
                               "",
                               "i_of_env",
                               i1_env
                              );
      uvm_config_db#(int)::set(this,
                               "name_agent_2",
                               "i_of_env",
                               i2_env
                              );
      uvm_config_db#(int)::set(uvm_root::get(),
                               "uvm_test_top.env.name_agent_3",
                               "i_of_env",
                               i3_env
                              );
      // uvm_config_db: share data with multiple objects using regexp
      new_values.trigger(); #1;
      $display(" --- 4 to every agent, regexp name_agent_? --- " );
      uvm_config_db#(int)::set(this,
                               "name_agent_?",
                               "i_of_env",
                               i4_env
                              );
      new_values.trigger(); #1;
      $display(" --- 5 to every agent, regexp name_agent* --- " );
      uvm_config_db#(int)::set(this,
                               "name_agent_*",
                               "i_of_env",
                               i5_env
                              );
      new_values.trigger(); #1;
      $display(" --- 6 to every agent, regexp *agent* --- ");
      uvm_config_db#(int)::set(uvm_root::get(),
                               "*agent*",
                               "i_of_env",
                               i6_env
                              );
      // uvm_config_db: share data with everyone
      new_values.trigger(); #1;
      $display(" --- 7 to everyone, regexp *--- " );
      uvm_config_db#(int)::set(uvm_root::get(),
                               "*",
                               "i_of_env",
                               i7_env
                              );
      new_values.trigger(); #1;
      $display(" --- 8 to everyone, regexp *--- ");
      uvm_config_db#(int)::set(null,
                               "*",
                               "i_of_env",
                               i8_env
                              );
      new_values.trigger();
      phase.drop_objection(this);
    endtask
endclass

class test_a extends uvm_test;
  `uvm_component_utils (test_a)
    env env;
  function new (string name="test_a", uvm_component parent=null);
    super.new (name, parent);
    env = new("env", this);
  endfunction
  function void end_of_elaboration();
    print();
  endfunction
  task run_phase(uvm_phase phase);
    #1000; global_stop_request();
  endtask
endclass
