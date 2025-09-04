module top_module (
    input  clk,
    input  areset,
    input  x,
    output z
);
    
  reg [1:0] state, next;
    localparam A = 2'b01,
               B = 2'b10;

    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else        state <= next;
    end
    always @* begin
   
        next = state;
        case (1'b1)
            state: next = x ? B : A; 
            state[1]: next = B;       
        endcase
    end

    assign z = (state &  x) | 
               (state[1] & ~x);   
endmodule
