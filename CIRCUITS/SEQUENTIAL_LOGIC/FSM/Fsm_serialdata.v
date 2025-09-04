module top_module(
    input  clk,
    input  in,
    input  reset,            // Synchronous reset
    output reg [7:0] out_byte,
    output reg       done
);
    localparam IDLE=3'd0, START=3'd1, DATA=3'd2, STOP=3'd3, ERROR=3'd4;

    reg [2:0] state, next_state;
    reg [3:0] count;        
    reg [7:0] store;       
   
    always @(*) begin
        case (state)
            IDLE:  next_state = in ? IDLE : START;
            START: next_state = DATA;                              
            DATA:  next_state = (count == 4'd8) ? (in ? STOP : ERROR) : DATA; 
            STOP:  next_state = in ? IDLE : START;                
            ERROR: next_state = in ? IDLE : ERROR;                
            default: next_state = IDLE;
        endcase
    end
  always @(posedge clk) begin
        if (reset) begin
            state    <= IDLE;
            count    <= 4'd0;
            store    <= 8'd0;
            out_byte <= 8'd0;
            done     <= 1'b0;
        end else begin
            state <= next_state;
            done  <= 1'b0;                

            if (next_state == DATA) begin
               store <= {in, store[7:1]};
                count <= count + 1'b1;
            end else begin
                count <= 4'd0;
            end

           if (next_state == STOP) begin
                out_byte <= store;
                done     <= 1'b1;
            end
        end
    end
endmodule
