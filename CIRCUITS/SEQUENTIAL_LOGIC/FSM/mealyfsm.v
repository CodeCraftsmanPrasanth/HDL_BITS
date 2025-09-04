module top_module (
    input  clk,
    input  aresetn,
    input  x,
    output z
);
    typedef enum logic [1:0] { S0, S1, S2 } state_t;
    state_t state, next;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next;
    end

    reg z_r;
    always @* begin
        // defaults
        next = state;
        z_r  = 1'b0;

        case (state)
            S0: begin
                next = x ? S1 : S0;
            end
            S1: begin
                next = x ? S1 : S2;
            end
            S2: begin
                if (x) begin
                    next = S1;   
                    z_r  = 1'b1; 
                end else begin
                    next = S0;
                end
            end
            default: begin
                next = S0;
            end
        endcase
    end

    assign z = z_r;
endmodule
