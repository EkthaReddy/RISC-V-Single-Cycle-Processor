
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
