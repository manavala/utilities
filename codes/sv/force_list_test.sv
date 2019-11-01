cat force_list_test.sv

loc_test]$ cat force_list_test.sv 
module top;
   logic [1:0] a;
   initial begin 
      force a=1;
      #1ns;
      release a;
      #2ns;
      force a=2;
      #2ns;
      release a;
      #2ns;
      $stop;
   end
endmodule

command :
loc_test]$ vcs -R -sverilog -debug_access+all -force_list force_list_test.sv

loc_test]$ cat simv.daidir/forceList.txt
top top.a force_list_test.sv 4 F
top top.a force_list_test.sv 6 R
top top.a force_list_test.sv 8 F
top top.a force_list_test.sv 10 R
