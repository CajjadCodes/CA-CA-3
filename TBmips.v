module TBmips();

	reg clk = 1, rst = 0;
	
	MIPS mips(
		.clk(clk),
		.rst(rst)
		);
	
	integer CycleNum = 0;
	always #150 clk = ~clk;
	always #300 CycleNum = CycleNum + 1;
	initial begin
		#100
		rst = 1;
		#300
		rst = 0;
	
		#1000000
		$stop;
	end

endmodule
