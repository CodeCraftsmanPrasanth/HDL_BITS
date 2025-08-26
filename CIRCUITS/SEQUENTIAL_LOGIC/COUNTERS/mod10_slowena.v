module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    always @(posedge clk) begin
        if (reset) q<=0;
        else if (slowena & q<4'h9) q<=q+1'h1;
        else if (q==4'h9 & slowena ) q<=0;
    end
endmodule
