//##
//set file='../uvm_primer_10.sv' ; vcs -full64 -sverilog -debug_access+all -lca $file -ntb_opts uvm ; if ( $status == 0 ) bsub -Ip ./simv -l sim.log
//##

class trans extends uvm_component;
  `uvm_component_utils(trans)
  uvm_put_port #(int) put_port;

  function new(string name,uvm_component parent=null);
    super.new(name,parent);
    put_port=new("put_port",this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    for(int i=0; i<3; i++) begin
      #10;
      put_port.put(i);
      $display("to drv %0d",i);
    end
    phase.drop_objection(this);
  endtask

endclass


class drv extends uvm_driver;
  `uvm_component_utils(drv)

  uvm_get_port #(int) get_port;

  function new(string name, uvm_component parent=null);
    super.new(name,parent);
    get_port =new ("get_port",this);
  endfunction

  task run_phase(uvm_phase phase);
    int rcvd;
    forever begin
      get_port.get(rcvd);
      $display("send to dur %0d",rcvd);
    end
  endtask
endclass

class env extends uvm_env;
  `uvm_component_utils(env)

  uvm_tlm_fifo #(int) fifo_h;
  drv d1;
  trans t1;

  function new(string name, uvm_component parent=null);
    super.new(name,parent);
    fifo_h=new("fifo_h",this,1);
    d1=new("d1",this);
    t1=new("t1",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    d1.get_port.connect(fifo_h.get_export);
    t1.put_port.connect(fifo_h.put_export);
  endfunction

endclass

module test;
  initial begin
    env e=new("env");
    run_test();
  end
endmodule
