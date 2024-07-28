// ALU Control

module ALUControl(
input [6:0]op,
input [1:0]ALUop,
output reg [11:0]MainDecoder 
    );
   
    wire PCSrc, ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite, PCUpdate;
    wire zero, Branch;
    assign PCSrc = zero&Branch;
    always@(*) begin
    case({RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUop, PCUpdate})
    
    7'b0000011 : MainDecoder <= 11'b1_00_1_0_1_0_00_0 ;// Load Word Instruction
    7'b0100011 : MainDecoder <= 11'b0_01_1_1_x_0_00_0 ;// Store word Instruction
    7'b0110011 : MainDecoder <= 11'b1_xx_0_0_0_0_10_0 ;//R Type Instruction
    7'b1100011 : MainDecoder <= 11'b0_10_0_0_xx_1_01_0 ;// BEQ Instruction
    7'b0010011 : MainDecoder <= 11'b1_00_1_0_0_0_10_0 ;// Add Immediate Instruction
    7'b1101111 : MainDecoder <= 11'b1_11_x_0_10_0_xx_1 ;// JAL Instruction
    default : MainDecoder <=11'bxxxxxxxxx;
    endcase
end    
endmodule
