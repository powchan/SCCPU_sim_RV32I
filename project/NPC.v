`include "ctrl_encode_def.v"

module NPC( PC, NPCOp, IMM, NPC );  // next pc module
   input  [31:0] PC;        // pc
   input  [2:0]  NPCOp;     // next pc operation
   input  [31:0] IMM;       // immediate
   output reg [31:0] NPC;   // next pc
   
   wire [31:0] PCPLUS4;
   assign PCPLUS4 = PC + 4; // pc + 4
   
   always @(*) begin
      case (NPCOp)
          `NPC_PLUS4:  NPC = PCPLUS4;   // NPC computes addr
          `NPC_BRANCH: NPC = PC+IMM;    //B type, NPC computes addr
          `NPC_JUMP:   NPC = PC+IMM;    //J type, NPC computes addr
          default:     NPC = PCPLUS4;
      endcase
   end 
   
endmodule
