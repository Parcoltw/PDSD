module traffic_light (clk, reset, pedestrian, light1, light2);
    input clk, reset, pedestrian;
    output reg [2:0] light1;
    output reg [1:0] light2;

    reg [2:0] cs, ns;
    reg enable, clear;
    wire [2:0] count;

    counter counter (clk, reset, enable, clear, count);

    always @(posedge clk) begin
        if (reset)
            cs <= 3'd0;
        else
            cs <= ns;
    end

    always @(*) begin
        ns = cs;
        clear = 0;
        enable = 1;

        case (cs)
            3'd0: begin
                ns = (pedestrian) ? 3'd2 : 3'd1;
                clear = 1; 
            end
            3'd1: begin
                ns = (pedestrian) ? 3'd2 : 3'd0;
                clear = 1;
            end
            3'd2:
                if (count == 3'd5) begin
                    ns = 3'd3;
                    clear = 1;
                end
            3'd3:
                if (count == 3'd2) begin
                    ns = 3'd4;
                    clear = 1;
                end
            3'd4:
                if (count == 3'd1) begin
                    ns = 3'd5;
                    clear = 1;
                end
            3'd5:
                if (count == 3'd7) begin
                    ns = 3'd1;
                    clear = 1;
                end
        endcase
    end

    always @(cs) begin
        case (cs)
            3'd0: begin light1 = 3'b010; light2 = 2'b00; end
            3'd1: begin light1 = 3'b000; light2 = 2'b10; end
            3'd2: begin light1 = 3'b001; light2 = 2'b10; end
            3'd3: begin light1 = 3'b010; light2 = 2'b10; end
            3'd4: begin light1 = 3'b100; light2 = 2'b10; end
            3'd5: begin light1 = 3'b100; light2 = 2'b01; end
            default: begin light1 = 3'b000; light2 = 2'b00; end
        endcase
    end
endmodule

module counter (clk, reset, enable, clear, count);
    input clk, reset, enable, clear;
    output reg [2:0] count;

    always @(posedge clk) begin
        if (reset || clear)
            count <= 3'd0;
        else if (enable)
            count <= count + 1;
    end
endmodule