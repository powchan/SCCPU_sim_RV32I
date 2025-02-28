`include "ctrl_encode_def.v"
// data memory
module dm(clk, DMWr, addr, din, dout);
   input          clk;
   input          DMWr;
   input  [31:0]  addr;
   input  [31:0]  din;
   output reg [31:0]  dout;
   
   reg [31:0] dmem[127:0];
   
   always @(posedge clk)
      if (DMWr) begin
         dmem[addr[8:2]] <= din;
         $write(" memaddr = %h, memdata = %h", addr[31:0], din);
      end
   
     //load
     always @(*) begin
         dout <= dmem[addr[8:2]];
     end
     
endmodule    
