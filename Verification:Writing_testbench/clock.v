module top_module ;
	reg clk;
    dut a1(.clk(clk));
    always #5 clk=~clk;
    initial clk=0;
endmodule
