module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	parameter LEFT=0, RIGHT=1;
	reg state;
	reg next;    
    always@(*) begin
		case (state)
			LEFT: next = bump_left  ? RIGHT : LEFT;
			RIGHT: next = bump_right ? LEFT : RIGHT;
		endcase
    end  
    always @(posedge clk, posedge areset) begin
		if (areset) state <= LEFT;
        else state <= next;
	end
	assign walk_left = (state==LEFT);
	assign walk_right = (state==RIGHT);
endmodule
