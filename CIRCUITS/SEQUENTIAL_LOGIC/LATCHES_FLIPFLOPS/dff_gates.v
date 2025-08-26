module top_module (
    input clk,
    input x,
    output z
); 
    reg [2:0] data;
    initial data=3'b000;
    always @(posedge clk) begin
        data[2]<=(data[2]^x);
        data[1]<=(x&~data[1]);
        data[0]<=(x|~data[0]);
        
    end
    assign z=~(|data);
endmodule
