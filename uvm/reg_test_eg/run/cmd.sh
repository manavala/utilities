#!/bin/sh

UVM_HOME="/..//uvm-1.2/"

vcs -sverilog -timescale=1ns/1ns +acc +vpi -debug_access+all -lca \
+incdir+$UVM_HOME/src $UVM_HOME/src/uvm.sv $UVM_HOME/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
+incdir+../. +incdir+../apb ../tb_top.sv ../test.sv -l comp.log

./simv +UVM_TESTNAME=cmdline_test +UVM_REG_SEQ=uvm_reg_hw_reset_seq -gui -l sim.log
#./simv +UVM_TESTNAME=cmdline_test +UVM_REG_SEQ=user_test_seq

#tcl:
#dump -file wave.vpd -type vpd
#dump -add tb_top -aggregates -depth 0
#dump -add test -aggregates -depth 0
#dump -add * -aggregates -depth 0
#run
