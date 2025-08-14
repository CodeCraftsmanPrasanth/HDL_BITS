module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire x;
    add16 q( .a(a[15:0]),.b(b[15:0]),.cin(1'b0), .sum(sum[15:0]), .cout(x) );
    add16 e( .a(a[31:16]),.b(b[31:16]),.cin(x), .sum(sum[31:16]), .cout() );
endmodule
