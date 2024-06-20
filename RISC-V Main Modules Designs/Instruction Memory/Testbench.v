// Testbench for Instruction Memory

module Instruction_Memory_tb;

    // Inputs
    reg [31:0] A;

    // Outputs
    wire [31:0] RD;

    // Instantiate the module under test
    Instruction_Memory dut (
        .A(A),
        .RD(RD)
    );

    // Testbench stimulus
    initial begin
        // Address initialization and read operations

        // Read instruction from address 0
        A = 32'h00000000;
        #10; // Wait for some time

        // Read instruction from address 1
        A = 32'h00000004;
        #10; // Wait for some time

        // Read instruction from address 2
        A = 32'h00000008;
        #10; // Wait for some time

        // Read instruction from address 3
        A = 32'h0000000C;
        #10; // Wait for some time

        // Add more test cases as needed

        // End simulation
        $finish;
    end

endmodule
