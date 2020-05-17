module Mux2to1_5bit (inp0, inp1, sel, out);
input [4:0] inp0;
input [4:0] inp1;
input sel;
output [4:0] out;

	assign out = (sel == 1'b0)? inp0: 
			(sel == 1'b1)? inp1:
			5'bz;
endmodule