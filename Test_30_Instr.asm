# Test File for 31 Instruction, include:
# 1. Subset 1:
# ADD/SUB/SLL/SRL/SRA/SLT/SLTU/AND/OR/XOR/ 
# SLLI/SRLI/SRAI/ 						       13				
# 2. Subset 2:
# ADDI/ANDI/ORI/XORI/LUI/SLTI/SLTIU/AUIPC	   8
# 3. Subset 3:
# LW/SW 		                               2
# 4. Subset 4:
# BEQ/BNE/BGE/BGEU/BLT/BLTU				       6
# 5. Subset 5:
# JAL/JALR						               2
# together: 31 ins
##################################################################
### Make sure following Settings :
# Settings -> Memory Configuration -> Compact, Data at address 0   

	##################
	# Test Subset 2  #
	ori x5, x0, 0x234               #x5=0x00000234
        lui x6, 0x1                     #x6=0x00001000
        or x5,x5,x6                     #x5=0x00001234
	lui x6, 0x98765                 #x6=0x98765000
	addi x7, x5, 0x345              #x7=0x00001579
	addi x8, x6, -1024              #x8=0x98764C00
	xori x9, x5, 0x7bc              #x9=0x00001588
	sltiu x3, x7, 0x34              #x3=0x00000000
	sltiu x4, x5, -1                #x4=0x00000001
	andi x18, x9, 0x765             #x18=0x00000500
	slti x20, x6, 0x123             #x20=0x00000001
	
	##################
	# Test Subset 1  #
	sub x19, x6, x5                 #x19=0x98763DCC
	xor x21, x20, x6                #x21=0x98765001
	add x22, x21, x20               #x22=0x98765002
	add x22, x22, x5                #x22=0x98766236
	sub x23, x22, x6                #x23=0x00001236
	or  x25, x23, x22               #x25=0x98767236
	and x26, x23, x22               #x26=0x00000236
	slt x27, x25, x26               #x27=1
	sltu x28, x25, x26              #x28=0
	
	### Test for shift              # pay attention to register shift
        addi x3, x3, 4                  #x3=0x00000004
	sll x27, x26, x3                #x27=0x00002360
	srl x28, x25, x3                #x28=0x09876723
	sra x29, x25, x3                #x29=0xf9876723
	slli x27, x19, 16               #x27=0x3dcc0000
	srli x28, x19, 4                #x28=0x098763dc
	srai x29, x19, 4                #x29=0xf98763dc
	
	##################
	# Test Subset 3  #     
	addi x3, x0, 0                 #x3=0x00000000
        addi x5, x0, 0xFF              #x5=0x000000ff
	
	### Test for store
	sw x19, 0(x3)                  #mem[0]=0x98763DCC
	sw x21, 4(x3)                  #mem[4]=0x98765001
	sw x23, 8(x3)                  #mem[8]=0x00001236
	
	### Test for load
        lw  x5, 0(x3)                  #x5=0x98763DCC
	lw  x7, 8(x3)                  #x7=0x00001236
		
	##################
	# Test Subset 4  #
	sw x0, 0(x3)                   #mem[0]=0x00000000
	and x9, x0, x9                 #x9=0x00000000
	bne x5, x7,  _lb1              #taken
	addi x9, x9, 1

	_lb1:
	bge  x5, x7, _lb2              #not taken
	addi x9, x9, 4                 #x9=0x00000004

	_lb2:
	bgeu x5, x7, _lb3              #taken
	addi x9, x9, 2

	_lb3:
	blt x5, x7, _lb4               #taken
	addi x9, x9, 7

	_lb4:
	bltu x5, x7, _lb4              #not taken
	addi x9, x9, 8                 #x9=0x0000000C

	_lb5:
	beq x7, x23, _lb6              #taken
	addi x9, x9, 10

	_lb6:
	sw x9, 0(x3)                   #mem[0]=0x0000000C
	
	##################
	# Test Subset 5  #
	lw x10, 0(x3)                  #x10=0x0000000C
	jal x1, F_Test_JAL             #call F_Test_JAL
	addi x10, x10, 5               #breakpoint: deadloop, update x10 everytime
	sw   x10, 12(x3)               #mem[12]=x10

F_Test_JAL:
	ori x10, x10, 0x550            #update x10 everytime
	sw  x10, 16(x3)                #mem[16]=x10
	jalr x0, x1, 0                 #ret to breakpoint



