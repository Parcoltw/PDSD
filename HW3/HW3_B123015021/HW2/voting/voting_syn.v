/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Sat Nov 15 02:03:23 2025
/////////////////////////////////////////////////////////////


module add5_0 ( A, B, C, D, E, sum );
  output [2:0] sum;
  input A, B, C, D, E;
  wire   n1, n2, n3, n4, n5, n6, n7, n8;

  AN2D1BWP16P90 U1 ( .A1(n1), .A2(n2), .Z(sum[2]) );
  XOR2D1BWP16P90 U2 ( .A1(n1), .A2(n2), .Z(sum[1]) );
  OAI22D1BWP16P90 U3 ( .A1(n3), .A2(n4), .B1(n5), .B2(n6), .ZN(n2) );
  CKND1BWP16P90 U4 ( .I(E), .ZN(n3) );
  IOA21D1BWP16P90 U5 ( .A1(C), .A2(B), .B(n7), .ZN(n1) );
  XOR2D1BWP16P90 U6 ( .A1(n6), .A2(n5), .Z(sum[0]) );
  XOR2D1BWP16P90 U7 ( .A1(n4), .A2(E), .Z(n5) );
  OAI21D1BWP16P90 U8 ( .A1(A), .A2(n8), .B(n7), .ZN(n4) );
  ND2D1BWP16P90 U9 ( .A1(A), .A2(n8), .ZN(n7) );
  XOR2D1BWP16P90 U10 ( .A1(B), .A2(C), .Z(n8) );
  CKND1BWP16P90 U11 ( .I(D), .ZN(n6) );
endmodule


module cmp3_less_0 ( A, B, L );
  input [2:0] A;
  input [2:0] B;
  output L;
  wire   n1, n2, n3, n4, n5;

  IOA21D1BWP16P90 U1 ( .A1(n1), .A2(B[2]), .B(n2), .ZN(L) );
  OAI222D1BWP16P90 U2 ( .A1(n3), .A2(n4), .B1(B[1]), .B2(n5), .C1(B[2]), .C2(
        n1), .ZN(n2) );
  AN2D1BWP16P90 U3 ( .A1(n3), .A2(n4), .Z(n5) );
  CKND1BWP16P90 U4 ( .I(A[1]), .ZN(n4) );
  INR2D1BWP16P90 U5 ( .A1(B[0]), .B1(A[0]), .ZN(n3) );
  CKND1BWP16P90 U6 ( .I(A[2]), .ZN(n1) );
endmodule


module add5_1 ( A, B, C, D, E, sum );
  output [2:0] sum;
  input A, B, C, D, E;
  wire   n1, n2, n3, n4, n5, n6, n7, n8;

  AN2D1BWP16P90 U1 ( .A1(n1), .A2(n2), .Z(sum[2]) );
  XOR2D1BWP16P90 U2 ( .A1(n1), .A2(n2), .Z(sum[1]) );
  OAI22D1BWP16P90 U3 ( .A1(n3), .A2(n4), .B1(n5), .B2(n6), .ZN(n2) );
  CKND1BWP16P90 U4 ( .I(E), .ZN(n3) );
  IOA21D1BWP16P90 U5 ( .A1(C), .A2(B), .B(n7), .ZN(n1) );
  XOR2D1BWP16P90 U6 ( .A1(n6), .A2(n5), .Z(sum[0]) );
  XOR2D1BWP16P90 U7 ( .A1(n4), .A2(E), .Z(n5) );
  OAI21D1BWP16P90 U8 ( .A1(A), .A2(n8), .B(n7), .ZN(n4) );
  ND2D1BWP16P90 U9 ( .A1(A), .A2(n8), .ZN(n7) );
  XOR2D1BWP16P90 U10 ( .A1(B), .A2(C), .Z(n8) );
  CKND1BWP16P90 U11 ( .I(D), .ZN(n6) );
endmodule


module add5_2 ( A, B, C, D, E, sum );
  output [2:0] sum;
  input A, B, C, D, E;
  wire   n1, n2, n3, n4, n5, n6, n7, n8;

  AN2D1BWP16P90 U1 ( .A1(n1), .A2(n2), .Z(sum[2]) );
  XOR2D1BWP16P90 U2 ( .A1(n1), .A2(n2), .Z(sum[1]) );
  OAI22D1BWP16P90 U3 ( .A1(n3), .A2(n4), .B1(n5), .B2(n6), .ZN(n2) );
  CKND1BWP16P90 U4 ( .I(E), .ZN(n3) );
  IOA21D1BWP16P90 U5 ( .A1(C), .A2(B), .B(n7), .ZN(n1) );
  XOR2D1BWP16P90 U6 ( .A1(n6), .A2(n5), .Z(sum[0]) );
  XOR2D1BWP16P90 U7 ( .A1(n4), .A2(E), .Z(n5) );
  OAI21D1BWP16P90 U8 ( .A1(A), .A2(n8), .B(n7), .ZN(n4) );
  ND2D1BWP16P90 U9 ( .A1(A), .A2(n8), .ZN(n7) );
  XOR2D1BWP16P90 U10 ( .A1(B), .A2(C), .Z(n8) );
  CKND1BWP16P90 U11 ( .I(D), .ZN(n6) );
