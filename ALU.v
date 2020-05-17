module ALU (A, B, ALUOperation, res, zero);
input signed [31:0] A;
input signed [31:0] B;
input [2:0] ALUOperation;
output signed [31:0] res;
output zero;

	assign res = (ALUOperation == 3'b000)? A & B:
			(ALUOperation == 3'b001)? A | B:
			(ALUOperation == 3'b010)? A + B:
			(ALUOperation == 3'b011)? A - B:
			(ALUOperation == 3'b111)? (A < B)? 1 : 0 :
			32'bz;
	assign zero = ~(|res);

endmodule 
