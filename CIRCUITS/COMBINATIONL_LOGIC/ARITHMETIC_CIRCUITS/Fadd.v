module top_module( 
    input a, b, cin,
    output cout, sum );
    assign {cout,sum}={{a&b|a&cin|b&cin},a^b^cin};
endmodule
