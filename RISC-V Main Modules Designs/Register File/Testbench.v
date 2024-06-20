// Testbench of Register File

`timescale 1ns / 1ps

module RegFile_tb;
reg WE3;
reg clk;
reg [4:0] A1;
reg [4:0] A2;
reg [4:0] A3;
reg [31:0] WD3;
wire [31:0] RD1;
wire [31:0] RD2;

RegFile uut (.WE3(WE3), .clk(clk), .A1(A1), .A2(A2), .A3(A3), .WD3(WD3), .RD1(RD1), .RD2(RD2));

initial begin
$dumpfile("dump.vcd");
$dumpvars;
clk = 1'b0;
WE3 = 1'b0;
A1 = 1'b0;
A2 = 1'b0;
A3 = 1'b0;
WD3 = 1'b0;

#10;
$finish();
end

always #1 clk<=~clk;
always #1.2 WE3<=~WE3;
always #2.2 A1<=~A1;
always #2.6 A2<=~A2;
always #2.6 A3<=~A3;
always #3.2 WD3<=~WD3;


endmodule
