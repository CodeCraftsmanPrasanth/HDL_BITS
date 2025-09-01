module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter a=1'b0,
    		  b=1'b1;
    reg ns,ps;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            ps<=b;
        end
        else 
            ps<=ns;
    end
    always@(ps or in) begin
        case (ps)
            b: 
                if (in) begin
                    ns<=b;
                end
                else ns<=a;
            
            a:
                if (in) begin
                    ns<=a;
                end
                else ns<=b;
            
            default: out<=0;
        endcase
    end
    assign out=(ps==b);
endmodule
