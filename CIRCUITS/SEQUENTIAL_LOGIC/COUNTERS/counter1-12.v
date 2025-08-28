module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); 
     wire at_12 = (Q == 4'd12);
    assign c_load = reset | (enable & at_12);
    assign c_enable = enable & ~c_load;
    assign c_d = 4'd1;
    count4 counter (
        .clk(clk),
        .enable(c_enable),
        .load(c_load),
        .d(c_d),
        .Q(Q)
    );

endmodule
