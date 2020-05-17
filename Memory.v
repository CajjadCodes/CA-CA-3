module Memory(clk,adr,MemRead,MemWrite,ReadData,WriteData);
input clk;
input [31:0]adr;
input MemRead;
input MemWrite;
output [31:0]ReadData;
input [31:0]WriteData;

	reg [31:0]Mem[0:8191]; //32 KB - 16 KW

	assign ReadData = MemRead ? Mem[adr[31:2]] : 32'bz;

	always@(posedge clk) begin
		if (MemWrite) begin
			Mem[adr[31:2]] <= WriteData;
			$display("DataMemory write => Stored data %d in address %d ", WriteData, adr);
		end
	end

	initial begin
		$readmemb("Mem.inst",Mem); //Load Instructions
		$readmemb("Mem.data",Mem,250); //Load Data
	end

endmodule