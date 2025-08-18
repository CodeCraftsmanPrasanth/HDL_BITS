module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
     genvar i;
    generate 
        for(i=0;i<$bits(sum);i=i+1) begin : dgdgd
            if (i==0) adder a1(.a(a[i]),.b(b[i]),.c(cin),.cout(cout[i]),.sum(sum[i]));
            else  adder a1(.a(a[i]),.b(b[i]),.c(cout[i-1]),.cout(cout[i]),.sum(sum[i]));
        end
    endgenerate
endmodule
module adder(input a,b,c,output cout,sum);
    assign sum={a^b^c};
    assign cout={(a&b)|(b&c)|(a&c)};
endmodule
