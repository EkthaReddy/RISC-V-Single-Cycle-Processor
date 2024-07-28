
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
