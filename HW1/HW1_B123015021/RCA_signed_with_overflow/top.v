module FA (A, B, c_in, sum, c_out);
	input A, B, c_in;
	output sum, c_out;

	wire w1, w2, w3;

	xor (w1, A, B);
	xor (sum, w1, c_in);

	and (w2, w1, c_in);
	and (w3, A, B);

	or (c_out, w2, w3);
endmodule

module adder (A, B, mode, sum, c_out, overflow);
	input	[13:0]	A, B;
	input			mode;
	output	[13:0]	sum;
	output			c_out;
	output			overflow;

	wire			mode_;
	wire 	[13:0] 	B_;
	wire	[13:1]	C;

	not (mode_, mode);

	xor (B_[0],  B[0],  mode_);
	xor (B_[1],  B[1],  mode_);
	xor (B_[2],  B[2],  mode_);
	xor (B_[3],  B[3],  mode_);
	xor (B_[4],  B[4],  mode_);
	xor (B_[5],  B[5],  mode_);
	xor (B_[6],  B[6],  mode_);
	xor (B_[7],  B[7],  mode_);
	xor (B_[8],  B[8],  mode_);
	xor (B_[9],  B[9],  mode_);
	xor (B_[10], B[10], mode_);
	xor (B_[11], B[11], mode_);
	xor (B_[12], B[12], mode_);
	xor (B_[13], B[13], mode_);

	FA FA0  (A[0],  B_[0],  mode_,  sum[0],  C[1]);
	FA FA1  (A[1],  B_[1],  C[1],   sum[1],  C[2]);
	FA FA2  (A[2],  B_[2],  C[2],   sum[2],  C[3]);
	FA FA3  (A[3],  B_[3],  C[3],   sum[3],  C[4]);
	FA FA4  (A[4],  B_[4],  C[4],   sum[4],  C[5]);
	FA FA5  (A[5],  B_[5],  C[5],   sum[5],  C[6]);
	FA FA6  (A[6],  B_[6],  C[6],   sum[6],  C[7]);
	FA FA7  (A[7],  B_[7],  C[7],   sum[7],  C[8]);
	FA FA8  (A[8],  B_[8],  C[8],   sum[8],  C[9]);
	FA FA9  (A[9],  B_[9],  C[9],   sum[9],  C[10]);
	FA FA10 (A[10], B_[10], C[10],  sum[10], C[11]);
	FA FA11 (A[11], B_[11], C[11],  sum[11], C[12]);
	FA FA12 (A[12], B_[12], C[12],  sum[12], C[13]);
	FA FA13 (A[13], B_[13], C[13],  sum[13], c_out);

	xor (overflow, c_out, C[13]);
endmodule