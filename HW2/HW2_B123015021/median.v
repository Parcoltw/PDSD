module onehot_to_bin (in, out);
    input [7:0] in;
    output [2:0] out;

    assign out[2] = in[7] | in[6] | in[5] | in[4];
    assign out[1] = in[7] | in[6] | in[3] | in[2];
    assign out[0] = in[7] | in[5] | in[3] | in[1];
endmodule

module cmp_less (A, B, L, E);    // L: less than; E: equal to
    input A, B;
    output L, E;

    wire A_, B_;

    not (A_, A);
    not (B_, B);
    and (L, A_, B);
    xnor (E, A, B);
endmodule

module cmp3_less (A, B, L);    // L: less than
    input [2:0] A, B;
    output L;

    wire [2:0] w1, w2;

    cmp_less cmp_less_1 (A[0], B[0], w1[0], w2[0]);
    cmp_less cmp_less_2 (A[1], B[1], w1[1], w2[1]);
    cmp_less cmp_less_3 (A[2], B[2], w1[2], w2[2]);

    assign L = w1[2] | (w2[2] & w1[1]) | (w2[2] & w2[1] & w1[0]);
endmodule
 
module median (a0, a1, a2, out);
    input    [7:0]   a0, a1, a2;
    output   [7:0]   out;

    reg      [7:0]   out;
    wire     [2:0]   A0, A1, A2, w;

    onehot_to_bin onehot_to_bin_1 (a0, A0);
    onehot_to_bin onehot_to_bin_2 (a1, A1);
    onehot_to_bin onehot_to_bin_3 (a2, A2);

    cmp3_less cmp3_less_2 (A2, A1, w[2]);
    cmp3_less cmp3_less_1 (A1, A0, w[1]);
    cmp3_less cmp3_less_3 (A2, A0, w[0]);

    always @(*) begin
        case (w)
            3'b000: out = a1;
            3'b010: out = a0;
            3'b011: out = a2;
            3'b100: out = a2;
            3'b101: out = a0;
            3'b111: out = a1;
            default: out = 7'd0;
        endcase
    end
endmodule
