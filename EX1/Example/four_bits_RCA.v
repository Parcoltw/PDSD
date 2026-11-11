module four_bits_RCA (A, B, Sum, C_in, C_out);

input			C_in;
input	[3:0]	A, B;

output	[3:0]	Sum;
output			C_out;

wire			C_out;
wire	[3:0]	Sum;	
wire	[4:0]	C;	

assign C = A + B + C_in;

assign {C_out, Sum} = C;

endmodule

