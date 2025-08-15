// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    always @(*) begin
        case (in)
            4'h1: pos = 2'd0; // ---1, first '1' is at bit 0
            4'h2: pos = 2'd1; // --10, first '1' is at bit 1
            4'h3: pos = 2'd0; // --11, first '1' is at bit 0
            4'h4: pos = 2'd2; // -100, first '1' is at bit 2
            4'h5: pos = 2'd0; // -101, first '1' is at bit 0
            4'h6: pos = 2'd1; // -110, first '1' is at bit 1
            4'h7: pos = 2'd0; // -111, first '1' is at bit 0
            4'h8: pos = 2'd3; // 1000, first '1' is at bit 3
            4'h9: pos = 2'd0; // 1001, first '1' is at bit 0
            4'ha: pos = 2'd1; // 1010, first '1' is at bit 1
            4'hb: pos = 2'd0; // 1011, first '1' is at bit 0
            4'hc: pos = 2'd2; // 1100, first '1' is at bit 2
            4'hd: pos = 2'd0; // 1101, first '1' is at bit 0
            4'he: pos = 2'd1; // 1110, first '1' is at bit 1
            4'hf: pos = 2'd0; // 1111, first '1' is at bit 0
            default: pos = 2'd0;
         
        endcase
    end
endmodule
