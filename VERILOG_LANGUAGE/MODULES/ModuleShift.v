module top_module ( input clk, input d, output q );
    wire [1:0] e;
    my_dff (.clk(clk),.d(d),.q(e[1]));
    my_dff (.clk(clk),.d(e[1]),.q(e[0]));
    my_dff (.clk(clk),.d(e[0]),.q(q));
endmodule
