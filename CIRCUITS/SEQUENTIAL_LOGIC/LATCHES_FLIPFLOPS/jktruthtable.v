module top_module (
    input clk,
    input j,
    input k,
    output Q);
    wire d;
    assign d = (j & ~Q) | (~k & Q);
    always @(posedge clk) begin
        Q <= d;
    end   
endmodule
