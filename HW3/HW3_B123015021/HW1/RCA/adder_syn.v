/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Mon Nov 10 20:43:32 2025
/////////////////////////////////////////////////////////////


module FA_0 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_1 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_2 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_3 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_4 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_5 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_6 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_7 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_8 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_9 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_10 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_11 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_12 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module FA_13 ( A, B, c_in, sum, c_out );
  input A, B, c_in;
  output sum, c_out;
  wire   n1;

  XOR2D1BWP16P90 U1 ( .A1(c_in), .A2(n1), .Z(sum) );
  AO22D1BWP16P90 U2 ( .A1(B), .A2(A), .B1(n1), .B2(c_in), .Z(c_out) );
  XOR2D1BWP16P90 U3 ( .A1(A), .A2(B), .Z(n1) );
endmodule


module adder ( A, B, mode, sum, c_out );
  input [13:0] A;
  input [13:0] B;
  output [13:0] sum;
  input mode;
  output c_out;
  wire   n1;
  wire   [13:0] B_;
  wire   [13:1] C;

  FA_0 FA0 ( .A(A[0]), .B(B_[0]), .c_in(n1), .sum(sum[0]), .c_out(C[1]) );
  FA_13 FA1 ( .A(A[1]), .B(B_[1]), .c_in(C[1]), .sum(sum[1]), .c_out(C[2]) );
  FA_12 FA2 ( .A(A[2]), .B(B_[2]), .c_in(C[2]), .sum(sum[2]), .c_out(C[3]) );
  FA_11 FA3 ( .A(A[3]), .B(B_[3]), .c_in(C[3]), .sum(sum[3]), .c_out(C[4]) );
  FA_10 FA4 ( .A(A[4]), .B(B_[4]), .c_in(C[4]), .sum(sum[4]), .c_out(C[5]) );
  FA_9 FA5 ( .A(A[5]), .B(B_[5]), .c_in(C[5]), .sum(sum[5]), .c_out(C[6]) );
  FA_8 FA6 ( .A(A[6]), .B(B_[6]), .c_in(C[6]), .sum(sum[6]), .c_out(C[7]) );
  FA_7 FA7 ( .A(A[7]), .B(B_[7]), .c_in(C[7]), .sum(sum[7]), .c_out(C[8]) );
  FA_6 FA8 ( .A(A[8]), .B(B_[8]), .c_in(C[8]), .sum(sum[8]), .c_out(C[9]) );
  FA_5 FA9 ( .A(A[9]), .B(B_[9]), .c_in(C[9]), .sum(sum[9]), .c_out(C[10]) );
  FA_4 FA10 ( .A(A[10]), .B(B_[10]), .c_in(C[10]), .sum(sum[10]), .c_out(C[11]) );
  FA_3 FA11 ( .A(A[11]), .B(B_[11]), .c_in(C[11]), .sum(sum[11]), .c_out(C[12]) );
  FA_2 FA12 ( .A(A[12]), .B(B_[12]), .c_in(C[12]), .sum(sum[12]), .c_out(C[13]) );
  FA_1 FA13 ( .A(A[13]), .B(B_[13]), .c_in(C[13]), .sum(sum[13]), .c_out(c_out) );
  XOR2D1BWP16P90 U16 ( .A1(n1), .A2(B[9]), .Z(B_[9]) );
  XOR2D1BWP16P90 U17 ( .A1(n1), .A2(B[8]), .Z(B_[8]) );
  XOR2D1BWP16P90 U18 ( .A1(n1), .A2(B[7]), .Z(B_[7]) );
  XOR2D1BWP16P90 U19 ( .A1(n1), .A2(B[6]), .Z(B_[6]) );
  XOR2D1BWP16P90 U20 ( .A1(n1), .A2(B[5]), .Z(B_[5]) );
  XOR2D1BWP16P90 U21 ( .A1(n1), .A2(B[4]), .Z(B_[4]) );
  XOR2D1BWP16P90 U22 ( .A1(n1), .A2(B[3]), .Z(B_[3]) );
  XOR2D1BWP16P90 U23 ( .A1(n1), .A2(B[2]), .Z(B_[2]) );
  XOR2D1BWP16P90 U24 ( .A1(n1), .A2(B[1]), .Z(B_[1]) );
  XOR2D1BWP16P90 U25 ( .A1(n1), .A2(B[13]), .Z(B_[13]) );
  XOR2D1BWP16P90 U26 ( .A1(n1), .A2(B[12]), .Z(B_[12]) );
  XOR2D1BWP16P90 U27 ( .A1(n1), .A2(B[11]), .Z(B_[11]) );
  XOR2D1BWP16P90 U28 ( .A1(n1), .A2(B[10]), .Z(B_[10]) );
  XOR2D1BWP16P90 U29 ( .A1(n1), .A2(B[0]), .Z(B_[0]) );
  CKND1BWP16P90 U30 ( .I(mode), .ZN(n1) );
endmodule

