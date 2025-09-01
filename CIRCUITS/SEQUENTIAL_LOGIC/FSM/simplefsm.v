module top_module(
    input clk,
    input reset, // synchronous reset to state B
    input in,
    output reg out
);
    parameter a=1'b0,
    		  b=1'b1;
    reg ns,ps;
    always @(posedge clk) begin
        if (reset) begin
            ps<=b;
        end
        else 
            ps<=ns;
    end
    always@(ps or in) begin
        case (ps)
            b: begin out<=1;
                if (in) begin
                    ns<=b;
                end
                else ns<=a;
            end
            a: begin out<=0;
                if (in) begin
                    ns<=a;
                end
                else ns<=b;
            end
            default: out<=0;
        endcase
    end
endmodule
