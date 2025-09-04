module top_module (
    input  clk,
    input  reset,   
    input  w,
    output z
);
    typedef enum logic [5:0] {
        A=6'b000001, B=6'b000010, C=6'b000100,
        D=6'b001000, E=6'b010000, F=6'b100000
    } state_t;

    state_t state, next;

    always @(*) begin
        unique case (state)
            A: next = w ? B : A;  
            B: next = w ? C : D;  
            C: next = w ? E : D;   
            D: next = w ? F : A;  
            E: next = w ? E : D;   
            F: next = w ? C : D;  
            default: next = A;
        endcase
    end
  always @(posedge clk) begin
        if (reset) state <= A;     
        else        state <= next;
    end

    assign z = (state == E) | (state == F);   
endmodule
