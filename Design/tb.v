module tb;
reg [3:0] x_in;
reg clk,rst;
wire [7:0] y_out;
fir_filter DUT (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .y_out(y_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial
    begin
        clk = 0;
        rst = 1;
        x_in = 0;

        #10 rst = 0;

        x_in = 4'd1;  #10;
        x_in = 4'd3;  #10;
        x_in = 4'd5;  #10;
        x_in = 4'd7;  #10;
        x_in = 4'd4;  #10;
        x_in = 4'd9;  #10;
        x_in = 4'd12; #10;

        #20;
        $finish;
    end
endmodule
