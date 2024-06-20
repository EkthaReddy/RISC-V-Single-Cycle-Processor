// Testbench of Program Counter (PC)

module program_counter_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] pc_in;

    // Outputs
    wire [31:0] pc_out;

    // Instantiate the module under test
    program_counter dut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // Clock generation
    always begin
        clk = 0;
        #5;  // Adjust the delay as needed based on your clock period
        clk = 1;
        #5;  // Adjust the delay as needed based on your clock period
    end

    // Testbench stimulus
    initial begin
        // Initialize inputs
        reset = 1;
        pc_in = 32'h00000000;  // Initial PC value

        // Wait a few clock cycles
        #20;

        // Release reset
        reset = 0;

        // Wait a few clock cycles to observe PC update
        #20;

        // Example: Change pc_in to test PC update
        pc_in = 32'h00000004;
        #20;

        // Add more test cases as needed

        // End simulation
        $finish;
    end

endmodule
