module Reg32(clk, rst, d, ld, q);
input clk;
input rst;
input [31:0] d;
input ld;
output reg [31:0] q;
	
	always @(posedge clk or posedge rst) begin
		if (rst) q <= 32'b0;
		else if (ld) q <= d;
	end

endmodule 
