`timescale 1ns/1ps

module ALUControl_tb;
    // Inputs
    reg [6:0] op;
    reg [2:0] funct3;
    reg funct7;
    reg zero;
    
    // Outputs
    wire PCSrc;
    wire jump;
    wire ALUSrc;
    wire RegWrite;
    wire MemWrite;
    wire branch;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl;

    // Instantiate the ALUControl module
    ALUControl uut (
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .zero(zero),
        .PCSrc(PCSrc),
        .jump(jump),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .branch(branch),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl)
    );

    // Initialize inputs and apply stimulus
    initial begin
        // Initialize signals
        op = 7'b0000000;   
        funct3 = 3'b000;   
        funct7 = 1'b0;     
        zero = 1'b0;       

        // Apply test cases
        // Test Case 1: Load Word Instruction
        op = 7'b0000011;   
        #10;
     
        // Test Case 2: Store Word Instruction
        op = 7'b0100011;   
        #10;
       
        // Test Case 3: Branch Instruction
        op = 7'b1100011;   
        zero = 1'b1;      
        #10;
        
        // Test Case 4: J-type Instruction (JAL)
        op = 7'b1101111;   
        #10;
        
        // Test Case 5: I-type Load Instruction
        op = 7'b0000011;   
        funct3 = 3'b010;   
        #10;
        
        // End simulation
        $finish;
    end
endmodule
