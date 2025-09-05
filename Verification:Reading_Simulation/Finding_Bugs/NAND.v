module top_module (input a, input b, input c, output out);
    wire aadd;
    andgate a1(.out(aadd), .a(a), .b(b), .c(c),.d(1'b1),.e(1'b1));
    assign out=~aadd;
endmodule
