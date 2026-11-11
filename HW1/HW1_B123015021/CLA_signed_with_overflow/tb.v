`timescale 10ns/100ps
`include "./top.v"

module tb;
    reg  [13:0] A, B;
    reg         mode;         
    wire [13:0] sum;
    wire        c_out;
    wire        overflow;

    adder u_adder (A, B, mode, sum, c_out, overflow);

    integer NUM  = 500;
    integer SEED = 32'hC0FFEE;
    integer WAIT = 5;

    initial begin
        $fsdbDumpfile("CLA_signed.fsdb");
        $fsdbDumpvars;
        $fsdbDumpMDA;
    end

    integer pass_cnt = 0, fail_cnt = 0;
    integer add_cnt  = 0, sub_cnt  = 0;

    reg  [14:0] expect;
    wire        exp_cout = expect[14];
    wire [13:0] exp_sum  = expect[13:0];
    reg         exp_ovf;

    task check(input [13:0] a, input [13:0] b, input m, input [127:0] tag);
        reg sa, sb, ss;
        begin
            A = a; B = b; mode = m;

            if (m) begin
                expect = {1'b0, a} + {1'b0, b};
                add_cnt = add_cnt + 1;
            end else begin
                expect = {1'b0, a} + {1'b0, ~b} + 15'd1;
                sub_cnt = sub_cnt + 1;
            end

            sa = a[13]; sb = b[13]; ss = expect[13];
            if (m)
                exp_ovf = (~(sa ^ sb)) & (sa ^ ss);
            else
                exp_ovf =  (sa ^ sb)  & (sa ^ ss);

            #(WAIT);
            if ({c_out, sum, overflow} !== {exp_cout, exp_sum, exp_ovf}) begin
                $display("=== [FAIL] %s mode=%0d A=%h B=%h  DUT={%b,%h,%b}  EXP={%b,%h,%b}  t=%0t ===",
                         tag, m, a, b, c_out, sum, overflow, exp_cout, exp_sum, exp_ovf, $time);
                fail_cnt = fail_cnt + 1;
            end else begin
                pass_cnt = pass_cnt + 1;
            end
        end
    endtask

    task run_directed;
        begin
            check(14'h0000, 14'h0000, 1'b1, "ADD 0+0=0 (no ovf)");
            check(14'h1FFF, 14'h0001, 1'b1, "ADD 8191+1=-8192 (ovf)");
            check(14'h1FFF, 14'h1FFF, 1'b1, "ADD 8191+8191=-2 (ovf)");
            check(14'h2000, 14'h3FFF, 1'b1, "ADD -8191+(-1)=8191 (ovf)");
            check(14'h2000, 14'h0001, 1'b1, "ADD -8192+1=-8191 (no ovf)");
            check(14'h0FFF, 14'h0001, 1'b1, "ADD Long carry chain: 4095+1=4096 (no ovf)");

            check(14'h0000, 14'h0000, 1'b0, "SUB 0-0=0 (no ovf)");
            check(14'h0C58, 14'h0000, 1'b0, "SUB x-0=0 (no ovf)");
            check(14'h1C56, 14'h1C56, 1'b0, "SUB x-x=0 (no ovf)");
            check(14'h1FFF, 14'h2000, 1'b0, "SUB 8191-(-8192)=-1 (ovf)");
            check(14'h2000, 14'h1FFF, 1'b0, "SUB -8192-8191=1 (ovf)");
            check(14'h2000, 14'h0001, 1'b0, "SUB -8192-1=8191 (ovf)");
        end
    endtask

    task run_random(input integer n, input integer seed);
        integer k;
        integer tmp;         
        reg [13:0] ra, rb;
        reg        rm;
        begin
            for (k = 0; k < n; k = k + 1) begin
                tmp = $random(seed);  ra = tmp[13:0];
                tmp = $random(seed);  rb = tmp[13:0];
                tmp = $random(seed);  rm = tmp[0];
                check(ra, rb, rm, "RND");
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
