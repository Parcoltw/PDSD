`define	ADD 1'b0
`define SUB 1'b1

module add_sub (A, B, sel, sum);

input			sel;
input	[3:0]	A, B;

output	[4:0]	sum;

reg		[4:0]	sum;

// Case 

always@(*) begin
	case(sel)
		`ADD	:	sum = A + B;
		// No default
	endcase
end

// If else
/*
always@(*) begin
	if(sel)
		sum = A + B;
	// No else	
end
*/
endmodule
