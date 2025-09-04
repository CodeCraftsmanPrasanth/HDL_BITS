module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
     assign out_sop = (c & d) | (~a & ~b & c);

    // Corrected Minimum Product of Sums (POS) form
    assign out_pos = c & (~a | d) & (~b | d);

endmodule
