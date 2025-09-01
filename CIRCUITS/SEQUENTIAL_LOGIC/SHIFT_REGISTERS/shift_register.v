module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg [3:0] data;
    always@(posedge clk) begin
        if (!resetn) begin
            data<=0;
        end
        else begin 
            data={in,data[3:1]};
        end
    end   
    assign out=data[0];
endmodule
