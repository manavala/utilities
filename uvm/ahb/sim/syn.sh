#!/bin/sh

root_path="/home/mana/Desktop/ahb/"

vcs -full64 -sverilog -debug_access+all -lca -ntb_opts uvm +incdir+$root_path/ahb_env +incdir+$root_path/ahb_master_agent +incdir+$root_path/ahb_slv_agent +incdir+$root_path/ahb_test +incdir+$root_path/reset_agent +incdir+$root_path/rtl \
 ../rtl/ahb_intf.sv\
 ../ahb_test/ahb_test_pkg.sv\
 ../ahb_env/top.sv\
 +UVM_TESTNAME=reset_test\

#crt_test
#incrx_test
#wrapx_test
#incrbusy_test
#err_test


#+incdir+$root_path/ahb_env +incdir+$root_path/ahb_master_agent +incdir+$root_path/ahb_slv_agent +incdir+$root_path/ahb_test +incdir+$root_path/reset_agent +incdir+$root_path/rtl

