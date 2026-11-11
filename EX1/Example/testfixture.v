`timescale	10ns/100ps

// Related  path (Recommended)
`include 	"./four_bits_RCA.v"

// Absolute path
//`include 	"/home/whc112/TA/PDSD/EX1/four_bits_RCA.v"

module textfixture;

reg				C_in;
reg		[3:0]	A, B;

wire 	[3:0]	Sum;
wire			C_out;

// Module Import

four_bits_RCA RCA (A, B, Sum, C_in, C_out); // module_name instance_name(port_name)

// Variable Control
initial begin
	A=0 ;B= 0; C_in = 0;
#10 A=10;B= 2; C_in = 1;
#10 A=9 ;B= 5; C_in = 1;
#10 A=2 ;B= 7; C_in = 0;
#10 A=15;B=15; C_in = 1;
#10 $finish;
end


initial begin

// "$monitor" can display multiple times when variables change 
$monitor ($time," Sum=%d A=%d B=%d C_in=%d C_out=%d ",Sum, A, B, C_in, C_out); 

// "$display" only show once
//$display($time," Sum=%d A=%d B=%d C_in=%d C_out=%d \n",Sum, A, B, C_in, C_out); 

end

// FSDB Generation
initial begin

$fsdbDumpfile("4_bits_adder.fsdb");
$fsdbDumpvars;

end

endmodule