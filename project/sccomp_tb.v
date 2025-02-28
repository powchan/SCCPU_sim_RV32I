`timescale 1ns/1ns 
module sccomp_tb();
   reg    clk, rstn;
   reg  [4:0] reg_sel;
   wire [31:0] reg_data;

   // instantiation of sccomp
   sccomp sccomp(.clk(clk), .rstn(rstn), .reg_sel(reg_sel), .reg_data(reg_data));

   initial begin
     // input instructions for simulation, rv32_sc_sim
      $readmemh("rv32_sc_sim.dat", sccomp.U_imem.RAM);

      clk = 1;
      rstn = 1;
      #10 ;
      rstn = 0;
      reg_sel = 7;
   end
   
   always begin
      #(5) clk = ~clk;
   end
   
endmodule
