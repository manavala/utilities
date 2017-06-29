module  check;

  bit [2:0] a = 0;
  bit [1:0] b = 0;

  `define COV_INST( sig ) cover_all_value #($bits(sig), {`"sig`",`"_`"}) inst_``sig (sig );

  `COV_INST( a );
  `COV_INST( b );

  always #5 a=a+1;
  always @a b=a>>2;
  initial #40 $stop;

endmodule

module cover_all_value #(parameter WIDTH=0, parameter SIG_NAME = "") (input [WIDTH-1:0] sig);
  string inst_name; 

  covergroup cg ;
    //option.name = SIG_NAME;
    cover_point_sig : coverpoint sig
      {
        option.auto_bin_max = 2 ** WIDTH ;
      }
  endgroup

  cg cg_inst = new();
  initial begin
    inst_name.itoa(WIDTH);
    inst_name = {SIG_NAME,inst_name,"_bits"};
    cg_inst.set_inst_name(inst_name);
  end

  always@(sig) cg_inst.sample();

endmodule
//vlog cov.sv ; vsim -c check -do "coverage save -onexit file.ucdb; run; coverage report -details; exit"; vcover report -html -details -htmldir . file.ucdb
