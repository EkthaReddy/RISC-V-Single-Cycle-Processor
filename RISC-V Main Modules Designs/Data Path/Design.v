// Logic Blocks of RISC-v Processor

///////////////////Logic for MUX for PCSrc/////////////////////////////////////////////////////////////////////////////////////////////////

module MUX_for_PCSrc(
input PCPlus4, PCTarget, PCSrc,
output  PCNext
    );
    
    assign PCNext = PCSrc?PCTarget:PCPlus4;
endmodule

/////////////////PC Logic//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module program_counter(
input clk, reset, 
input [31:0] pc_in,
output reg [31:0] pc_out
    );
    always@(posedge clk)
    if (reset)
        pc_out<=pc_in;
    else
        pc_out<=pc_in + 4;    
endmodule
///////////////Logic of Adder for PCPlus4////////////////////////////////////////////////////////////////////////////////////////////////////

module Adder_for_PCPlus4(
input pc_out,
output PCPlus4
    );
    
    assign PCPlus4 = pc_out + 4;
endmodule

//////////////////Logic of Adder for PCTarget/////////////////////////////////////////////////////////////////////////////////////////////
module Adder_for_PCTarget(
input pc_out, ImmExt,
output PCTarget
    );
    
    assign PCTarget = pc_out + ImmExt;

endmodule

///////////////////////Logic for Instruction Memory////////////////////////////////////////
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
        RD = mem[A[31:2]];  // Address decoding (assuming word addressing)
    end
endmodule

////////////////////////// Logic for Register File//////////////////////////////////////////

module RegFile(
input WE3, clk,
input [4:0] A1,
input [4:0] A2,
input [4:0] A3,
input [31:0] WD3,
output reg [31:0] RD1, 
output reg [31:0] RD2
    );
    
    reg [31:0] register_file[31:0];
    
    always@(posedge clk)
    if (WE3)
        register_file[A3] <= WD3;
    
    always@(*) begin
        RD1 = (A1==1)? register_file[A1]:0;
        RD2 = (A2==1)? register_file[A2]:0;
    end
    
endmodule

/////////////////Logic of MUX for ALUSrc/////////////////////////////////////////////////////

module MUX_for_ALUSrc(
input RD2, ImmExt, ALUSrc,
output SrcB
    );
    assign SrcB=ALUSrc?ImmExt:RD2;
endmodule

//////////////////Logic of Extend///////////////////////////////////////////////////////////

module Extend(
input [31:7]instruction, 
input [1:0]ImmSrc,
output reg [31:0]ImmExt
    );
    
    always@(*) begin
    case(ImmSrc)
        2'b00: ImmExt = {{20{instruction[31]}}, instruction[31:20]};// I
        2'b01: ImmExt = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};// S
        2'b10: ImmExt = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};// B
        2'b11: ImmExt = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};// J
    endcase    
    end    
endmodule

////////////////////////// Logic For ALU/////////////////////////////////////////////////////
module ALU(
    input [31:0] SrcA, SrcB,
    input [2:0] ALUControl,
    output reg zero,
    output reg [31:0] ALUResult 
);
    always @(*) begin
        case(ALUControl)
            3'b000: ALUResult <= SrcA + SrcB; // Addition
            3'b001: ALUResult <= SrcA - SrcB; // Subtraction
            3'b010: ALUResult <= SrcA & SrcB; // AND operation
            3'b011: ALUResult <= SrcA | SrcB; // OR operation
            3'b100: ALUResult <= (SrcA < SrcB) ? 1 : 0 ; // SLT (set less than) operation
            3'b101: zero <= (SrcA == SrcB); // BEQ (Branch if equal) operation
            default: ALUResult <= 32'bx; // DONT CARE
        endcase
    end
endmodule


/////////////////////////Logic for ALU Decoder//////////////////////////////////////////

