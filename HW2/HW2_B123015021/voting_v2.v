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

module cmp3_less (A, B, L);
    input [2:0] A, B;
    output L;

    wire [2:0] w1, w2;

    cmp_less cmp_less_1 (A[0], B[0], w1[0], w2[0]);
    cmp_less cmp_less_2 (A[1], B[1], w1[1], w2[1]);
    cmp_less cmp_less_3 (A[2], B[2], w1[2], w2[2]);

    assign L = w1[2] | (w2[2] & w1[1]) | (w2[2] & w2[1] & w1[0]);
endmodule

module voting (a0, a1, a2, a3, a4, out, count);
    input    [2:0]   a0, a1, a2, a3, a4;
    output   [2:0]   out, count;
	 
	reg 	 [2:0]   count;
    wire     [2:0]   sum0, sum1, sum2, w;

    add5 add5_1 (a0[0], a1[0], a2[0], a3[0], a4[0], sum0);
    add5 add5_2 (a0[1], a1[1], a2[1], a3[1], a4[1], sum1);
    add5 add5_3 (a0[2], a1[2], a2[2], a3[2], a4[2], sum2);

    cmp3_less cmp3_less_1 (sum2, sum1, w[2]);
	cmp3_less cmp3_less_2 (sum1, sum0, w[1]);
	cmp3_less cmp3_less_3 (sum2, sum0, w[0]);
	 
	assign out[0] = w[1] & w[0];
	assign out[1] = w[2] & (~w[1]);
	assign out[2] = (~w[2]) & (~w[0]);
	
	always @(*) begin
		case (out)
			3'b001: count = sum0;
			3'b010: count = sum1;
			3'b100: count = sum2;
            default: count = 3'd0;
		endcase
	end
endmodule
