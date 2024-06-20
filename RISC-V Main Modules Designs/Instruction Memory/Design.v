//Design of Instruction Memory

module Instruction_Memory(
input [31:0]A, // Address input
output reg [31:0]RD // Instruction output
    );
    // Instruction memory array (ROM)
    reg [31:0] mem[63:0];
    
    // Initialize the ROM with the program instructions
    initial begin
        mem[0] = 32'h00500093;  // li x1, 5 (addi x1, x0, 5)
        mem[1] = 32'h00A00113;  // li x2, 10 (addi x2, x0, 10)
        mem[2] = 32'h002081B3;  // add x3, x1, x2
        mem[3] = 32'h00300023;  // sw x3, 0(x0)
    end

    // Read operation
    always @(*) begin
        RD = mem[A[31:2]];  // Address decoding 
    end
endmodule

 
