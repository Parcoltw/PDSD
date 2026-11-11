module onehot_to_bin (in, out);
    input [7:0] in;
    output [2:0] out;

    assign out[2] = in[7] | in[6] | in[5] | in[4];
    assign out[1] = in[7] | in[6] | in[3] | in[2];
    assign out[0] = in[7] | in[5] | in[3] | in[1];
endmodule

module bin_to_onehot (in, out);
    input [2:0] in;
    output [7:0] out;

    assign out[7] = in[2] & in[1] & in[0];
    assign out[6] = in[2] & in[1] & (~in[0]);
    assign out[5] = in[2] & (~in[1]) & in[0];
    assign out[4] = in[2] & (~in[1]) & (~in[0]);
    assign out[3] = (~in[2]) & in[1] & in[0];
    assign out[2] = (~in[2]) & in[1] & (~in[0]);
    assign out[1] = (~in[2]) & (~in[1]) & in[0];
    assign out[0] = (~in[2]) & (~in[1]) & (~in[0]);
endmodule

module cmp_swap (A, B, min, max);
    input [2:0] A, B;
    output [2:0] min, max;

	assign min = (A < B) ? A : B;
	assign max = (A > B) ? A : B;
endmodule
 
module median (a0, a1, a2, out);
    input    [7:0]   a0, a1, a2;
    output   [7:0]   out;

    wire     [2:0]   A0, A1, A2;
    wire     [2:0]   a1_, b1_, c1_;
    wire     [2:0]   a2_, b2_, c2_;
    wire     [2:0]   a3_, b3_, c3_;

    onehot_to_bin onehot_to_bin_1 (a0, A0);
    onehot_to_bin onehot_to_bin_2 (a1, A1);
    onehot_to_bin onehot_to_bin_3 (a2, A2);

    cmp_swap cmp_swap_1 (A0, A1, a1_, b1_);
    assign c1_ = A2;
    cmp_swap cmp_swap_2 (b1_, c1_, b2_, c2_);
    assign a2_ = a1_;
    cmp_swap cmp_swap_3 (a2_, b2_, a3_, b3_);
    assign c3_ = c2_;

    bin_to_onehot bin_to_onehot_1 (b3_, out);
endmodule
