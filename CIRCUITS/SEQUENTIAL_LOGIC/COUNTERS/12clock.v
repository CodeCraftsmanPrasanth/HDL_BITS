module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);
    reg [3:0] ss0, ss1, mm0, mm1, hh0, hh1;
    always @* begin
        ss = {ss1, ss0};
        mm = {mm1, mm0};
        hh = {hh1, hh0};
    end
    wire ss_rollover = (ss == 8'h59);
    wire mm_rollover = (mm == 8'h59);
    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00:00 AM
            ss0 <= 0; ss1 <= 0;
            mm0 <= 0; mm1 <= 0;
            hh0 <= 2; hh1 <= 1; // 12 in BCD
            pm <= 0; // AM
        end else if (ena) begin
            // Increment seconds
            if (ss0 == 9) begin
                ss0 <= 0;
                ss1 <= (ss1 == 5) ? 0 : ss1 + 1;
            end else begin
                ss0 <= ss0 + 1;
            end
            if (ss_rollover) begin
                if (mm0 == 9) begin
                    mm0 <= 0;
                    mm1 <= (mm1 == 5) ? 0 : mm1 + 1;
                end else begin
                    mm0 <= mm0 + 1;
                end
            end
            if (ss_rollover && mm_rollover) begin
                if (hh == 8'h11) begin
                    hh0 <= 2; hh1 <= 1; // Rollover to 12
                    pm <= ~pm; // Toggle AM/PM
                end else if (hh == 8'h12) begin
                    hh0 <= 1; hh1 <= 0; // Rollover to 01
                end else if (hh == 8'h09) begin
                    hh0 <= 0; hh1 <= 1; // 9 to 10
                end else begin
                    hh0 <= hh0 + 1;
                end
            end
        end
    end
endmodule
