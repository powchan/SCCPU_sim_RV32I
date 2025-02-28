 `include "ctrl_encode_def.v"

module ctrl(Op, Funct7, Funct3, Zero, 
            RegWrite, MemWrite,
            EXTOp, ALUOp, NPCOp, 
            ALUSrc, WDSel
            );
            
   input  [6:0] Op;       // opcode
   input  [6:0] Funct7;    // funct7
   input  [2:0] Funct3;    // funct3
   input        Zero;
   
   output       RegWrite; // control signal for register write
   output       MemWrite; // control signal for memory write
   output [5:0] EXTOp;    // control signal to signed extension
   output [4:0] ALUOp;    // ALU opertion
   output [2:0] NPCOp;    // next pc operation
   output       ALUSrc;   // ALU source for B 
   output [1:0] WDSel;    // (register) write data selection
   
   //Op[6]&Op[5]&Op[4]&Op[3]&Op[2]&Op[1]&Op[0];
   
   //LUI
   wire LUI = ~Op[6]&Op[5]&Op[4]&~Op[3]&Op[2]&Op[1]&Op[0];
      
  // r format 0110011
    wire rtype  = ~Op[6]&Op[5]&Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0]; //0110011
    wire i_add  = rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&~Funct3[1]&~Funct3[0]; // add 0000000 000
    wire i_sub  = rtype& ~Funct7[6]& Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&~Funct3[1]&~Funct3[0]; // sub 0100000 000
    wire i_or   = rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& Funct3[2]& Funct3[1]&~Funct3[0]; // or 0000000 110
    wire i_and  = rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& Funct3[2]& Funct3[1]& Funct3[0]; // and 0000000 111
    wire i_xor  = rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& Funct3[2]&~Funct3[1]&~Funct3[0]; // xor 0000000 100
    wire i_sll  = rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&~Funct3[1]& Funct3[0]; // sll 0000000 001
    wire i_srl  = rtype& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& Funct3[2]&~Funct3[1]& Funct3[0]; // srl 0000000 101
    wire i_sra  = rtype& ~Funct7[6]& Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& Funct3[2]&~Funct3[1]& Funct3[0]; // sra 0100000 101
    wire i_slt  = rtype & ~Funct7[6] & ~Funct7[5] & ~Funct7[4] & ~Funct7[3] & ~Funct7[2] & ~Funct7[1] & ~Funct7[0] & ~Funct3[2] & Funct3[1] & ~Funct3[0]; // slt 0000000 010
    wire i_sltu = rtype & ~Funct7[6] & ~Funct7[5] & ~Funct7[4] & ~Funct7[3] & ~Funct7[2] & ~Funct7[1] & ~Funct7[0] & ~Funct3[2] & Funct3[1] & Funct3[0]; // sltu 0000000 011
 // i format load 0000011
    wire itype_l  = ~Op[6]&~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0]; //0000011
    wire i_lw = itype_l&~Funct3[2]& Funct3[1]&~Funct3[0];//lw 010

  // i format 0010011
    wire itype_r  = ~Op[6]&~Op[5]&Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0]; //0010011
    wire i_addi  =  itype_r& ~Funct3[2]& ~Funct3[1]& ~Funct3[0]; // addi 000
    wire i_andi = itype_r& Funct3[2]& Funct3[1]&Funct3[0]; // andi 111
    wire i_ori  = itype_r& Funct3[2]& Funct3[1]&~Funct3[0]; // ori 110
    wire i_xori = itype_r& Funct3[2]&~Funct3[1]&~Funct3[0]; // xori 100
    wire i_slti = itype_r& ~Funct3[2]& Funct3[1]&~Funct3[0]; // slti 010
    wire i_sltui = itype_r& ~Funct3[2]& Funct3[1]&Funct3[0]; // sltiu 011
    wire i_slli = itype_r& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]&~Funct3[2]&~Funct3[1]& Funct3[0]; // sll 0000000 001
    wire i_srli = itype_r& ~Funct7[6]&~Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& Funct3[2]&~Funct3[1]& Funct3[0]; // srl 0000000 101
    wire i_srai = itype_r& ~Funct7[6]& Funct7[5]&~Funct7[4]&~Funct7[3]&~Funct7[2]&~Funct7[1]&~Funct7[0]& Funct3[2]&~Funct3[1]& Funct3[0]; // sra 0100000 101
    
    	
  // s format 0100011
    wire stype  = ~Op[6]&Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0]; //0100011
    wire i_sw   =  stype& ~Funct3[2]& Funct3[1]&~Funct3[0]; // sw 010

  // sb format 1100011
    wire sbtype  = Op[6]&Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];//1100011
    wire i_beq  = sbtype& ~Funct3[2]& ~Funct3[1]&~Funct3[0]; // beq 000

  // j format
    wire i_jal  = Op[6]& Op[5]&~Op[4]& Op[3]& Op[2]& Op[1]& Op[0];  // jal 1101111

  // generate control signals
  assign RegWrite   = rtype | itype_r | LUI | itype_l; // register write
  assign MemWrite   = stype;                           // memory write
  assign ALUSrc     = itype_r | LUI | itype_l | stype;   // ALU B is from instruction immediate

  // signed extension
  // EXT_CTRL_ITYPE_SHAMT 6'b100000
  // EXT_CTRL_ITYPE	      6'b010000
  // EXT_CTRL_STYPE	      6'b001000
  // EXT_CTRL_BTYPE	      6'b000100
  // EXT_CTRL_UTYPE	      6'b000010
  // EXT_CTRL_JTYPE	      6'b000001
  assign EXTOp[5]    = i_slli | i_srli | i_srai;
  assign EXTOp[4]    = i_addi | i_andi | i_ori | i_xori | i_slti | i_sltui | itype_l;
  assign EXTOp[3]    = stype; 
  assign EXTOp[2]    = sbtype; 
  assign EXTOp[1]    = LUI;
  assign EXTOp[0]    = i_jal;         
  
  // WDSel_FromALU 2'b00
  // WDSel_FromMEM 2'b01
  // WDSel_FromPC  2'b10 
    assign WDSel[1] = i_jal;
    assign WDSel[0] = itype_l;

  // NPC_PLUS4   3'b000
  // NPC_BRANCH  3'b001
  // NPC_JUMP    3'b010
  // NPC_JALR	   3'b100
    assign NPCOp[2] = 0;
    assign NPCOp[1] = i_jal;
    assign NPCOp[0] = sbtype & Zero;

// ALUOp_nop 5'b00000
// ALUOp_lui 5'b00001
// ALUOp_add 5'b00011
// ALUOp_sub 5'b00100
// ALUOp_xor 5'b01100
// ALUOp_or 5'b01101
// ALUOp_and 5'b01110
// ALUOp_sll 5'b01111
// ALUOp_srl 5'b10000
// ALUOp_sra 5'b10001
    assign ALUOp[4] = i_srl | i_sra | i_srli | i_srai;
    assign ALUOp[3] = i_and | i_andi | i_or | i_ori | i_sll| i_slli | i_xor | i_xori | i_slt | i_sltu | i_slti | i_sltui;
    assign ALUOp[2] = i_and | i_andi| i_or | i_ori | i_sub | i_beq | i_sll | i_slli | i_xor | i_xori;
    assign ALUOp[1] = i_addi | i_add | i_and | i_andi | i_sll | i_slli | itype_l | stype | i_slt | i_sltu | i_slti | i_sltui;
	  assign ALUOp[0] = i_addi | i_add | i_or | i_ori | LUI | i_sll | i_slli | i_sra | i_srai | itype_l | stype | i_sltu | i_sltui;

endmodule
