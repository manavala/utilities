//##
//set file='../uvm_primer_06.sv' ; vcs -full64 -sverilog -debug_access+all -lca $file -ntb_opts uvm ; if ( $status == 0 ) bsub -Ip ./simv -l sim.log
//##
class prod extends uvm_component;
  uvm_blocking_put_port #(int) put_port;
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
    put_port=new("put_port",this);
  endfunction

  task run;
    for(int i=0; i<3; i++) begin
      #10;
      `uvm_info(get_full_name(),$sformatf("prod sent %0d",i),UVM_NONE);
      put_port.put(i);
    end
  endtask

endclass

class cons extends uvm_component;
  uvm_blocking_get_port #(int) get_port;

  function new(string name, uvm_component parent=null);
    super.new(name,parent);
    get_port=new("get_port",this);
  endfunction

  task run;
    int rcvd;
    forever begin
      get_port.get(rcvd);
      `uvm_info(get_full_name(),$sformatf("cons recvd %0d",rcvd),UVM_NONE);
    end
  endtask

endclass

class env extends uvm_env;
  prod p1;
  cons c1;
  uvm_tlm_fifo #(int) t1;

  function new(string name="env");
    super.new(name); 
    c1=new("c1",this);
    p1=new("p1",this);
    t1=new("t1",this,1);
  endfunction

  function void connect();
    c1.get_port.connect(t1.get_export);
    p1.put_port.connect(t1.put_export);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #1000;
    global_stop_request();
    phase.drop_objection(this);
  endtask

endclass

module test;
  env e;
  initial begin e=new(); run_test(); end
endmodule
