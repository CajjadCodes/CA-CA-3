/*Multi-Cycle MIPS*/
module MIPS(clk, rst);
input clk;
input rst;
	
	wire [5:0] opc, func;
	wire zero, PCLoad;
	wire IorD, IRWrite, RegDst, JalSig1, JalSig2, MemToReg;
	wire MemRead, MemWrite, RegWrite;
	wire ALUSrcA;
	wire [1:0] ALUSrcB, PCSrc;
	wire [2:0] ALUOperation;
	
	Datapath DP(
		.clk(clk),
		.rst(rst),
		.opc(opc),
		.func(func),
		.zero(zero),
		.PCLoad(PCLoad),
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
		.ALUOperation(ALUOperation),
		.PCSrc(PCSrc)
		);

	Controller CU(
		.clk(clk),
		.rst(rst),
		.opc(opc),
		.func(func),
		.zero(zero),
		.PCLoad(PCLoad),
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
		.ALUOperation(ALUOperation),
		.PCSrc(PCSrc)
		);
endmodule
