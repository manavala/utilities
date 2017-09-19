//##
//set file='../uvm_primer_09.sv' ; vcs -full64 -sverilog -debug_access+all -lca $file -ntb_opts uvm ; if ( $status == 0 ) bsub -Ip ./simv -l sim.log
//##


//class prod extends uvm_monitor;
class prod extends uvm_component;
  //`uvm_component_utils(prod);
  //if `uvm_component_utils used, make sure not to change the "new" arguements
  uvm_put_port #(int) put_port;
  uvm_analysis_port #(int) a_port;
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
    put_port=new("put_port",this);
    a_port=new("a_port",this);
  endfunction

  task run;
    for(int i=0; i<3; i++) begin
      a_port.write(i);
      #10;
      `uvm_info(get_full_name(),$sformatf("prod sent %0d",i),UVM_NONE);
      put_port.put(i);
    end
  endtask

endclass

class cons extends uvm_component;
  //`uvm_component_utils(cons);
  uvm_get_port #(int) get_port;
  uvm_tlm_fifo #(int) t2;

  function new(string name, uvm_component parent=null, uvm_tlm_fifo #(int) t1);
    super.new(name,parent);
    get_port=new("get_port",this);
    t2 = t1;
  endfunction

  task run;
    int rcvd;
    forever begin
      get_port.get(rcvd);
      $display(t2.is_empty());
      `uvm_info(get_full_name(),$sformatf("cons recvd %0d",rcvd),UVM_NONE);
    end
  endtask

endclass

class cov extends uvm_subscriber #(int);
  //`uvm_component_utils(cov);
  uvm_tlm_analysis_fifo #(int) a1;
  function new(string name, uvm_component parent=null);
    super.new(name,parent);
    a1=new("a1",this);
    $display("object created");
  endfunction

  function void write (int t) ;
    int rcvd;
    $display("%m hi");
    if(!a1.try_get(rcvd)) $fatal("looks like connection is not good");
    if(rcvd != t)
      $error("what happend!!");
    $display("rcvd cov %0d",rcvd);
  endfunction
endclass

class env extends uvm_env;
  prod p1;
  cons c1;
  uvm_tlm_fifo #(int) t1;
  cov cov1;

  function new(string name="env");
    super.new(name);
    p1=new("p1",this);
    t1=new("t1",this,1);
    c1=new("c1",this, t1);
    cov1=new("cov1",this);
  endfunction

  function void connect();
    c1.get_port.connect(t1.get_export);
    p1.put_port.connect(t1.put_export);
    p1.a_port.connect(cov1.a1.analysis_export);
    p1.a_port.connect(cov1.analysis_export);//make sure to connect outer subscriber first before accessing inside tlm analysis fifo
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
  initial begin e=new("env"); run_test(); end
endmodule
