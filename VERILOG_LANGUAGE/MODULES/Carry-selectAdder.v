module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire g;
    wire [15:0] h,j;
    add16 a1( .a(a[15:0]), .b(b[15:0]),.cin(1'b0),.sum(sum[15:0]),.cout(g));
    add16 a2( .a(a[31:16]), .b(b[31:16]),.cin(1'b0),.sum(h),.cout() );
    add16 a3( .a(a[31:16]), .b(b[31:16]),.cin(1'b1),.sum(j),.cout() );
    assign sum[31:16]= (g==0)? h:j;
endmodule
