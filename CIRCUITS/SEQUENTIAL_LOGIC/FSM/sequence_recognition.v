module top_module(
    input clk,
    input reset,  
    input in,
    output disc,
    output flag,
    output err
);
    typedef enum logic [3:0] { S0, S1, S2, S3, S4, S5, S6, DISC, FLAG, ERROR } state_t;
    state_t s, ns;

    always @* begin
        ns = s;
        unique case (s)
            S0:    ns = in ? S1 : S0;
            S1:    ns = in ? S2 : S0;
            S2:    ns = in ? S3 : S0;
            S3:    ns = in ? S4 : S0;
            S4:    ns = in ? S5 : S0;
            S5:    ns = in ? S6 : DISC;   
            S6:    ns = in ? ERROR : FLAG; 
            DISC:  ns = in ? S1 : S0;
            FLAG:  ns = in ? S1 : S0;
            ERROR: ns = in ? ERROR : S0;  
        endcase
    end

    always @(posedge clk) begin
        if (reset) s <= S0;
        else       s <= ns;
    end

    assign disc = (s == DISC);
    assign flag = (s == FLAG);
    assign err  = (s == ERROR);
endmodule
