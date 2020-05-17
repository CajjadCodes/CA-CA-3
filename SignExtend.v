module SignExtend (inp, out);
input [15:0] inp;
output [31:0] out;

	assign out = {{16{inp[15]}}, inp};

endmodule
