/*Multi-Cycle MIPS*/
module MIPS(clk, rst);
input clk;
input rst;
	
	wire [5:0] opc;
	wire PCWrite, PCWriteCondBeq, PCWriteCondBne;
	wire IorD, IRWrite, RegDst, JalSig1, JalSig2, MemToReg;
	wire MemRead, MemWrite, RegWrite;
	wire ALUSrcA;
	wire [1:0] ALUSrcB, ALUOp, PCSrc;
	
	Datapath DP(
		.clk(clk),
		.rst(rst),
		.opc(opc),
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

	Controller CU(
		.clk(clk),
		.rst(rst),
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
endmodule
