`define	ADD 1'b0
`define SUB 1'b1

module add_sub (A, B, sel, sum);

input			sel;
input	[3:0]	A, B;

output	[4:0]	sum;

reg		[4:0]	sum;

always@(*) begin
	case(sel)
		`ADD	:	sum = A + B;
		`SUB	:	sum = A - B;
		default	:	sum = 5'dx;
	endcase
end

endmodule