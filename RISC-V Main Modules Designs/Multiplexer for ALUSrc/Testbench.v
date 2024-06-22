// Testbench 

module MUX_for_ALUSrc_tb;

reg RD2, ImmExt, ALUSrc;
wire SrcB;

MUX_for_ALUSrc dut(RD2, ImmExt, ALUSrc, SrcB);

initial begin 
$dumpfile("dump.file");
$dumpvars;

RD2<=1'b0;
ImmExt<=1'b0;
ALUSrc<=1'b0;

#10 $finish();
end

always #2 RD2<=~RD2;
always #1.2 ImmExt<=~ImmExt;
always #3 ALUSrc<=~ALUSrc;

endmodule
