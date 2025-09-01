module top_module(
    input clk,
    input in,
    input reset,
    output out); //

	parameter a=2'b00,
    		  b=2'b01,
    		  c=2'b10,
    		  d=2'b11;
    reg [1:0] ns,ps;
    always @(posedge clk) begin
        if (reset)
            ps<=a;
        else ps<=ns;
    end
    always @(ps or in) begin
        case (ps)
            a: ns<=(in)?b:a;
            b: ns<=(in)?b:c;
            c: ns<=(in)?d:a;
            d: ns<=(in)?b:c;
        endcase
    end
    assign out=(ps==d);
endmodule
