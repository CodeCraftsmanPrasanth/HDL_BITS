module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter l=0,r=1,ld=2,rd=3,lf=4,rf=5,splat=6;
    
    reg [6:0] count;  // FIX: Changed from [5:0] to [6:0] like reference
    reg [2:0] ps,ns;
    
    // Sequential logic: Handle state updates and counter
    always @(posedge clk, posedge areset) begin
        if (areset) begin 
            ps <= l;
            count <= 0;  // FIX: Reset counter during areset
        end
        else begin
            // FIX: Counter logic like reference implementation
            if (ps == lf || ps == rf) begin
                count <= count + 1;
                ps <= ns;
            end
            else begin
                ps <= ns;
                count <= 0;
            end
        end
    end
    
    // Combinatorial logic: Calculate next state
    always @(*) begin
        ns = ps;  // FIX: Default assignment to prevent latch
        
        case (ps)
            l: begin 
                if (~ground) begin
                    ns = lf;
                end
                else if (dig) begin
                    ns = ld;
                end
                else if (bump_left) begin
                    ns = r;
                end
                else ns = l;
            end
            r: begin 
                if (~ground) begin
                    ns = rf;
                end
                else if (dig) begin
                    ns = rd;
                end
                else if (bump_right) begin
                    ns = l;
                end
                else ns = r;
            end
            ld: begin 
                ns = (ground) ? ld : lf;
            end
            rd: begin 
                ns = (ground) ? rd : rf;
            end
            lf: begin
                if (ground) begin
                    if (count > 19) begin  // FIX: Changed from 20 to 19
                        ns = splat;
                    end
                    else begin
                        ns = l;
                    end
                end
                else begin
                    ns = lf;
                end
            end
            rf: begin
                if (ground) begin
                    if (count > 19) begin  // FIX: Changed from 20 to 19
                        ns = splat;
                    end
                    else begin
                        ns = r;
                    end
                end
                else begin
                    ns = rf;
                end
            end
            splat: begin
                ns = splat;
            end
            default: ns = l;  // FIX: Add default case to prevent latch
        endcase
    end
    
    // Output assignments
    assign walk_left = (ps == l);
    assign walk_right = (ps == r);
    assign aaah = (ps == lf) || (ps == rf);
    assign digging = (ps == ld) || (ps == rd);
                
endmodule
