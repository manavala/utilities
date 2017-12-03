class clk_gen;
  string str="top.clk";
  bit val;
  task run;
    fork
    forever begin
      #10;
      //pass only string
      //value return stored in val
      //if path doesn't exists, "uvm_hdl_*" returns pass or fail stat
      uvm_hdl_read(str,val);
      uvm_hdl_force(str,~val);
    end
    join_none
  endtask
endclass

clk_gen gen0;

module top;
  bit clk;
  initial begin
    gen0 = new();
    gen0.run;
    #100;
    $finish;
  end
  initial $monitor("clk = %0d",clk);
endmodule 
