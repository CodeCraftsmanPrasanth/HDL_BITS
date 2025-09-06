module top_module ();
    reg clk;
    reg reset;
    reg t;
    wire q;
    
    tff u_tff(.clk(clk),.reset(reset),.t(t),.q(q));
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    
    initial begin
        reset = 0;
        #3;
        reset = 1;
        #10;
        reset = 0;   
    end
    
    always@(posedge clk)begin
        if(reset)begin
            t <= 0;
        end
        else begin
            t <= 1;
        end
    end

endmodule
