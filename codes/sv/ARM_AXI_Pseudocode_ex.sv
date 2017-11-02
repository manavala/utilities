module top;

  typedef enum {FIXED, INCR, WRAP} tran_type;
  typedef enum {WRITE=1, READ=0} dir_type;

  dir_type IsWrite = WRITE;
  tran_type mode = FIXED;
  int Start_Address=32'h80_00_00_00;
  int Number_Bytes=2;
  int Burst_Length=4;
  int Data_Bus_Bytes=2;

  initial begin
    repeat(3) $display("");
    DataTransfer(Start_Address, Number_Bytes, Burst_Length, Data_Bus_Bytes, mode, IsWrite);
    repeat(3) $display("");
    $finish;
  end

  function void DataTransfer(int Start_Address, int Number_Bytes, int Burst_Length, int Data_Bus_Bytes, tran_type mode, dir_type IsWrite);
    // Data_Bus_Bytes is the number of 8-bit byte lanes in the bus
    // Mode is the AXI transfer mode
    // IsWrite is TRUE for a write, and FALSE for a read
    //assert Mode IN {FIXED, WRAP, INCR};

    //--Declaration start
    int unsigned addr;
    int unsigned Aligned_Address;
    int unsigned dtsize;
    int unsigned Lower_Wrap_Boundary;
    int unsigned Upper_Wrap_Boundary;
    int unsigned Lower_Byte_Lane;
    int unsigned Upper_Byte_Lane;
    bit aligned;
    //-Declaration end

    addr = Start_Address; // Variable for current address
    Aligned_Address = (/*INT*/(addr/Number_Bytes) * Number_Bytes);
    aligned = (Aligned_Address == addr); // Check whether addr is aligned to nbytes
    dtsize = Number_Bytes * Burst_Length; // Maximum total data transaction size

    if (mode == WRAP)
      Lower_Wrap_Boundary = (/*INT*/(addr/dtsize) * dtsize);

    // addr must be aligned for a wrapping burst
    Upper_Wrap_Boundary = Lower_Wrap_Boundary + dtsize;

    for (int n = 1 ; n<= Burst_Length; n++) begin
      Lower_Byte_Lane = addr - (/*INT*/(addr/Data_Bus_Bytes)) * Data_Bus_Bytes;
      if (aligned)
        Upper_Byte_Lane = Lower_Byte_Lane + Number_Bytes - 1;
      else
        Upper_Byte_Lane = Aligned_Address + Number_Bytes - 1 - (/*INT*/(addr/Data_Bus_Bytes)) * Data_Bus_Bytes;
      // Peform data transfer
      if (IsWrite)
        //dwrite(addr, low_byte, high_byte)
        $write("write ");
      else
        $write("read  ");
      //dread(addr, low_byte, high_byte);

      $display("addr = %08x low_byte = %02x high_byte = %02x", addr, Lower_Byte_Lane, Upper_Byte_Lane);

      // Increment address if necessary
      if (mode != FIXED) begin
        if (aligned) begin
          addr = addr + Number_Bytes;
          if (mode == WRAP)
            // WRAP mode is always aligned
            if (addr >= Upper_Wrap_Boundary)
              addr = Lower_Wrap_Boundary;
        end
        else begin
          addr = addr + Number_Bytes;
          aligned = 1;//TRUE; // All transfers after the first are aligned
        end
      end
    end
  endfunction

endmodule
