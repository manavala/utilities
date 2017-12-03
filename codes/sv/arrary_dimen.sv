module arr; 

 bit [2:0][3:0] arr [4:0][5:0];

 //System functions
 //low //1st arry or dimension number's low
 //high //1st arry or dimension number's high
 //left //1st arry or dimension number's left
 //right //1st arry or dimension number's right
 //dimensions , first unpacked left to right and then packed from left to right
 //size, same as bits for 1D or depth for 2D o more arrray
 //bits, total size
 //increment , left > right
 //unpacked_array???
 
  initial begin : beg1
  
    for (int dim=1; dim<5; dim++)
    
      $display(" DIMENSION %0d (the default) : $left %0d $right %0d $low %0d $high %0d $increment %0d $size %0d $dimensions %0d",
               dim, $left(arr, dim),$right(arr, dim),$low(arr , dim),$high(arr, dim),$increment(arr, dim),$size(arr, dim),$dimensions(arr) );
      
      //$display($unpacked_dimensions(arr));
      $finish;
      
  end
  
endmodule

logic [8:0] variable  = 10;
struct packed {
 logic a;
 byte c;
} struct_packed;
//legal , as the struct becomes the single vector using the keyword "packed"
// the memory allocation for the packed will happen " 8:7:6:5:4:3:2:1:0 " continously
struct_packed = variable ;
struct {
 logic a;
 byte c;
} struct_unpacked;
// the memory allocation for the packed will not happen " 8:x:x:x:x:7:6:5:4:3:2:1:0 " continously
//below assignment is illegal and will give compile error
//struct_unpacked = variable ;


//wire single continous assignment, if two drives with different values then output is x
//in tri, if en is high, output is same as input. if en is low, output is z for whatever input is
//wor, trior, if any 1 input is 1, output is 1
//wand,triand, if any input is 0, output is 0
