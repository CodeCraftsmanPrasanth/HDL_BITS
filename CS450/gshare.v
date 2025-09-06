module top_module(
    input         clk,
    input         areset,
    input         predict_valid,
    input  [6:0]  predict_pc,
    output        predict_taken,
    output [6:0]  predict_history,
    input         train_valid,
    input         train_taken,
    input         train_mispredicted,
    input  [6:0]  train_history,
    input  [6:0]  train_pc
);
 reg  [6:0] ghr;
    reg  [1:0] pht [0:127];
    integer i;
    wire [6:0] predict_index = predict_pc ^ ghr;
    wire [1:0] pht_predict   = pht[predict_index];
    assign predict_taken     = pht_predict[1];    
    assign predict_history   = ghr;
    wire [6:0] train_index = train_pc ^ train_history;
    function [1:0] inc2(input [1:0] s);
        case (s)
            2'b00: inc2 = 2'b01;
            2'b01: inc2 = 2'b10;
            2'b10: inc2 = 2'b11;
            default: inc2 = 2'b11; 
        endcase
    endfunction

    function [1:0] dec2(input [1:0] s);
        case (s)
            2'b00: dec2 = 2'b00; // saturate
            2'b01: dec2 = 2'b00;
            2'b10: dec2 = 2'b01;
            default: dec2 = 2'b10;
        endcase
    endfunction
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            ghr <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                pht[i] <= 2'b01;                  
        end else begin
          
            if (train_valid) begin
                if (train_taken)
                    pht[train_index] <= inc2(pht[train_index]);
                else
                    pht[train_index] <= dec2(pht[train_index]);
            end
            if (train_valid && train_mispredicted) begin
                ghr <= {train_history[5:0], train_taken};  // recover after branch
            end else if (predict_valid) begin
                ghr <= {ghr[5:0], predict_taken};          // speculative shift
            end
        end
    end

endmodule
