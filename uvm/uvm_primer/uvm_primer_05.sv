//
//set file='../uvm_primer_05.sv' ; vcs -full64 -sverilog -debug_access+all -lca $file -ntb_opts uvm ; if ( $status == 0 ) ./simv -l sim.log
//

//not required if ntb opts pointed
import uvm_pkg::*;

class monitor extends uvm_monitor;

  uvm_analysis_port #(int) ap;

  function new(string name, uvm_component parent=null);
    super.new(name,parent);
    ap=new("ap",this);
  endfunction

  task run;
    #10ns;
    ap.write(1);
    #10ns;
    ap.write(2);
    #10ns;
    ap.write(3);
  endtask

endclass

//Subcriber must implment the write method
class cov extends uvm_subscriber#(int);

  function new(string name, uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void write (int t);
    `uvm_info( get_full_name(), $sformatf("Mon sends %0d",t), UVM_NONE )
  endfunction

endclass

class env extends uvm_env;

  monitor mon;
  cov cov;

  function new(string name="env");
    super.new(name);
    mon=new("mon",this);
    cov=new("cov",this);
  endfunction

  function void connect();
    mon.ap.connect(cov.analysis_export);
  endfunction

endclass

module test;
  env e;

  initial begin
    e=new();
    run_test();
  end

endmodule
