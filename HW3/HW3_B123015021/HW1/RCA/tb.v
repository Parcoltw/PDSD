`timescale 10ns/100ps
// `include "./top.v"
`include "./adder_syn.v"
`include "./N16ADFP_StdCell.v"

module tb;
    reg  [13:0] A, B;
    reg         mode;
    wire [13:0] sum;
    wire        c_out;

    adder u_adder (A, B, mode, sum, c_out);
    initial $sdf_annotate ("adder_syn.sdf", u_adder);

    integer NUM  = 500;
    integer SEED = 32'hC0FFEE;
    integer WAIT = 5;

    initial begin
        $fsdbDumpfile("RCA_unsigned.fsdb");
        $fsdbDumpvars;
        $fsdbDumpMDA;
    end

    integer     pass_cnt = 0, fail_cnt = 0;
    integer     add_cnt  = 0, sub_cnt  = 0;
    reg  [14:0] expect;
    wire        exp_cout = expect[14];
    wire [13:0] exp_sum  = expect[13:0];

    task check(input [13:0] a, input [13:0] b, input m, input [127:0] tag);
        begin
            A = a; B = b; mode = m;
            if (m) begin
                expect = {1'b0, a} + {1'b0, b};
                add_cnt = add_cnt + 1;
            end else begin
                expect = {1'b0, a} + {1'b0, ~b} + 15'd1;
                sub_cnt = sub_cnt + 1;
            end
            #(WAIT);
            if ({c_out, sum} !== expect[14:0]) begin
                $display("=== [FAIL] %s  mode=%0d A=%h B=%h  DUT={%b,%h}  EXP={%b,%h}  t=%0t ===",
                         tag, m, a, b, c_out, sum, expect[14], expect[13:0], $time);
                fail_cnt = fail_cnt + 1;
            end else begin
                pass_cnt = pass_cnt + 1;
            end
        end
    endtask

    task run_directed;
        begin
            check(14'h0000, 14'h0000, 1'b1, "ADD 0+0=0");
            check(14'h1276, 14'h0000, 1'b1, "ADD x+0=x");
            check(14'h3FFE, 14'h0001, 1'b1, "ADD 16382+1=16383");
            check(14'h3FFF, 14'h0001, 1'b1, "ADD 16383+1=0");
            check(14'h3FFF, 14'h3FFF, 1'b1, "ADD Large overflow: 16382+16383=16382");
            check(14'h0FFF, 14'h0001, 1'b1, "ADD Long carry chain: 4095+1=4096");

            check(14'h0000, 14'h0000, 1'b0, "SUB 0-0=0");
            check(14'h0090, 14'h0000, 1'b0, "SUB x-0=x");
            check(14'h1C56, 14'h1C56, 1'b0, "SUB x-x=0");
            check(14'h0001, 14'h0001, 1'b0, "SUB 1-1=0");
            check(14'h0001, 14'h0002, 1'b0, "SUB 1-2=16383");
            check(14'h0000, 14'h3FFF, 1'b0, "SUB 0-16383=1");
            check(14'h1000, 14'h0001, 1'b0, "SUB Long borrow chain: 4096-1=4095");
        end
    endtask

    task run_random(input integer n, input integer seed);
        integer k;
        begin
            for (k = 0; k < n; k = k + 1) begin
                check($random(seed), $random(seed), $random(seed) % 2, "RND");
            end
        end
    endtask

    initial begin
        A = 0; B = 0; mode = 0;
        run_directed;
        run_random(NUM, SEED);
        if (fail_cnt == 0) begin
            $display("╔═══════════════════════════════════════╗");
            $display("║       ┏━┓╻  ╻     ┏━┓┏━┓┏━┓┏━┓        ║");
            $display("║       ┣━┫┃  ┃     ┣━┛┣━┫┗━┓┗━┓        ║");
            $display("║       ╹ ╹┗━╸┗━╸   ╹  ╹ ╹┗━┛┗━┛        ║");
            $display("╚═══════════════════════════════════════╝");
            $display("      ⠸⣷⣦⠤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⠀⠀⠀");
            $display("      ⠀⠙⣿⡄⠈⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠔⠊⠉⣿⡿⠁⠀⠀⠀");
            $display("      ⠀⠀⠈⠣⡀⠀⠀⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠁⠀⠀⣰⠟⠀⠀⠀⣀⣀");
            $display("      ⠀⠀⠀⠀⠈⠢⣄⠀⡈⠒⠊⠉⠁⠀⠈⠉⠑⠚⠀⠀⣀⠔⢊⣠⠤⠒⠊⠉⠀⡜");
            $display("      ⠀⠀⠀⠀⠀⠀⠀⡽⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠩⡔⠊⠁⠀⠀⠀⠀⠀⠀⠇");
            $display("      ⠀⠀⠀⠀⠀⠀⠀⡇⢠⡤⢄⠀⠀⠀⠀⠀⡠⢤⣄⠀⡇⠀⠀⠀⠀⠀⠀⠀⢰⠀");
            $display("      ⠀⠀⠀⠀⠀⠀⢀⠇⠹⠿⠟⠀⠀⠤⠀⠀⠻⠿⠟⠀⣇⠀⠀⡀⠠⠄⠒⠊⠁⠀");
            $display("      ⠀⠀⠀⠀⠀⠀⢸⣿⣿⡆⠀⠰⠤⠖⠦⠴⠀⢀⣶⣿⣿⠀⠙⢄⠀⠀⠀⠀⠀⠀");
            $display("      ⠀⠀⠀⠀⠀⠀⠀⢻⣿⠃⠀⠀⠀⠀⠀⠀⠀⠈⠿⡿⠛⢄⠀⠀⠱⣄⠀⠀⠀⠀");
            $display("      ⠀⠀⠀⠀⠀⠀⠀⢸⠈⠓⠦⠀⣀⣀⣀⠀⡠⠴⠊⠹⡞⣁⠤⠒⠉⠀⠀⠀⠀⠀");
            $display("      ⠀⠀⠀⠀⠀⠀⣠⠃⠀⠀⠀⠀⡌⠉⠉⡤⠀⠀⠀⠀⢻⠿⠆⠀⠀⠀⠀⠀⠀⠀");
            $display("      ⠀⠀⠀⠀⠀⠰⠁⡀⠀⠀⠀⠀⢸⠀⢰⠃⠀⠀⠀⢠⠀⢣⠀⠀⠀⠀⠀⠀⠀⠀");
            $display("      ⠀⠀⠀⢶⣗⠧⡀⢳⠀⠀⠀⠀⢸⣀⣸⠀⠀⠀⢀⡜⠀⣸⢤⣶⠀⠀⠀⠀⠀⠀");
            $display("      ⠀⠀⠀⠈⠻⣿⣦⣈⣧⡀⠀⠀⢸⣿⣿⠀⠀⢀⣼⡀⣨⣿⡿⠁⠀⠀⠀⠀⠀⠀");
            $display("      ⠀⠀⠀⠀⠀⠈⠻⠿⠿⠓⠄⠤⠘⠉⠙⠤⢀⠾⠿⣿⠟⠋");
        end
        $finish;
    end
endmodule
