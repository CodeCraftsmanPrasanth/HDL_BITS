module top_module(
    input clk,
    input in,
    input reset,           
    output [7:0] out_byte,
    output done
);

    parameter START = 4'd0,   
              BIT_B0 = 4'd1,
              BIT_B1 = 4'd2,
              BIT_B2 = 4'd3,
              BIT_B3 = 4'd4,
              BIT_B4 = 4'd5,
              BIT_B5 = 4'd6,
              BIT_B6 = 4'd7,
              BIT_B7 = 4'd8,
              CHECK = 4'd9,    
              STOP  = 4'd10,
              IDLE  = 4'd11,
              ERROR = 4'd12;

    reg [3:0] state, state_next;
    wire odd;
    reg valid;

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= state_next;
    end

    always @(*) begin
        case (state)
            START, BIT_B0, BIT_B1, BIT_B2, BIT_B3, BIT_B4, BIT_B5, BIT_B6, BIT_B7:
                state_next = state + 1;
            CHECK:
                state_next = in ? STOP : ERROR;
            STOP:
                state_next = in ? IDLE : START;
            IDLE:
                state_next = in ? IDLE : START;
            ERROR:
                state_next = in ? IDLE : ERROR;
            default:
                state_next = IDLE;
        endcase
    end

    wire parity_reset = (state == IDLE) || (state == STOP);
    parity parity_u0(
        .clk(clk),
        .reset(reset | parity_reset),
        .in(in),
        .odd(odd)
    );
    reg [7:0] data;
    always @(posedge clk) begin
        valid <= odd;
        if (state < BIT_B7)
            data <= {in, data[7:1]};
    end

    assign out_byte = data;
    assign done     = valid & (state == STOP);

endmodule
