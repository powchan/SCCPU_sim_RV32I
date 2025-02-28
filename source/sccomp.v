`include "ctrl_encode_def.v"
module sccomp(clk, rstn, reg_sel, reg_data);
   input          clk, rstn; 
   input [4:0]    reg_sel;
   output [31:0]  reg_data;
   
   wire [31:0]    instr;
   wire [31:0]    PC;
   wire           MemWrite;
   wire [31:0]    dm_addr, dm_din, dm_dout;
   
   wire reset;
   assign reset = rstn;
   
   // instantiation of single-cycle CPU   
   SCCPU U_SCCPU(
         .clk(clk),                   // input:  cpu clock
         .reset(reset),               // input:  reset
         .inst_in(instr),             // input:  instruction
         .Data_in(dm_dout),           // input:  data to cpu  
         .mem_w(MemWrite),            // output: memory write signal
         .PC_out(PC),                 // output: PC to im
         .Addr_out(dm_addr),          // output: address from cpu to memory/dm
         .Data_out(dm_din),           // output: data from cpu to memory/dm
         .reg_sel(reg_sel),         // input:  register selection
         .reg_data(reg_data)        // output: register data
         );
   
   dm    U_DM(
         .clk(clk),           // input:  cpu clock
         .DMWr(MemWrite),     // input:  ram write
         .addr(dm_addr),      // input:  ram address
         .din(dm_din),         // input:  data to ram
         .dout(dm_dout)        // output: data from ram
         );
         
  // instantiation of intruction memory (used for simulation)
   im    U_imem ( 
         .addr(PC[31:2]),     // input:  rom address
         .dout(instr)        // output: instruction
         );
  
endmodule





















