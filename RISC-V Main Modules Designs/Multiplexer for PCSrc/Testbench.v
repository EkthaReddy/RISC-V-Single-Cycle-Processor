// Testbench

`timescale 1ns / 1ps

module MUX_for_PCSrc_tb;

reg PCPlus4, PCTarget, PCSrc;
wire PCNext;

MUX_for_PCSrc dut(PCPlus4, PCTarget, PCSrc, PCNext);

initial begin 
$dumpfile("dump.file");
$dumpvars;

PCPlus4<=1'b0;
PCTarget<=1'b0;
PCSrc<=1'b0;

#10 $finish();
end

always #2 PCPlus4<=~PCPlus4;
always #1.2 PCTarget<=~PCTarget;
always #3 PCSrc<=~PCSrc;

endmodule
