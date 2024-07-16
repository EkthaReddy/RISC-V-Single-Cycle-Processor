// Arithmetic logic unit for RISC-V Processor
// ALU which performs the basic arithmetic operation such as ADD. SUB, AND, OR, SLT and BEQ

module ALU(
input [1:0]A, B,
input [2:0]ALUControl,
output reg zero,
output reg [2:0]ALUResult 
    );
    always@(*) begin
    case(ALUControl)
        3'b0000: begin ALUResult <= A+B; zero<=0; end // Addition
        3'b0001: begin ALUResult <= A-B; zero<=0; end // Subtraction
        3'b0010: begin ALUResult <= A&B; zero<=0; end // AND operation
        3'b0011: begin ALUResult <= A|B; zero<=0; end // OR operation
        3'b0100: begin ALUResult <= (A<B)?B:A ; zero<=0; end // SLT (set less than) operation
        3'b0101: begin ALUResult <= (A==B); zero<=1; end // BEQ (Branch if equal) operation 
        4'bxxxx: ALUResult<=3'bxxx; // DONT CARE 
    endcase
    end
endmodule
