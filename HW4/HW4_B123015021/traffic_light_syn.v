/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Tue Nov 25 17:20:17 2025
/////////////////////////////////////////////////////////////


module counter ( clk, reset, enable, clear, count );
  output [2:0] count;
  input clk, reset, enable, clear;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20;

  DFQD2BWP16P90LVT count_reg_0_ ( .D(n20), .CP(clk), .Q(count[0]) );
  DFQD2BWP16P90LVT count_reg_1_ ( .D(n18), .CP(clk), .Q(count[1]) );
  DFQD2BWP16P90LVT count_reg_2_ ( .D(n19), .CP(clk), .Q(count[2]) );
  AO22D1BWP16P90LVT U3 ( .A1(n7), .A2(count[0]), .B1(count[1]), .B2(n11), .Z(
        n1) );
  IAO21D1BWP16P90LVT U4 ( .A1(n8), .A2(n1), .B(clear), .ZN(n18) );
  AOI21D2BWP16P90LVT U5 ( .A1(n17), .A2(n16), .B(clear), .ZN(n19) );
  CKND1BWP16P90LVT U6 ( .I(n9), .ZN(n10) );
  CKND1BWP16P90LVT U7 ( .I(n6), .ZN(n11) );
  NR2D1BWP16P90LVT U8 ( .A1(n9), .A2(n4), .ZN(n8) );
  NR2D1BWP16P90 U9 ( .A1(n5), .A2(count[1]), .ZN(n7) );
  INVD1BWP16P90LVT U10 ( .I(reset), .ZN(n14) );
  ND2D1BWP16P90LVT U11 ( .A1(enable), .A2(n14), .ZN(n5) );
  INVD1BWP16P90LVT U12 ( .I(enable), .ZN(n2) );
  ND2D1BWP16P90LVT U13 ( .A1(n14), .A2(n2), .ZN(n6) );
  MUX2D1BWP16P90LVT U14 ( .I0(n5), .I1(n6), .S(count[0]), .Z(n3) );
  NR2D1BWP16P90LVT U15 ( .A1(clear), .A2(n3), .ZN(n20) );
  INVD1BWP16P90LVT U16 ( .I(count[0]), .ZN(n12) );
  ND2D1BWP16P90LVT U17 ( .A1(n14), .A2(n12), .ZN(n9) );
  INVD1BWP16P90LVT U18 ( .I(count[1]), .ZN(n4) );
  AOI22D1BWP16P90LVT U19 ( .A1(count[2]), .A2(n11), .B1(n10), .B2(count[2]), 
        .ZN(n17) );
  NR2D1BWP16P90LVT U20 ( .A1(count[2]), .A2(n12), .ZN(n13) );
  MUX2D1BWP16P90LVT U21 ( .I0(count[2]), .I1(n13), .S(count[1]), .Z(n15) );
  ND3D1BWP16P90LVT U22 ( .A1(enable), .A2(n15), .A3(n14), .ZN(n16) );
endmodule


