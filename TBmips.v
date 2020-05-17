`timescale 1ns/100ps
module TBmips();

	reg clk = 1, rst = 0;
	
	MIPS mips(
		.clk(clk),
		.rst(rst)
		);
	
	integer CycleNum = 0;
	always #1 clk = ~clk;
	always #2 CycleNum = CycleNum + 1;
	initial begin
		#0.66
		rst = 1;
		#2
		rst = 0;
	
		#4000
		$stop;
	end

endmodule