module ALUDecoder(
    input [6:0] op,
    input [2:0] funct3,
    input funct7,
    input [1:0] ALUop,
    output reg [2:0] ALUControl
);
    always @(*) begin
        if (ALUop == 2'b00) begin
            ALUControl <= 3'b000; // ADD
        end else if (ALUop == 2'b01) begin
            ALUControl <= 3'b001; // SUB
        end else if (ALUop == 2'b10) begin
            case({funct7, funct3, op})
                10'b0000000_000: ALUControl <= 3'b000;
                10'b0100000_000: ALUControl <= 3'b001;
                10'b0000000_111: ALUControl <= 3'b011;
                10'b0000000_110: ALUControl <= 3'b010;
                default: ALUControl <= 3'bxxx;
            endcase
        end
    end
endmodule


/////////////////////Logic for Main Decoder////////////////////////////////////////////////////
module MainDecoder(
    input [6:0] op,
    output reg RegWrite,
    output reg MemWrite,
    output reg Branch,
    output reg ALUSrc,
    output reg [1:0] ALUop,
    output reg [1:0] ImmSrc
);
    always @(*) begin
        case(op)
            7'b0000011: begin // Load Word Instruction
                RegWrite <= 1;
                MemWrite <= 0;
                Branch <= 0;
                ALUSrc <= 1;
                ALUop <= 2'b00;
                ImmSrc <= 2'b00;
            end
            7'b0100011: begin // Store Word Instruction
                RegWrite <= 0;
                MemWrite <= 1;
                Branch <= 0;
                ALUSrc <= 1;
                ALUop <= 2'b00;
                ImmSrc <= 2'b01;
            end
            7'b1100011: begin // Branch Instruction
                RegWrite <= 0;
                MemWrite <= 0;
                Branch <= 1;
                ALUSrc <= 0;
                ALUop <= 2'b01;
                ImmSrc <= 2'b10;
            end
            7'b0010011: begin // I-type Instruction
                RegWrite <= 1;
                MemWrite <= 0;
                Branch <= 0;
                ALUSrc <= 1;
                ALUop <= 2'b10;
                ImmSrc <= 2'b00;
            end
            default: begin
                RegWrite <= 0;
                MemWrite <= 0;
                Branch <= 0;
                ALUSrc <= 0;
                ALUop <= 2'b00;
                ImmSrc <= 2'b00;
            end
        endcase
    end
endmodule

//////////////////////////Logic for ALU Control///////////////////////////////////////////////////

module ALUControl(
    input [6:0] op,
    input [2:0] funct3,
    input funct7,
    input zero,
    output wire PCSrc,
    output wire jump,
    output wire ALUSrc,
    output wire RegWrite,
    output wire MemWrite,
    output wire branch,
    output wire [1:0] ImmSrc,
    output wire [2:0] ALUControl
);
    wire [1:0] ALUop;
    MainDecoder md(op, RegWrite, MemWrite, branch, ALUSrc, ALUop, ImmSrc);
    ALUDecoder ad(op, funct3, funct7, ALUop, ALUControl);
    
    assign PCSrc = branch & zero | jump;
endmodule


/////////////////////Logic for Data Memory//////////////////////////////////////////////////////////
module Data_Memory(
input clk, WE, 
input [31:0]A,
input [31:0] WD,
output  [31:0]RD
    );
    reg [31:0] mem[63:0];
    
    assign RD = mem[A[31:2]];
    
    always @(posedge clk) begin
        if (WE) 
           mem[A[31:2]]<= WD;
    end
    
endmodule


//////////////////Logic for MUX for ResultSrc////////////////////////////////////////////////

module MUX_for_ResultSrc(
input [31:0] ALUResult,
input [31:0] RD,
input [31:0] PCPlus4,
input [1:0] ResultSrc,
output reg [31:0] Result
    );
    always @(*) begin
        case (ResultSrc)
            2'b00: Result = ALUResult; // Select ALUResult
            2'b01: Result = RD;        // Select RD
            2'b10: Result = PCPlus4;   // Select PCPlus4
            default: Result = 32'b0;   // Default case (can be defined as needed)
        endcase
    end
endmodule

/////////////////////////// Logic for Datapath//////////////////////////////////////////////////////////
module Data_Path(
    input clk, reset,
    input PCSrc, jump, ALUSrc, RegWrite,
    input [1:0] MemWrite, ResultSrc,
    input [2:0] ALUControl,
    input [1:0] ImmSrc,
    input [31:0] instruction,
    output zero,
    output [31:0] PC,
    output [31:0] WriteData,
    output [31:0] ReadData,
    output [31:0] ALUResult 
);
    wire [31:0] PCNext, PCPlus4, ImmExt, PCTarget, Result, SrcA, SrcB;
    wire [31:0] PC_out;

    // PC Logic flow
    program_counter pc(clk, reset, PCNext, PC_out);
    Adder_for_PCPlus4 a1(PC_out, PCPlus4);
    Adder_for_PCTarget a2(PC_out, ImmExt, PCTarget);
    MUX_for_PCSrc m1(PCPlus4, PCTarget, PCSrc, PCNext);
    
    // Register File Logic Flow
    RegFile rf(RegWrite, clk, instruction[19:15], instruction[24:20], instruction[11:7], Result, SrcA, WriteData);
    Extend e(instruction[31:7], ImmSrc, ImmExt);
    
    // ALU Logic
    MUX_for_ALUSrc m2(WriteData, ImmExt, ALUSrc, SrcB);
    ALU alu(SrcA, SrcB, ALUControl, zero, ALUResult);
    
    // Data Memory Logic
    Data_Memory dm(clk, MemWrite, ALUResult, WriteData, ReadData);
    
    // MUX for ResultSrc
    MUX_for_ResultSrc m3(ALUResult, ReadData, PCPlus4, ResultSrc, Result);
    
    // Output Assignments
    assign PC = PC_out;
endmodule
