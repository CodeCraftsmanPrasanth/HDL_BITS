module top_module ( );
	reg clk;
    dut uut(.clk(clk));
    always #5 clk=~clk;
    initial begin
        clk=0;
        #100 $finish;
    end
endmodule
