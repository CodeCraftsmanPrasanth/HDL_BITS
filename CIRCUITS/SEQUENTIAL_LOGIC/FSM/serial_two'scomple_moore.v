module top_module (
    input  clk_i,
    input  rst_i,
    input  in_i,
    output out_o
);
    // State encoding
    parameter S_A = 2'b00, S_B = 2'b01, S_C = 2'b10;

    reg [1:0] curr_state, next_state;

    // State register
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            curr_state <= S_A;
        else
            curr_state <= next_state;
    end

    // Next-state combinational logic
    always @(*) begin
        case (curr_state)
            S_A: begin
                if (in_i) next_state <= S_B;
                else      next_state <= S_A;
            end
            S_B: begin
                if (in_i) next_state <= S_C;
                else      next_state <= S_B;
            end
            S_C: begin
                if (in_i) next_state <= S_C;
                else      next_state <= S_B;
            end
            default:       next_state <= S_A;
        endcase
    end

    // Moore output: high only in state S_B
    assign out_o = (curr_state == S_B);

endmodule
