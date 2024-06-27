// Testbench

module MUX_for_ResultSrc_tb;

reg [31:0]ALUResult;
reg [31:0]RD;
reg [31:0] PCPlus4;
reg [1:0] ResultSrc;
wire [31:0]Result;

MUX_for_ResultSrc dut(ALUResult, RD, PCPlus4, ResultSrc, Result);

initial begin
$dumpfile("dump.vcd");
$dumpvars(0);

ALUResult=1'b0;
RD=1'b0;
PCPlus4=1'b0;
ResultSrc=1'b0;

#10 $finish();
end

always #2 ALUResult<=~ALUResult;
always #1.2 RD<=~RD;
always #3 PCPlus4<=~PCPlus4;
always #2.5 ResultSrc<=~ResultSrc;

endmodule
