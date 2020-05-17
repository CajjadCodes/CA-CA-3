module Controller (clk, rst, opc, func, zero, PCLoad, IorD, IRWrite, RegDst,
		JalSig1, JalSig2, MemToReg, MemRead, MemWrite, RegWrite,
		ALUSrcA, ALUSrcB, ALUOperation, PCSrc);

input clk;
input rst;
input [5:0] opc;
input [5:0] func;
input zero;
output PCLoad;
output IorD;
output IRWrite;
output RegDst;
output JalSig1;
output JalSig2; 
output MemToReg;
output MemRead;
output MemWrite;
output RegWrite;
output ALUSrcA;
output [1:0] ALUSrcB;
output [2:0] ALUOperation;
output [1:0] PCSrc;

	wire RT, addi, andi, lw, sw, j, jal, jr, beq, bne;
	wire [1:0] ALUOp; 
	wire PCWrite, PCWriteCondBeq, PCWriteCondBne;

	OpcDCD opcDcd(
		.RT(RT),
		.addi(addi),
		.andi(andi),
		.lw(lw),
		.sw(sw),
		.j(j),
		.jal(jal),
		.jr(jr),
		.beq(beq),
		.bne(bne)
		);

	StateMachine SM(
		.clk(clk), 
		.rst(rst), 
		.RT(RT), 
		.addi(addi),
		.andi(andi), 
		.lw(lw), 
		.sw(sw),
		.j(j),
		.jal(jal),
		.jr(jr),
		.beq(beq),
		.bne(bne),
		.PCWrite(PCWrite), 
		.PCWriteCondBeq(PCWriteCondBeq), 
		.PCWriteCondBne(PCWriteCondBne), 
		.IorD(IorD),
		.IRWrite(IRWrite), 
		.RegDst(RegDst),
		.JalSig1(JalSig1),
		.JalSig2(JalSig2), 
		.MemToReg(MemToReg), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite), 
		.RegWrite(RegWrite),
		.ALUSrcA(ALUSrcA), 
		.ALUSrcB(ALUSrcB), 
		.ALUOp(ALUOp), 
		.PCSrc(PCSrc)
		);

	ALUControl alucu(
		.ALUOp(ALUOp),
		.func(func),
		.ALUOperation(ALUOperation)
		);

	PCLoadGen pcloadgen(
		.PCWrite(PCWrite), 
		.PCWriteCondBeq(PCWriteCondBeq), 
		.PCWriteCondBne(PCWriteCondBne), 
		.zero(zero), 
		.PCLoad(PCLoad)
		);

endmodule 