`timescale 1ns/10ps
// `include "./traffic_light.v"
`include "./traffic_light_syn.v"
`include "./N16ADFP_StdCell.v"

module tb_traffic_light;
    reg        clk;
    reg        reset;
    reg        pedestrian;
    wire [2:0] light1;
    wire [1:0] light2;

    integer error = 0;

    traffic_light DUT (clk, reset, pedestrian, light1, light2);
    initial $sdf_annotate ("traffic_light_syn.sdf", DUT);

    always #5 clk = ~clk;

    function [4:0] expected_lights(input [2:0] state);
        begin
            case (state)
                3'd0: expected_lights = {3'b010, 2'b00}; 
                3'd1: expected_lights = {3'b000, 2'b10}; 
                3'd2: expected_lights = {3'b001, 2'b10}; 
                3'd3: expected_lights = {3'b010, 2'b10}; 
                3'd4: expected_lights = {3'b100, 2'b10}; 
                3'd5: expected_lights = {3'b100, 2'b01}; 
                default: expected_lights = {3'b000, 2'b00};
            endcase
        end
    endfunction

    reg  [4:0] tmp_lights;
    wire [2:0] cs;

    assign cs = DUT.cs;

    initial begin
        $fsdbDumpfile("traffic_light.fsdb");
        $fsdbDumpvars;
        $fsdbDumpMDA;

        clk        = 1'b0;
        reset      = 1'b1;
        pedestrian = 1'b0;
        #10;
        reset = 1'b0;

        repeat (40) begin
            @(posedge clk);
            #1;

            tmp_lights = expected_lights(cs);

            if (tmp_lights[4:2] !== light1 || tmp_lights[1:0] !== light2) begin
                error = error + 1;
                $display("[ERROR][Phase1] @%0t: state=%0d, light1=%b, light2=%b, exp1=%b, exp2=%b",
                         $time, cs, light1, light2,
                         tmp_lights[4:2], tmp_lights[1:0]);
            end
        end


        pedestrian = 1'b1;
        repeat (2) @(posedge clk);
        pedestrian = 1'b0;

        repeat (40) begin
            @(posedge clk);
            #1;

            tmp_lights = expected_lights(cs);

            if (tmp_lights[4:2] !== light1 || tmp_lights[1:0] !== light2) begin
                error = error + 1;
                $display("[ERROR][Phase2] @%0t: state=%0d, light1=%b, light2=%b, exp1=%b, exp2=%b",
                         $time, cs, light1, light2,
                         tmp_lights[4:2], tmp_lights[1:0]);
            end
        end


        if (error == 0) begin
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
        end else begin
            $display("==== TEST FAILED: %0d error(s) ====", error);
        end
        $finish;
    end
endmodule
