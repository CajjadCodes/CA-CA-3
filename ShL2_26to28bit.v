module ShL2_26to28bit (inp, out);
input [25:0] inp;
output [27:0] out;

	assign out = {inp, 2'b00};
	
endmodule