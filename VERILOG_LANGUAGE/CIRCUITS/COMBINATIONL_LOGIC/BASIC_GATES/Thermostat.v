module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
    always @(*) begin
        fan=0;heater=0; aircon=0;
        if (mode & too_cold) begin 
            fan=1;
            heater =1;
            aircon=0;
        end
        else if (~mode & too_hot) begin 
            fan=1;
            aircon=1;
            heater=0;
        end
        if (fan_on) begin 
            fan=1;
        end
    end
            
endmodule
