// Testbench

module Adder_for_PCPlus4_tb;
reg pc_out;
wire PCPlus4;

Adder_for_PCPlus4 dut(pc_out, PCPlus4);

initial begin 
$dumpfile("dump.file");
$dumpvars;

pc_out<=1'b0;

#10 $finish();
end

always #2 pc_out<=~pc_out;

endmodule


