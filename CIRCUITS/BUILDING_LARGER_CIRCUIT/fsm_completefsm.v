module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
	parameter s=0,s1=1,s11=2,s110=3,b0=4,b1=5,b2=6,b3=7,count=8,waitt=9;
    reg [3:0] ps,ns;
    always @(posedge clk) begin
        if (reset) begin
            ps<=s;
        end
        else ps<=ns;
    end
    always @(*) begin
        case (ps)
            s: ns=(data)?s1:s;
            s1: ns=(data)?s11:s;
            s11: ns=(data)?s11:s110;
            s110: ns=(data)?b0:s;
        	b0: ns=b1;
            b1: ns=b2;
            b2: ns=b3;
            b3: ns=count;
            count: ns=(done_counting)? waitt:count;
            waitt: ns=(ack)?s:waitt;
            default : ns=s;
        endcase
    end
    assign shift_ena=((ps==b0)|(ps==b1)|(ps==b2)|(ps==b3));
    assign counting=(ps==count);
    assign done=(ps==waitt);
endmodule
