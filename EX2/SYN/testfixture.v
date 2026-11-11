`timescale	10ns/100ps
//========================================
//============= Include RTL ==============



//============= Include SYN ==============



//========================================

module testfixture;

//========================================
//============= Define Path ==============

`define		PAT	"./dat/PAT.dat"
`define		EXP	"./dat/EXP.dat"

//========== Define Parameters ===========

`define		CYCLE 	10
`define		PAT_NUM	5

//========================================
//============ Declare Array =============

reg		[8:0]	pat_memory	[0:`PAT_NUM-1];
reg		[4:0]	exp_memory	[0:`PAT_NUM-1];

//============= Module Port ==============

reg				sel;
reg		[3:0]	A, B;

wire	[4:0]	sum;

//========= Varification variable =========

integer			i;

wire	[4:0]	result;

reg				clk, finish;
reg		[2:0]	pass_cnt, err_cnt;
reg		[4:0]	exp_tmp;

//========================================
//================= SDF ==================


//========================================
//=========== Clock generation ===========

always #(`CYCLE/2) clk = ~clk;

//========================================
//============ Module Import =============

add_sub add_sub (A, B, sel, sum);

//========================================

initial begin

	//============ FSDB Generation ============
	
	$fsdbDumpfile("add_sum_syn.fsdb");
	$fsdbDumpvars;
	
	//============================== .dat import ===============================
	//==                                                                      ==
	//==    There are two ways to import .dat file : $readmemb & $readmemh    ==
	//==    readmemb for loading binary data format                           ==
	//==    readmemh for loading heximal data format                         ==
	//==                                                                      ==
	//==========================================================================
	
	$readmemb(`PAT, pat_memory);
	$readmemb(`EXP, exp_memory);
	
	
	$display("\n");
	$display("=========================== Simulation START !! ===========================");
	$display("\n");
	
	clk = 1'b0;
	err_cnt  = 0;   
	pass_cnt = 0;
	
	for (i = 0; i <= `PAT_NUM; i = i+1)
	begin      
		@(posedge clk)
			exp_tmp = exp_memory[i];		// Update expected value at every posedge clock 
			{sel, A, B} = pat_memory[i];	// Update input value at every posedge clock
	end
	
end

	
always@(negedge clk) begin
	#(`CYCLE*0.2)
	if(sum != exp_tmp) begin	// Compare computed result and expected value 
			$display("                       Patern%02d:   **  Wrong!!  ** ", i);
			$display("                   Expected data is %d  Your data is %d", exp_tmp, result);
			err_cnt = err_cnt + 1;
	end
	else begin
			$display("                       Pattern%02d:  ** Correct!! ** ", i);
			pass_cnt = pass_cnt + 1;
	end
		finish = (i == `PAT_NUM);
end
	
// GUI Display

initial begin
	@(posedge finish)
		if(err_cnt == 0) begin
			$display("\n");
			$display("=========================== Simulation Finish ! ===========================");
			$display("\n");
			$display("                 ****************************              ");
			$display("                 **                        **        /|__/|");
			$display("                 **    Congratulations !!  **      / O,O  |");
			$display("                 **                        **    /_____   |");
			$display("                 **  Simulation Complete!! **   /^ ^ ^ \\  |");
			$display("                 **                        **  |^ ^ ^ ^ |w|");
			$display("                 ****************************   \\m___m__|_|");
			$display("\n");
		end
		else begin
			$display("\n");
			$display("===========================================================================");
			$display("========================= Simulation Terminated ! =========================");
			$display("\n                (T_T)  The simulation result is FAIL!!! ");
			$display("\n");
			$display("%d passes in all.\n", pass_cnt);
			$display("%d errors in all.\n", err_cnt);
			$display("===========================================================================");
		end
	#5 $finish;
end
endmodule