endmodule


module cmp3_less_1 ( A, B, L );
  input [2:0] A;
  input [2:0] B;
  output L;
  wire   n1, n2, n3, n4, n5;

  IOA21D1BWP16P90 U1 ( .A1(n1), .A2(B[2]), .B(n2), .ZN(L) );
  OAI222D1BWP16P90 U2 ( .A1(n3), .A2(n4), .B1(B[1]), .B2(n5), .C1(B[2]), .C2(
        n1), .ZN(n2) );
  AN2D1BWP16P90 U3 ( .A1(n3), .A2(n4), .Z(n5) );
  CKND1BWP16P90 U4 ( .I(A[1]), .ZN(n4) );
  INR2D1BWP16P90 U5 ( .A1(B[0]), .B1(A[0]), .ZN(n3) );
  CKND1BWP16P90 U6 ( .I(A[2]), .ZN(n1) );
endmodule


module cmp3_less_2 ( A, B, L );
  input [2:0] A;
  input [2:0] B;
  output L;
  wire   n1, n2, n3, n4, n5;

  IOA21D1BWP16P90 U1 ( .A1(n1), .A2(B[2]), .B(n2), .ZN(L) );
  OAI222D1BWP16P90 U2 ( .A1(n3), .A2(n4), .B1(B[1]), .B2(n5), .C1(B[2]), .C2(
        n1), .ZN(n2) );
  AN2D1BWP16P90 U3 ( .A1(n3), .A2(n4), .Z(n5) );
  CKND1BWP16P90 U4 ( .I(A[1]), .ZN(n4) );
  INR2D1BWP16P90 U5 ( .A1(B[0]), .B1(A[0]), .ZN(n3) );
  CKND1BWP16P90 U6 ( .I(A[2]), .ZN(n1) );
endmodule


module voting ( a0, a1, a2, a3, a4, out, count );
  input [2:0] a0;
  input [2:0] a1;
  input [2:0] a2;
  input [2:0] a3;
  input [2:0] a4;
  output [2:0] out;
  output [2:0] count;
  wire   n4, n5, n6;
  wire   [2:0] sum0;
  wire   [2:0] sum1;
  wire   [2:0] sum2;
  wire   [2:0] w;

  add5_0 add5_1 ( .A(a0[0]), .B(a1[0]), .C(a2[0]), .D(a3[0]), .E(a4[0]), .sum(
        sum0) );
  add5_2 add5_2 ( .A(a0[1]), .B(a1[1]), .C(a2[1]), .D(a3[1]), .E(a4[1]), .sum(
        sum1) );
  add5_1 add5_3 ( .A(a0[2]), .B(a1[2]), .C(a2[2]), .D(a3[2]), .E(a4[2]), .sum(
        sum2) );
  cmp3_less_0 cmp3_less_1 ( .A(sum2), .B(sum1), .L(w[2]) );
  cmp3_less_2 cmp3_less_2 ( .A(sum1), .B(sum0), .L(w[1]) );
  cmp3_less_1 cmp3_less_3 ( .A(sum2), .B(sum0), .L(w[0]) );
  IOA21D1BWP16P90 U11 ( .A1(sum2[2]), .A2(out[2]), .B(n4), .ZN(count[2]) );
  AOI22D1BWP16P90 U12 ( .A1(sum0[2]), .A2(out[0]), .B1(sum1[2]), .B2(out[1]), 
        .ZN(n4) );
  IOA21D1BWP16P90 U13 ( .A1(sum2[1]), .A2(out[2]), .B(n5), .ZN(count[1]) );
  AOI22D1BWP16P90 U14 ( .A1(sum0[1]), .A2(out[0]), .B1(sum1[1]), .B2(out[1]), 
        .ZN(n5) );
  IOA21D1BWP16P90 U15 ( .A1(sum2[0]), .A2(out[2]), .B(n6), .ZN(count[0]) );
  AOI22D1BWP16P90 U16 ( .A1(sum0[0]), .A2(out[0]), .B1(sum1[0]), .B2(out[1]), 
        .ZN(n6) );
  INR2D1BWP16P90 U17 ( .A1(w[2]), .B1(w[1]), .ZN(out[1]) );
  AN2D1BWP16P90 U18 ( .A1(w[1]), .A2(w[0]), .Z(out[0]) );
  NR2D1BWP16P90 U19 ( .A1(w[0]), .A2(w[2]), .ZN(out[2]) );
endmodule

