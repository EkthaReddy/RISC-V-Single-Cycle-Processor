// Adder for result PCPlus4

module Adder_for_PCPlus4(
input pc_out,
output PCPlus4
    );
    assign PCPlus4 = pc_out + 4; // Increment for next instruction in program counter by four
endmodule
