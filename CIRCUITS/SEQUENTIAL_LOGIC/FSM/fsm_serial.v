module top_module(
    input clk,
    input in,
    input reset,
    output reg done
);
    typedef enum reg [1:0] {
        IDLE       = 2'd0,
        RECEIVE    = 2'd1,
        STOP       = 2'd2,
        ERROR_WAIT = 2'd3
    } state_t;

    state_t state, next_state;
    reg [3:0] bit_count;

    always @(*) begin
        case (state)
            IDLE: 
                next_state = (in == 1'b0) ? RECEIVE : IDLE; 

            RECEIVE: 
                next_state = (bit_count == 4'd7) ? STOP : RECEIVE;

            STOP: 
                next_state = (in == 1'b1) ? IDLE : ERROR_WAIT;

            ERROR_WAIT: 
                next_state = (in == 1'b1) ? IDLE : ERROR_WAIT;

            default: 
                next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(posedge clk) begin
        if (reset || state == IDLE)
            bit_count <= 4'd0;
        else if (state == RECEIVE)
            bit_count <= bit_count + 4'd1;
    end
    
    always @(posedge clk) begin
        if (reset)
            done <= 1'b0;
        else
            done <= (state == STOP) && (in == 1'b1);
    end

endmodule
