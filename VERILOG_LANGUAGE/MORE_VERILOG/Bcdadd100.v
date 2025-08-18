module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    genvar i;
    wire [98:0]f;
	generate 
        for(i=0;i<400;i=i+4) begin :adder
            if (i==0)   bcd_fadd a1(.a(a[i+3:i]),.b(b[i+3:i]),.cin(cin),.cout(f[i/4]),.sum(sum[i+3:i]));
            else if (i==396) bcd_fadd a2(.a(a[i+3:i]),.b(b[i+3:i]),.cin(f[(i/4-1)]),.cout(cout),.sum(sum[i+3:i]));
            else bcd_fadd a2(.a(a[i+3:i]),.b(b[i+3:i]),.cin(f[(i/4)-1]),.cout(f[i/4]),.sum(sum[i+3:i]));
        end
    endgenerate   
endmodule
