module fir_filter(
input [3:0] x_in,
input clk,rst,
output reg [7:0] y_out
);
//weighted coefficients
wire [3:0] q1,q2,q3;
parameter [3:0] h0=4'd1;
parameter [3:0] h1=4'd2;
parameter [3:0] h2=4'd3;
parameter [3:0] h3=4'd4;
//delay chain
d_ff d1(.d(x_in), .clk(clk), .rst(rst), .q(q1));
d_ff d2(.d(q1), .clk(clk), .rst(rst), .q(q2));
d_ff d3(.d(q2), .clk(clk), .rst(rst), .q(q3));
//multipilers
wire [7:0] m0,m1,m2,m3;
assign m0=x_in*h0;
assign m1=q1*h1;
assign m2=q2*h2;
assign m3=q3*h3;
//if operation
wire [7:0] y0,y1,y2,y3;
assign y0 = (x_in>q1) ? m0 : 8'd0;
assign y1 = (q1>q2) ? m1 : 8'd0;
assign y2 = (q2>q3) ? m2 : 8'd0;
assign y3 = (q3>0 ) ? m3 : 8'd0;
//accumulator
reg [7:0] sum;
always @(*)
begin
    sum = 8'd0;
    sum = sum + m0;
    sum = sum + m1;
    sum = sum + m2;
    sum = sum + m3;
end
//output register
always @ (posedge clk) begin
if (rst)
y_out<=8'd0;
else
y_out<=sum;
end
endmodule
