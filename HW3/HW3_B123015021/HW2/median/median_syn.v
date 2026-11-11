/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Sat Nov 15 02:22:32 2025
/////////////////////////////////////////////////////////////


module onehot_to_bin_0 ( in, out );
  input [7:0] in;
  output [2:0] out;


  OR4D1BWP16P90 U1 ( .A1(in[5]), .A2(in[4]), .A3(in[7]), .A4(in[6]), .Z(out[2]) );
  OR4D1BWP16P90 U2 ( .A1(in[3]), .A2(in[2]), .A3(in[7]), .A4(in[6]), .Z(out[1]) );
  OR4D1BWP16P90 U3 ( .A1(in[3]), .A2(in[1]), .A3(in[7]), .A4(in[5]), .Z(out[0]) );
endmodule


module onehot_to_bin_2 ( in, out );
  input [7:0] in;
  output [2:0] out;


  OR4D1BWP16P90 U1 ( .A1(in[5]), .A2(in[4]), .A3(in[7]), .A4(in[6]), .Z(out[2]) );
  OR4D1BWP16P90 U2 ( .A1(in[3]), .A2(in[2]), .A3(in[7]), .A4(in[6]), .Z(out[1]) );
  OR4D1BWP16P90 U3 ( .A1(in[3]), .A2(in[1]), .A3(in[7]), .A4(in[5]), .Z(out[0]) );
endmodule


module onehot_to_bin_1 ( in, out );
  input [7:0] in;
  output [2:0] out;


  OR4D1BWP16P90 U1 ( .A1(in[5]), .A2(in[4]), .A3(in[7]), .A4(in[6]), .Z(out[2]) );
  OR4D1BWP16P90 U2 ( .A1(in[3]), .A2(in[2]), .A3(in[7]), .A4(in[6]), .Z(out[1]) );
  OR4D1BWP16P90 U3 ( .A1(in[3]), .A2(in[1]), .A3(in[7]), .A4(in[5]), .Z(out[0]) );
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


module median ( a0, a1, a2, out );
  input [7:0] a0;
  input [7:0] a1;
  input [7:0] a2;
  output [7:0] out;
  wire   n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43;
  wire   [2:0] A0;
  wire   [2:0] A1;
  wire   [2:0] A2;
  wire   [2:0] w;

  onehot_to_bin_0 onehot_to_bin_1 ( .in(a0), .out(A0) );
  onehot_to_bin_2 onehot_to_bin_2 ( .in(a1), .out(A1) );
  onehot_to_bin_1 onehot_to_bin_3 ( .in(a2), .out(A2) );
  cmp3_less_0 cmp3_less_2 ( .A(A2), .B(A1), .L(w[2]) );
  cmp3_less_2 cmp3_less_1 ( .A(A1), .B(A0), .L(w[1]) );
  cmp3_less_1 cmp3_less_3 ( .A(A2), .B(A0), .L(w[0]) );
  IOA21D1BWP16P90 U27 ( .A1(a0[7]), .A2(n25), .B(n26), .ZN(out[7]) );
  AOI22D1BWP16P90 U28 ( .A1(a2[7]), .A2(n27), .B1(a1[7]), .B2(n28), .ZN(n26)
         );
  IOA21D1BWP16P90 U29 ( .A1(a0[6]), .A2(n25), .B(n29), .ZN(out[6]) );
  AOI22D1BWP16P90 U30 ( .A1(a2[6]), .A2(n27), .B1(a1[6]), .B2(n28), .ZN(n29)
         );
  IOA21D1BWP16P90 U31 ( .A1(a0[5]), .A2(n25), .B(n30), .ZN(out[5]) );
  AOI22D1BWP16P90 U32 ( .A1(a2[5]), .A2(n27), .B1(a1[5]), .B2(n28), .ZN(n30)
         );
  IOA21D1BWP16P90 U33 ( .A1(a0[4]), .A2(n25), .B(n31), .ZN(out[4]) );
  AOI22D1BWP16P90 U34 ( .A1(a2[4]), .A2(n27), .B1(a1[4]), .B2(n28), .ZN(n31)
         );
  IOA21D1BWP16P90 U35 ( .A1(a0[3]), .A2(n25), .B(n32), .ZN(out[3]) );
  AOI22D1BWP16P90 U36 ( .A1(a2[3]), .A2(n27), .B1(a1[3]), .B2(n28), .ZN(n32)
         );
  IOA21D1BWP16P90 U37 ( .A1(a0[2]), .A2(n25), .B(n33), .ZN(out[2]) );
  AOI22D1BWP16P90 U38 ( .A1(a2[2]), .A2(n27), .B1(a1[2]), .B2(n28), .ZN(n33)
         );
  IOA21D1BWP16P90 U39 ( .A1(a0[1]), .A2(n25), .B(n34), .ZN(out[1]) );
  AOI22D1BWP16P90 U40 ( .A1(a2[1]), .A2(n27), .B1(a1[1]), .B2(n28), .ZN(n34)
         );
  IOA21D1BWP16P90 U41 ( .A1(a0[0]), .A2(n25), .B(n35), .ZN(out[0]) );
  AOI22D1BWP16P90 U42 ( .A1(a2[0]), .A2(n27), .B1(a1[0]), .B2(n28), .ZN(n35)
         );
  MUX2ND1BWP16P90 U43 ( .I0(n36), .I1(n37), .S(w[2]), .ZN(n28) );
  ND2D1BWP16P90 U44 ( .A1(w[1]), .A2(w[0]), .ZN(n37) );
  ND2D1BWP16P90 U45 ( .A1(n38), .A2(n39), .ZN(n36) );
  MUX2ND1BWP16P90 U46 ( .I0(n40), .I1(n41), .S(w[1]), .ZN(n27) );
  IND2D1BWP16P90 U47 ( .A1(w[2]), .B1(w[0]), .ZN(n41) );
  ND2D1BWP16P90 U48 ( .A1(w[2]), .A2(n38), .ZN(n40) );
  MUX2ND1BWP16P90 U49 ( .I0(n42), .I1(n43), .S(w[2]), .ZN(n25) );
  ND2D1BWP16P90 U50 ( .A1(w[0]), .A2(n39), .ZN(n43) );
  CKND1BWP16P90 U51 ( .I(w[1]), .ZN(n39) );
  ND2D1BWP16P90 U52 ( .A1(w[1]), .A2(n38), .ZN(n42) );
  CKND1BWP16P90 U53 ( .I(w[0]), .ZN(n38) );
endmodule

