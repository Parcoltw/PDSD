`timescale 10ns/100ps
// `include "./median.v"
`include "./median_syn.v"
`include "./N16ADFP_StdCell.v"

module tb;
    reg  [7:0] a0, a1, a2;
    wire [7:0] out;

    median u_median (a0, a1, a2, out);
    initial $sdf_annotate ("median_syn.sdf", u_median);

    integer WAIT = 5;             
    integer NUM  = 500;           
    integer SEED = 32'hC0FFEE;    

    initial begin
        $fsdbDumpfile("median.fsdb");
        $fsdbDumpvars;
        $fsdbDumpMDA;
    end

    integer pass_cnt = 0, fail_cnt = 0;

    function [7:0] oh(input integer idx);
    begin
        case (idx)
            0: oh = 8'b00000001;
            1: oh = 8'b00000010;
            2: oh = 8'b00000100;
            3: oh = 8'b00001000;
            4: oh = 8'b00010000;
            5: oh = 8'b00100000;
            6: oh = 8'b01000000;
            7: oh = 8'b10000000;
        endcase
    end
    endfunction

    function integer idx8(input [7:0] v);
        integer k, cnt;
        begin
            idx8 = -1;
            cnt  = 0;
            for (k = 0; k < 8; k = k + 1) begin
                if (v[k]) begin
                cnt  = cnt + 1;
                idx8 = k;
                end
            end
            if (cnt != 1) idx8 = -1;
        end
    endfunction

    // median = x + y + z - min(x,y,z) - max(x,y,z)
    task golden(
        input  [7:0] i0, input [7:0] i1, input [7:0] i2,
        output [7:0] g_out
    );
        integer x, y, z;
        integer mn, mx, md;
        begin
            x = idx8(i0); y = idx8(i1); z = idx8(i2);
            // min
            mn = x;
            if (y < mn) mn = y;
            if (z < mn) mn = z;
            // max
            mx = x;
            if (y > mx) mx = y;
            if (z > mx) mx = z;
            // median
            md = x + y + z - mn - mx;
            g_out = oh(md);
        end
    endtask

    task check(
        input  [7:0] i0, input [7:0] i1, input [7:0] i2,
        input  [127:0] tag
    );
        reg [7:0] exp_out;
        begin
            a0 = i0; a1 = i1; a2 = i2;
            golden(i0, i1, i2, exp_out);
            #(WAIT);

            if (out !== exp_out) begin
                $display("=== [FAIL] %s  a0=%b a1=%b a2=%b  DUT out=%b  EXP out=%b  t=%0t ===",
                         tag, i0, i1, i2, out, exp_out, $time);
                fail_cnt = fail_cnt + 1;
            end else begin
                pass_cnt = pass_cnt + 1;
            end
        end
    endtask

    task run_directed;
        begin
            check(oh(0), oh(0), oh(0), "all 0");
            check(oh(7), oh(7), oh(7), "all 7");
            check(oh(3), oh(3), oh(3), "all 3");

            check(oh(2), oh(2), oh(6), "2,2,6 -> 2");
            check(oh(5), oh(7), oh(7), "5,7,7 -> 7");
            check(oh(5), oh(1), oh(5), "5,1,5 -> 5");

            check(oh(0), oh(7), oh(4), "0,7,4 -> 4");
        end
    endtask

    task run_random(input integer n, input integer seed);
        integer k;
        begin
            for (k = 0; k < n; k = k + 1) begin
                check(
                oh($random(seed) % 8),
                oh($random(seed) % 8),
                oh($random(seed) % 8),
                "RND"
                );
            end
        end
    endtask

    initial begin
        a0 = 0; a1 = 0; a2 = 0;
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
