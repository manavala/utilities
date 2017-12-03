
//cluelogic.com

class test extends uvm_test;
  `uvm_component_utils(test);
  function new(string name,uvm_component parent=null);
    super.new(name,parent);
    $display(" Actions: %0d %0d %0d %0d %0d %0d %0d",UVM_NO_ACTION, UVM_DISPLAY, UVM_LOG, UVM_COUNT, UVM_EXIT,UVM_CALL_HOOK, UVM_STOP);
    $display(" Verbosity: %0d %0d %0d %0d %0d ",UVM_NONE, UVM_LOW, UVM_MEDIUM, UVM_HIGH, UVM_FULL);
    $display(" Severity: %0d %0d %0d %0d ",UVM_INFO, UVM_WARNING, UVM_ERROR, UVM_FATAL);
  endfunction

  task print_all;
    `uvm_info("info","info msg",UVM_NONE);
    `uvm_info("info","info msg",UVM_LOW);
    `uvm_info("info","info msg",UVM_MEDIUM);
    `uvm_info("info","info msg",UVM_HIGH);
    `uvm_info("info","info msg",UVM_FULL);
  endtask

  function void connect_phase(uvm_phase phase);
    //$display("Severity: get Action", get_report_action(UVM_INFO,"info"));
    //set_report_id_action("info",UVM_NO_ACTION); //will not display anything with id "info". Other actions: DISPLAY, LOG, COUNT, EXIT, CALL_HOOK, STOP
    //$display("Severity: get Action", get_report_action(UVM_INFO,"info"));

    //set_report_severity_id_action(UVM_INFO,"info",UVM_LOG);//sets action only if Severity and "id" matches

    //set_report_severity_action_hier(UVM_INFO, UVM_EXIT);// sets actions "NO_ACTION, DISPLAY, etc" based on severity

    //set_report_id_action("RNTST",UVM_EXIT); 

    //uvm_top.set_report_severity_action(UVM_INFO, UVM_EXIT); //--not working 
    //set_report_severity_action(UVM_INFO, UVM_EXIT);// working

    print_all;

    this.set_report_severity_action(UVM_INFO,UVM_DISPLAY|UVM_LOG);
    this.set_report_severity_action(UVM_WARNING,UVM_DISPLAY|UVM_LOG);
    this.set_report_severity_action(UVM_ERROR,UVM_DISPLAY|UVM_LOG);
    this.set_report_severity_action(UVM_FATAL,UVM_DISPLAY|UVM_LOG);

  endfunction

  protected int default_fd; // file descriptor
  protected int warning_fd;
  protected int id1_fd;
  protected int warning_id1_fd;

  function void build_phase( uvm_phase phase );
    default_fd     = $fopen( "default_file",     "w" );
    warning_fd     = $fopen( "warning_file",     "w" );
    id1_fd         = $fopen( "id1_file",         "w" );
    warning_id1_fd = $fopen( "warning_id1_file", "w" );
    this.set_report_default_file( default_fd );
    this.set_report_severity_file( UVM_WARNING, warning_fd );
    this.set_report_id_file("info",id1_fd);
    this.set_report_severity_id_file(UVM_WARNING,"info",warning_id1_fd);
  endfunction

  task run_phase(uvm_phase phase);
    uvm_top.print_topology();
  endtask

  `define PHASE(x)\
  function void ``x``_phase(uvm_phase phase);\
    `uvm_warning("info","simple %m");\
    `uvm_error("info","simple %m");\
    `uvm_fatal("info","simple %m");\
  endfunction

  `PHASE(extract);
  `PHASE(check);
  `PHASE(report);
  `PHASE(final);

endclass

module top;
  initial run_test("test");
endmodule
