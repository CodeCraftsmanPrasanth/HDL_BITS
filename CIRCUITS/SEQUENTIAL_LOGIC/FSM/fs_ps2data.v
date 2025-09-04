module top_module(
    input        clk,
    input  [7:0] in,
    input        reset,          
    output reg [23:0] out_bytes, 
    output       done
);
  typedef enum logic [1:0] {B1=2'd0, B2=2'd1, B3=2'd2, D=2'd3} state_t; 
    state_t state, next;
    always @(*) begin
        unique case (state)
            B1: next = in[3] ? B2 : B1;  
            B2: next = B3;
            B3: next = D;
            D : next = in[3] ? B2 : B1;  
        endcase
    end

    always @(posedge clk) begin
        if (reset) state <= B1;
        else       state <= next;
    end

    assign done = (state == D);           
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'h000000;
        end else begin
           out_bytes <= {out_bytes[15:0], in};  
        end
    end

endmodule
