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
