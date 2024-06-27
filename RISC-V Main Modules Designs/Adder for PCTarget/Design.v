// Design of Adder for result PC Target

module Adder_for_PCTarget(
input pc_out, ImmExt,
output PCTarget
    );
    
    assign PCTarget = pc_out + ImmExt;

endmodule

