// Testbench

module Adder_for_PCTarget_tb;

reg pc_out, ImmExt;
wire PCTarget;

Adder_for_PCTarget dut(pc_out, ImmExt, PCTarget);

initial begin 
$dumpfile("dump.file");
$dumpvars;

pc_out<=1'b0;
ImmExt<=1'b0;

#10 $finish();
end

always #2 pc_out<=~pc_out;
always #2 ImmExt<=~ImmExt;

endmodule
