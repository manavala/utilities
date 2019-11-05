
cmd: vlog hb_check.sv; vsim -c do "run -all"
code from: https://www.verificationguide.com/p/uvm-heartbeat-example.html

////////////////////////////////////////////
// uvm_heartbeat: similar to human heartbeat
// similar to watchdog timer
// between two delay(trigger), if there is no activity(objection) from component, terminate simulation with UVM_FATAL
///////////////////////////////////////////

module top();

   import uvm_pkg::*;
   `include "uvm_macros.svh"

uvm_callbacks_objection img_hb_obj = new("img_hb_obj");

class component_a extends uvm_component;
   
  `uvm_component_utils(component_a)
   
  //---------------------------------------
  // Constructor
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
    
  //---------------------------------------
  // run_phase
  //---------------------------------------
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_type_name(),$sformatf(" [ Comp-A ]
                              Objection raised "),UVM_LOW)
     
    for(int i=0;i<10;i++) begin //{
      `uvm_info(get_type_name(),$sformatf(" [ Comp-A ]
                                Idx-%0d raising obje objection",i),UVM_LOW)
      img_hb_obj.raise_objection(this);
      #50;
    end //}  
     
    phase.drop_objection(this);
  endtask : run_phase
 
endclass : component_a

class environment extends uvm_env;
   
  //---------------------------------------
  // Components Instantiation
  //---------------------------------------
  component_a comp_a;
   
  uvm_heartbeat heart_beat;
  uvm_event     hb_event;
   
  `uvm_component_utils(environment)
   
  //---------------------------------------
  // Constructor
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  //---------------------------------------
  // build_phase - Create the components
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    comp_a = component_a::type_id::create("comp_a", this);
     
    heart_beat = new("heart_beat", this, img_hb_obj);
    hb_event   = new("hb_event");
  endfunction : build_phase
   
  //---------------------------------------
  // Connect_phase
  //---------------------------------------
  function void connect_phase(uvm_phase phase);
    uvm_component hb[$];
    heart_beat.set_mode(UVM_ALL_ACTIVE);
    heart_beat.set_heartbeat(hb_event,hb);
    heart_beat.add(comp_a);
  endfunction : connect_phase
   
  //---------------------------------------
  // run_phase
  //---------------------------------------
  virtual task run_phase(uvm_phase phase);
    //heart_beat.start(hb_event);
     
    repeat(10) begin //{
      #100;
      `uvm_info(get_type_name(),$sformatf(" [ Env ] Triggering hb_event"),UVM_LOW)
      hb_event.trigger();
    end //}
  endtask : run_phase 
endclass : environment


class test extends uvm_test;
   `uvm_component_utils(test)
      environment e;
   function new(string name="test", uvm_component parent=null);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      e = environment::type_id::create("e", this);
   endfunction : build_phase

   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      #1000;
      phase.drop_objection(this);
   endtask

endclass

initial begin
   run_test("test");
end

endmodule
