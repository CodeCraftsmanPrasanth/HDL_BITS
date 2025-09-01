module top_module (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);
    // Convert 1D index to row and column in 16x16 grid
    function automatic int wrap(int val);
        if (val < 0) wrap = val + 16;
        else if (val > 15) wrap = val - 16;
        else wrap = val;
    endfunction

    // Compute neighbors count for cell at pos (row,col)
    function automatic [3:0] neighbor_count(input reg [255:0] state, input int row, input int col);
        int r, c;
        int idx;
        int count = 0;
        for (r = -1; r <= 1; r = r + 1) begin
            for (c = -1; c <= 1; c = c + 1) begin
                if (!(r == 0 && c == 0)) begin
                    int wrapped_r = wrap(row + r);
                    int wrapped_c = wrap(col + c);
                    idx = wrapped_r * 16 + wrapped_c;
                    count = count + state[idx];
                end
            end
        end
        neighbor_count = count;
    endfunction

    integer i, row, col;
    reg [255:0] next_q;
	int neighbors;
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0; i < 256; i = i + 1) begin
                row = i / 16;
                col = i % 16;
                 neighbors = neighbor_count(q, row, col);
                case (neighbors)
                    2: next_q[i] = q[i];     // Cell state doesn't change
                    3: next_q[i] = 1'b1;     // Cell becomes alive
                    default: next_q[i] = 1'b0; // Otherwise cell dies
                endcase
            end
            q <= next_q;
        end
    end
endmodule
