module top_module (
    input clock,
    input a,
    output p,
    output q );
    always @(*) begin
        if (clock) p=a&clock;
        else if (~clock) begin p=p;q=p;end
        
    end
endmodule
