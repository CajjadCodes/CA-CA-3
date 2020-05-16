module OpcDCD(opc, RT, addi, andi, lw, sw, j, jal, jr, beq, bne);
input [5:0]opc;
output reg RT;
output reg addi;
output reg andi;
output reg lw;
output reg sw;
output reg j;
output reg jal;
output reg jr;
output reg beq;
output reg bne;

	always @(opc) begin
		{RT, addi, andi, lw, sw, j, jal, jr, beq, bne} = 10'b0;
		case(opc)
			6'b000000: RT = 1'b1;
			6'b001000: addi = 1'b1;
			6'b001100: andi = 1'b1;
			6'b100011: lw = 1'b1;
			6'b101011: sw = 1'b1;
			6'b000010: j = 1'b1;
			6'b000011: jal = 1'b1;
			6'b110011: jr = 1'b1;
			6'b000100: beq = 1'b1;
			6'b000101: bne = 1'b1;
		endcase
	end
endmodule