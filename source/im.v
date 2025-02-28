// instruction memory
module im(input  [31:2]  addr, output [31:0] dout);
  reg  [31:0] RAM[127:0];

  assign dout = RAM[addr]; // word aligned
endmodule  
