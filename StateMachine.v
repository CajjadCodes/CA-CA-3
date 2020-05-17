module StateMachine (clk, rst, RT, addi, andi, lw, sw, j, jal, jr, beq, bne,
		PCWrite, PCWriteCondBeq, PCWriteCondBne, IorD,
		IRWrite, RegDst, JalSig1, JalSig2, MemToReg, MemRead, MemWrite, RegWrite,
		ALUSrcA, ALUSrcB, ALUOp, PCSrc);
input clk;
input rst;
input RT;
input addi;
input andi;
input lw;
input sw;
input j;
input jal;
input jr;
input beq;
input bne;
output reg PCWrite;
output reg PCWriteCondBeq;
output reg PCWriteCondBne;
output reg IorD;
output reg IRWrite;
output reg RegDst;
output reg JalSig1;
output reg JalSig2; 
output reg MemToReg;
output reg MemRead;
output reg MemWrite;
output reg RegWrite;
output reg ALUSrcA;
output reg [1:0] ALUSrcB;
output reg [1:0] ALUOp; 
output reg [1:0] PCSrc;

	reg [4:0] ps, ns;
	parameter [4:0] STANDBY = 5'b11111, IF = 5'b00000, ID = 5'b00001, J3 = 5'b00010, BEQ3 = 5'b00011, BNE3 = 5'b00100,
			RT3 = 5'b00101, RT4 = 5'b00110, ADDI3 = 5'b00111, IMM4 = 5'b01000,
			ANDI3 = 5'b01001, MEMREF3= 5'b01010, SW4 = 5'b01011, LW4 = 5'b01100,
			LW5 = 5'b01101, JR3 = 5'b01110, JAL3 = 5'b01111;
	
	always @(ps or RT or addi or andi or lw or sw or j or jal or jr or beq or bne) begin
		ns = STANDBY;
		case(ps)
			STANDBY: ns = IF;
			IF: ns = ID;
			ID: ns = j? J3:
				beq? BEQ3:
				bne? BNE3:
				RT? RT3:
				addi? ADDI3:
				andi? ANDI3:
				(sw|lw)? MEMREF3:
				jr? JR3:
				jal? JAL3:
				IF;
			J3: ns = IF;
			BEQ3: ns = IF;
			BNE3: ns = IF;
			RT3: ns = RT4;
			RT4: ns = IF;
			ADDI3: ns = IMM4;
			IMM4: ns = IF;
			ANDI3: ns = IMM4;
			MEMREF3: ns = sw? SW4: 
				lw? LW4:
				IF;
			SW4: ns = IF;
			LW4: ns = LW5;
			LW5: ns = IF;
			JR3: ns = IF;
			JAL3: ns = IF;
			default: ns = IF;
		endcase
	end

	always @(ps) begin
		{PCWrite, PCWriteCondBeq, PCWriteCondBne, IorD} = 4'b0000;
		{IRWrite, RegDst, JalSig1, JalSig2, MemToReg} = 5'b00000;
		{MemRead, MemWrite, RegWrite, ALUSrcA} = 4'b0000;
		{ALUSrcB, ALUOp, PCSrc} = 6'b000000;
		case(ps)
			IF: begin {IorD, MemRead, IRWrite, ALUSrcA, PCWrite} = 5'b01101;
				ALUSrcB = 2'b01; ALUOp = 2'b00; PCSrc = 2'b00; end
			ID: begin ALUSrcA = 1'b0; ALUSrcB = 2'b11; ALUOp = 2'b00; end
			J3: begin PCWrite = 1'b1; PCSrc = 2'b01; end
			BEQ3: begin {ALUSrcA, PCWriteCondBeq} = 2'b11;
				ALUSrcB = 2'b00; ALUOp = 2'b01; PCSrc = 2'b10; end
			BNE3: begin {ALUSrcA, PCWriteCondBne} = 2'b11;
				ALUSrcB = 2'b00; ALUOp = 2'b01; PCSrc = 2'b10; end
			RT3: begin ALUSrcA = 1'b1; ALUSrcB = 2'b00; ALUOp = 2'b10; end
			RT4: {RegDst, MemToReg, JalSig1, JalSig2, RegWrite} = 5'b10001;
			ADDI3: begin ALUSrcA = 1'b1; ALUSrcB = 2'b10; ALUOp = 2'b00; end
			IMM4: {RegDst, MemToReg, JalSig1, JalSig2, RegWrite} = 5'b00001;
			ANDI3: begin ALUSrcA = 1'b1; ALUSrcB = 2'b10; ALUOp = 2'b11; end
			MEMREF3: begin ALUSrcA = 1'b1; ALUSrcB = 2'b10; ALUOp = 2'b00; end
			SW4: {IorD, MemWrite} = 2'b11;
			LW4: {IorD, MemRead} = 2'b11;
			LW5: {RegDst, MemToReg, JalSig1, JalSig2, RegWrite} = 5'b01001;
			JR3: begin PCWrite = 1'b1; PCSrc = 2'b11; end
			JAL3: begin {JalSig1, JalSig2, RegWrite, PCWrite} = 4'b1111;
				PCSrc = 2'b01; end
		endcase
	end

	always @(posedge clk or posedge rst) begin
		if (rst) ps <= STANDBY;
		else ps <= ns;
	end

endmodule
