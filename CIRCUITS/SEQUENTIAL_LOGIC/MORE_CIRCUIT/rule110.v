module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
);
    integer i;
    always @(posedge clk) begin
        if (load) begin
            q<=data;
        end
        else begin
            q[0]<=(q[1])?q[0]^1'b0:q[0]|1'b0;
            q[511]<=q[511]|q[510];
            for (i=1;i<511;i=i+1) begin
                if (q[i+1]) begin
                    q[i]<=q[i]^q[i-1];
                end
                else begin
                    q[i]<=q[i]|q[i-1];
            end
        end
        end
    end
endmodule