module traffic_light ( clk, reset, pedestrian, light1, light2 );
  output [2:0] light1;
  output [1:0] light2;
  input clk, reset, pedestrian;
  wire   n_Logic1_, N24, N25, N26, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68;
  wire   [2:0] count;
  wire   [2:0] cs;

  counter counter ( .clk(clk), .reset(reset), .enable(n_Logic1_), .clear(n68), 
        .count(count) );
  DFQD2BWP16P90LVT cs_reg_0_ ( .D(N24), .CP(clk), .Q(cs[0]) );
  DFQD2BWP16P90LVT cs_reg_1_ ( .D(N25), .CP(clk), .Q(cs[1]) );
  DFQD2BWP16P90LVT cs_reg_2_ ( .D(N26), .CP(clk), .Q(cs[2]) );
  TIEHBWP20P90LVT U39 ( .Z(n_Logic1_) );
  ND2D1BWP16P90LVT U40 ( .A1(cs[0]), .A2(cs[1]), .ZN(n64) );
  NR2D1BWP16P90LVT U41 ( .A1(n60), .A2(count[0]), .ZN(n31) );
  CKND1BWP16P90LVT U42 ( .I(cs[2]), .ZN(n65) );
  ND2D1BWP16P90LVT U43 ( .A1(n28), .A2(n40), .ZN(n63) );
  ND2D1BWP16P90LVT U44 ( .A1(n49), .A2(n55), .ZN(n32) );
  ND2D2BWP16P90LVT U45 ( .A1(n48), .A2(count[2]), .ZN(n33) );
  ND2D1BWP16P90LVT U46 ( .A1(n33), .A2(n32), .ZN(n61) );
  ND3D1BWP16P90LVT U47 ( .A1(n28), .A2(n40), .A3(n59), .ZN(n50) );
  CKND1BWP16P90LVT U48 ( .I(n64), .ZN(n28) );
  NR2D1BWP16P90LVT U49 ( .A1(n61), .A2(n60), .ZN(n30) );
  IINR3D2BWP16P90LVT U50 ( .A1(cs[2]), .A2(cs[0]), .B1(cs[1]), .ZN(light2[0])
         );
  AOAI211D1BWP16P90LVT U51 ( .A1(n33), .A2(n32), .B(n62), .C(n50), .ZN(n52) );
  INVD1BWP16P90 U52 ( .I(cs[1]), .ZN(n29) );
  OAI21D2BWP16P90LVT U53 ( .A1(n59), .A2(n63), .B(n58), .ZN(n60) );
  AN3D1BWP16P90LVT U54 ( .A1(n65), .A2(n47), .A3(cs[1]), .Z(light1[0]) );
  ND2D2BWP16P90LVT U55 ( .A1(light1[0]), .A2(n34), .ZN(n35) );
  NR2D2BWP16P90LVT U56 ( .A1(n30), .A2(n31), .ZN(n68) );
  OA21D1BWP16P90 U57 ( .A1(n42), .A2(n41), .B(n64), .Z(n37) );
  AOI22D1BWP16P90 U58 ( .A1(n41), .A2(n63), .B1(pedestrian), .B2(n44), .ZN(n45) );
  ND2D2BWP16P90LVT U59 ( .A1(light2[0]), .A2(count[1]), .ZN(n36) );
  ND2D2BWP16P90LVT U60 ( .A1(n35), .A2(n36), .ZN(n48) );
  CKND1BWP16P90 U61 ( .I(count[1]), .ZN(n34) );
  INVD1BWP16P90 U62 ( .I(n67), .ZN(light1[2]) );
  CKND1BWP16P90LVT U63 ( .I(n58), .ZN(n44) );
  INVD1BWP16P90LVT U64 ( .I(n47), .ZN(n42) );
  NR2D1BWP16P90LVT U65 ( .A1(pedestrian), .A2(n58), .ZN(n46) );
  CKND1BWP16P90LVT U66 ( .I(reset), .ZN(n51) );
  MUX2D1BWP16P90 U67 ( .I0(n46), .I1(n43), .S(n42), .Z(n53) );
  OAOI211D1BWP16P90 U68 ( .A1(n59), .A2(n63), .B(n57), .C(reset), .ZN(N26) );
  INVD1BWP16P90LVT U69 ( .I(cs[0]), .ZN(n47) );
  INVD1BWP16P90LVT U70 ( .I(cs[1]), .ZN(n54) );
  INVD1BWP16P90 U71 ( .I(cs[2]), .ZN(n40) );
  INVD1BWP16P90 U72 ( .I(n29), .ZN(n41) );
  OAI21D1BWP16P90 U73 ( .A1(n42), .A2(n40), .B(n63), .ZN(n66) );
  ND3D1BWP16P90 U74 ( .A1(n42), .A2(n29), .A3(count[0]), .ZN(n56) );
  INVD1BWP16P90 U75 ( .I(n40), .ZN(n43) );
  ND2D1BWP16P90LVT U76 ( .A1(n54), .A2(n65), .ZN(n58) );
  INVD1BWP16P90LVT U77 ( .I(count[0]), .ZN(n62) );
  INVD1BWP16P90LVT U78 ( .I(count[2]), .ZN(n55) );
  ND3D1BWP16P90LVT U79 ( .A1(count[1]), .A2(n62), .A3(n55), .ZN(n59) );
  AOI21D1BWP16P90LVT U80 ( .A1(n45), .A2(n50), .B(reset), .ZN(N25) );
  ND2D1BWP16P90LVT U81 ( .A1(cs[2]), .A2(n54), .ZN(n67) );
  NR3D1BWP16P90LVT U82 ( .A1(n67), .A2(cs[0]), .A3(count[1]), .ZN(n49) );
  OA21D1BWP16P90LVT U83 ( .A1(n52), .A2(n53), .B(n51), .Z(N24) );
  OAI31D1BWP16P90LVT U84 ( .A1(n56), .A2(n34), .A3(n55), .B(n43), .ZN(n57) );
  MUX2D1BWP16P90LVT U85 ( .I0(n66), .I1(n40), .S(n37), .Z(light2[1]) );
  NR2D1BWP16P90LVT U86 ( .A1(n43), .A2(n37), .ZN(light1[1]) );
endmodule

