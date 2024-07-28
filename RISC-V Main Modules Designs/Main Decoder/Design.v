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
