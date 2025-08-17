module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0]f,g;
    assign f=(a<b)?a:b;
    assign g=(c<d)?c:d;
    assign min=(f<g)?f:g;
    // assign intermediate_result1 = compare? true: false;

endmodule
