module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire g;
    wire [31:0]j;
    assign j=b^{32{sub}};
    add16 a1( .a(a[15:0]), .b(j[15:0]),.cin(sub), .sum(sum[15:0]),.cout(g) );
    add16 a2( .a(a[31:16]), .b(j[31:16]),.cin(g), .sum(sum[31:16]),.cout() );
endmodule
