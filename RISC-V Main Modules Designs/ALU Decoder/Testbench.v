module ALUDecoder_tb;

    // Testbench signals
    reg [6:0] op;
    reg [2:0] funct3;
    reg funct7;
    reg [1:0] ALUop;
    wire [2:0] ALUControl;

    // Instantiate the ALUDecoder
    ALUDecoder uut (
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .ALUop(ALUop),
        .ALUControl(ALUControl)
    );

    // Testbench logic
    initial begin
        $dumpfile("dump.file");
        $dumpvars;
        // Initialize inputs
        op = 7'b0000000;
        funct3 = 3'b000;
        funct7 = 1'b0;
        ALUop = 2'b00;

        // Apply test vectors
        #10;
        ALUop = 2'b00; // Test ADD
        #10;
        ALUop = 2'b01; // Test SUB
        #10;
        ALUop = 2'b10; // Test R-type instructions
        
        // Test ADD
        op = 7'b0000000;
        funct3 = 3'b000;
        funct7 = 1'b0;
        #10;
        
        // Test SUB
        op = 7'b0100000;
        funct3 = 3'b000;
        funct7 = 1'b0;
        #10;
        
        // Test AND
        op = 7'b0000000;
        funct3 = 3'b111;
        funct7 = 1'b0;
        #10;
        
        // Test OR
        op = 7'b0000000;
        funct3 = 3'b110;
        funct7 = 1'b0;
        #10;
        
        // Default case (unexpected combination)
        op = 7'b1111111;
        funct3 = 3'b111;
        funct7 = 1'b1;
        #10;
        
        // End simulation
        $finish;
    end
endmodule
