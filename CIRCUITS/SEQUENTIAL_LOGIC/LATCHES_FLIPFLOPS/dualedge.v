module top_module (
    input clk,
    input d,
    output reg q
);
    reg x,y;
    always @(posedge clk) begin
        x<=d;
    end
    always @( negedge clk) begin
        y<=d;
    end
    assign q=(clk)?x:y;
endmodule
