module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
	parameter left=0,right=1,aah=2;
    reg [1:0] ps,ns;
    reg [1:0] state;
    always @( posedge clk, posedge areset) begin
        if (areset) begin
            ps<=left;
        end
        else ps<=ns;
    end
    always @(*) begin
        case (ps)
            left: begin
                ns<=(ground)? ((bump_left)? right:left):aah;
                state=left;
            end
            right: begin
                ns<=(ground)? ((bump_right)?left: right):aah;
                state=right;
            end
            aah: if (ground) ns=state;
        endcase
    end
    assign walk_left=(ps==left);
    assign walk_right=(ps==right);
    assign aaah=(ps==aah);
endmodule
