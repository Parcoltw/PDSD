`timescale 10ns/100ps
// `include "./voting.v"
`include "./voting_syn.v"
`include "./N16ADFP_StdCell.v"

module tb;
    reg  [2:0] a0, a1, a2, a3, a4;  
    wire [2:0] out;                  
    wire [2:0] count;                

    voting u_voting (a0, a1, a2, a3, a4, out, count);
    initial $sdf_annotate ("voting_syn.sdf", u_voting);

    integer WAIT   = 5;            
    integer NUM    = 500;          
    integer SEED   = 32'hC0FFEE;   

    initial begin
        $fsdbDumpfile("voting.fsdb");
        $fsdbDumpvars;
        $fsdbDumpMDA;
    end

    integer pass_cnt = 0, fail_cnt = 0;

    function [2:0] oh(input integer idx);
    begin
        case (idx)
            0: oh = 3'b001;
            1: oh = 3'b010;
            2: oh = 3'b100;
        endcase
    end
    endfunction

    task golden(
        input  [2:0] i0, input [2:0] i1, input [2:0] i2, input [2:0] i3, input [2:0] i4,
        output [2:0] g_out, output [2:0] g_cnt
    );
        integer c0, c1, c2;
        begin
            c0 = i0[0] + i1[0] + i2[0] + i3[0] + i4[0];    // votes for 001
            c1 = i0[1] + i1[1] + i2[1] + i3[1] + i4[1];    // votes for 010
            c2 = i0[2] + i1[2] + i2[2] + i3[2] + i4[2];    // votes for 100

            if ( (c2 >= c1) && (c2 >= c0) ) begin
                g_out = 3'b100; g_cnt = c2[2:0];
            end else if ( c1 >= c0 ) begin
                g_out = 3'b010; g_cnt = c1[2:0];
            end else begin
                g_out = 3'b001; g_cnt = c0[2:0];
            end
        end
    endtask

    task check(
        input  [2:0] i0, input [2:0] i1, input [2:0] i2, input [2:0] i3, input [2:0] i4,
        input  [127:0] tag
    );
        reg  [2:0] exp_out, exp_cnt;
        begin
            a0 = i0; a1 = i1; a2 = i2; a3 = i3; a4 = i4;
            golden(i0, i1, i2, i3, i4, exp_out, exp_cnt);

            #(WAIT);

            if (out !== exp_out || count !== exp_cnt) begin
                $display("=== [FAIL] %s  a0=%b a1=%b a2=%b a3=%b a4=%b  DUT{out=%b,cnt=%0d}  EXP{out=%b,cnt=%0d}  t=%0t ===",
                         tag, i0, i1, i2, i3, i4, out, count, exp_out, exp_cnt, $time);
                fail_cnt = fail_cnt + 1;
            end else begin
                pass_cnt = pass_cnt + 1;
            end
        end
    endtask

    task run_directed;
        begin
            check(oh(2), oh(2), oh(2), oh(2), oh(2), "All 100");
            check(oh(1), oh(1), oh(1), oh(1), oh(1), "All 010");
            check(oh(0), oh(0), oh(0), oh(0), oh(0), "All 001");

            check(oh(2), oh(2), oh(2), oh(1), oh(2), "4-1-0 -> 100");
            check(oh(1), oh(1), oh(0), oh(2), oh(1), "1-3-1 -> 010");
            check(oh(0), oh(1), oh(0), oh(1), oh(0), "0-2-3 -> 001");

            check(oh(2), oh(0), oh(1), oh(2), oh(0), "2-1-2 -> 100");
            check(oh(0), oh(1), oh(1), oh(0), oh(2), "1-2-2 -> 010");
            check(oh(2), oh(1), oh(0), oh(2), oh(1), "2-2-1 -> 100");
        end
    endtask

    task run_random(input integer n, input integer seed);
        integer k;
        begin
            for (k = 0; k < n; k = k + 1) begin
                check(
                oh($random(seed) % 3),
                oh($random(seed) % 3),
                oh($random(seed) % 3),
                oh($random(seed) % 3),
                oh($random(seed) % 3),
                "RND"
                );
            end
        end
    endtask

    initial begin
        a0 = 3'b001; a1 = 3'b001; a2 = 3'b001; a3 = 3'b001; a4 = 3'b001;

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
