// Testbench for Data Memory

`timescale 1ns / 1ps

module Data_Memory_tb();

    // Inputs
    reg clk;
    reg WE;
    reg [31:0] A;
    reg [31:0] WD;

    // Outputs
    wire [31:0] RD;

    // Instantiate the module under test
    Data_Memory dut (
        .clk(clk),
        .WE(WE),
        .A(A),
        .WD(WD),
        .RD(RD)
    );

    // Clock generation
    always begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end

    // Testbench stimulus
    initial begin
        // Initialize inputs
        WE = 1;
        A = 32'h00000004; // Example address (assuming little-endian)
        WD = 32'hABCDEFFF; // Example data to write

        // Wait a few clock cycles
        #20;

        // Change inputs for a read operation
        WE = 0;
        A = 32'h00000004; // Example address for read

        // Wait a few clock cycles
        #20;

        // Add more test cases as needed

        // End simulation
        $finish;
    end

endmodule
