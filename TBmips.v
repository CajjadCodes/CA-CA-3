module TBmips();

	reg clk = 0, rst = 0;
	
	MIPS mips(
		.clk(clk),
		.rst(rst)
		);
	
	integer InstNum = 0;
	always #150 clk = ~clk;
	always #300 InstNum = InstNum + 1;
	initial begin
		#100
		rst = 1;
		#300
		rst = 0;
	
		#1000000
		$stop;
	end

endmodule
