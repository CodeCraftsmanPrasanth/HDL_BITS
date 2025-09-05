module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    reg [1:0] count;
    reg a;
    always @(posedge clk) begin
        if (reset) begin
            shift_ena<=1;
            a<=1;
        end
        else if (!reset & a & (count==3)) begin
            shift_ena<=0;
            a<=0;
            count<=0;
        end
        else if (!reset) count<=count+1;
    end      
endmodule
