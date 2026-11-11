module ha (A, B, sum, c_out);
    input A, B;
    output sum, c_out;

    xor (sum, A, B);
    and (c_out, A, B);
endmodule

module fa (A, B, c_in, sum, c_out);
	input A, B, c_in;
	output sum, c_out;

	wire w1, w2, w3;

	xor (w1, A, B);
	xor (sum, w1, c_in);
	and (w2, w1, c_in);
	and (w3, A, B);
	or (c_out, w2, w3);
endmodule

module add5 (A, B, C, D, E, sum);
    input A, B, C, D, E;
    output [2:0] sum;
    
    wire w1, w2, w3;

    fa fa_1 (A, B, C, w1, w2);
    fa fa_2 (D, E, w1, sum[0], w3);

    ha ha_1 (w2, w3, sum[1], sum[2]);
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

module mux_2to1 (A, B, sel, out);    // sel=0 -> A; sel=1 -> B
    input A, B, sel;
    output out;

    wire sel_, w1, w2;

    not (sel_, sel);
    and (w1, A, sel_);
    and (w2, B, sel);
    or (out, w1, w2);
endmodule

module mux3_2to1 (A, B, sel, out);
    input [2:0] A, B;
    input sel;
    output [2:0] out;

    mux_2to1 mux_2to1_1 (A[0], B[0], sel, out[0]);
    mux_2to1 mux_2to1_2 (A[1], B[1], sel, out[1]);
    mux_2to1 mux_2to1_3 (A[2], B[2], sel, out[2]);
endmodule

module sel3_2to1 (class_A, class_B, sum_A, sum_B, class_out, sum_out);
    input [2:0] class_A, class_B, sum_A, sum_B;
    output [2:0] class_out, sum_out;

    wire w;

    cmp3_less cmp3_less_1 (sum_A, sum_B, w);

    mux3_2to1 mux3_2to1_2 (class_A, class_B, w, class_out);
    mux3_2to1 mux3_2to1_1 (sum_A, sum_B, w, sum_out);
endmodule

module voting (a0, a1, a2, a3, a4, out, count);
    input    [2:0]   a0, a1, a2, a3, a4;
    output   [2:0]   out, count;

    wire     [2:0]   sum0, sum1, sum2, class_out, sum_out;

    add5 add5_1 (a0[0], a1[0], a2[0], a3[0], a4[0], sum0);
    add5 add5_2 (a0[1], a1[1], a2[1], a3[1], a4[1], sum1);
    add5 add5_3 (a0[2], a1[2], a2[2], a3[2], a4[2], sum2);

    sel3_2to1 sel3_2to1_1 (3'b100, 3'b010, sum2, sum1, class_out, sum_out);
    sel3_2to1 sel3_2to1_2 (class_out, 3'b001, sum_out, sum0, out, count);
endmodule
