module ALUControl (ALUOp, func, ALUOperation);
input [1:0] ALUOp;
input [5:0] func;
output reg [2:0] ALUOperation;
	always @(ALUOp or func) begin
		ALUOperation = 3'b000;
		case(ALUOp)
			2'b00: ALUOperation = 3'b010;
			2'b01: ALUOperation = 3'b011;
			2'b10: begin
				case(func)
					6'b100000: ALUOperation = 3'b010;
					6'b100010: ALUOperation = 3'b011;
					6'b100100: ALUOperation = 3'b000;
					6'b100101: ALUOperation = 3'b001;
					6'b101010: ALUOperation = 3'b111;
					default: ALUOperation = 3'b000;
				endcase
			end
			2'b11: ALUOperation=3'b000;
			default: ALUOperation = 3'b000;
		endcase
	end
endmodule
