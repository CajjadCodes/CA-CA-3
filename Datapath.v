module Datapath(clk,rst,PCLoad,IorD,MemRead,MemWrite,IRWrite,RegDst,JalSig1,MemToReg,JalSig2,RegWrite,ALUSrcA,ALUSrcB,ALUOperation,PCSrc,opc,func,zero);
input clk;
input rst;
input PCLoad;
input IorD;
input MemRead;
input MemWrite;
input IRWrite;
input RegDst;
input JalSig1;
input MemToReg;
input JalSig2;
input RegWrite;
input ALUSrcA;
input [1:0]ALUSrcB;
input [2:0]ALUOperation;
input [1:0]PCSrc;
output [5:0]func;
output [5:0]opc;
output zero;

	wire [31:0]PCIn,PCOut;
	Reg32 PC(
		.clk(clk),
		.rst(rst),
		.d(PCIn),
		.ld(PCLoad),
		.q(PCOut)
		);

	wire [31:0]ALUOut,MemAdr;
	Mux2to1_32bit IorDMux(
		.inp0(PCOut),
		.inp1(ALUOut),
		.sel(IorD),
		.out(MemAdr)
		);

	wire [31:0]MemReadData,MemWriteData;
	Memory Mem(
		.clk(clk),
		.adr(MemAdr),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.ReadData(MemReadData),
		.WriteData(MemWriteData)
		);

	wire [31:0]IROut;
	Reg32 IR(
		.clk(clk),
		.rst(rst),
		.d(MemReadData),
		.ld(IRWrite),
		.q(IROut)
		);

	wire [31:0]MDROut;
	Reg32 MDR(
		.clk(clk),
		.rst(rst),
		.d(MemReadData),
		.ld(1'b1),
		.q(MDROut)
		);

	wire [4:0]RegDstMuxOut;
	Mux2to1_5bit RegDstMux(
		.inp0(IROut[20:16]),
		.inp1(IROut[15:11]),
		.sel(RegDst),
		.out(RegDstMuxOut)
		);

	wire [4:0]WriteReg;
	Mux2to1_5bit JalSig1Mux(
		.inp0(RegDstMuxOut),
		.inp1(5'b11111),
		.sel(JalSig1),
		.out(WriteReg)
		);

	wire [31:0]MemToRegMuxOut;
	Mux2to1_32bit MemToRegMux(
		.inp0(MDROut),
		.inp1(ALUOut),
		.sel(MemToReg),
		.out(MemToRegMuxOut)
		);

	wire [31:0]RegWriteData;
	Mux2to1_32bit JalSig2Mux(
		.inp0(MemToRegMuxOut),
		.inp1(PCOut),
		.sel(JalSig2),
		.out(RegWriteData)
		);

	wire [31:0]RegReadData1,RegReadData2;
	RegisterFile RF(
		.clk(clk),
		.rst(rst),
		.RegWrite(RegWrite),
		.ReadReg1(IROut[25:21]),
		.ReadReg2(IROut[20:16]),
		.WriteReg(WriteReg),
		.WriteData(RegWriteData),
		.ReadData1(RegReadData1),
		.ReadData2(RegReadData2)
		);

	wire [27:0]JumpAdrShifterOut;
	ShL2_26to28bit JumpAdrShifter(
		.inp(IROut[25:0]),
		.out(JumpAdrShifterOut)
		);

	wire[31:0]SEOut;
	SignExtend SE(
		.inp(IROut[15:0]),
		.out(SEOut)
		);

	wire [31:0]OffsetAdrShifterOut;
	ShL2_32bit OffsetAdrShifter(
		.inp(SEOut),
		.out(OffsetAdrShifterOut)
		);

	wire [31:0]AOut;
	Reg32 AReg(
		.clk(clk),
		.rst(rst),
		.d(RegReadData1),
		.ld(1'b1),
		.q(AOut)
		);

	wire [31:0]BOut;
	Reg32 BReg(
		.clk(clk),
		.rst(rst),
		.d(RegReadData2),
		.ld(1'b1),
		.q(BOut)
		);

	wire [31:0]A;
	Mux2to1_32bit ALUSrcAMux(
		.inp0(PCOut),
		.inp1(AOut),
		.sel(ALUSrcA),
		.out(A)
		);

	wire [31:0]B;
	Mux4to1_32bit ALUSrcBMux(
		.inp0(BOut),
		.inp1(4),
		.inp2(SEOut),
		.inp3(OffsetAdrShifterOut),
		.sel(ALUSrcB),
		.out(B)
		);

	wire [31:0]res;
	ALU alu(
		.A(A),
		.B(B),
		.ALUOperation(ALUOperation),
		.res(res),
		.zero(zero)
		);

	Reg32 ALUOutReg(
		.clk(clk),
		.rst(rst),
		.d(res),
		.ld(1'b1),
		.q(ALUOut)
		);

	Mux4to1_32bit PCSrcBMux(
		.inp0(res),
		.inp1({JumpAdrShifterOut,PCOut[31:28]}),
		.inp2(ALUOut),
		.inp3(AOut),
		.sel(PCSrc),
		.out(PCIn)
		);

endmodule
