module top_module (
    input  clk,
    input  reset,   
    input  s,
    input  w,
    output z
);
  typedef enum logic { A, B } state_t;
    state_t st, st_n;
 reg [1:0] pos;    
    reg [1:0] ones;   
    reg       z_r;    
 always @(posedge clk) begin
        if (reset) st <= A;
        else       st <= st_n;
    end

    always @* begin
        case (st)
            A: st_n = s ? B : A;   
            B: st_n = B;
        endcase
    end
 always @(posedge clk) begin
        if (reset || st==A) begin
            pos  <= 2'd0;
            ones <= 2'd0;
            z_r  <= 1'b0;
        end else begin
            if (w) ones <= ones + 2'd1;
             if (pos == 2'd2) begin
                z_r  <= (ones + (w?1:0) == 2'd2);
                pos  <= 2'd0;
                ones <= 2'd0;
            end else begin
                pos  <= pos + 2'd1;
                z_r  <= 1'b0;
            end
        end
    end

    assign z = z_r;
endmodule
