// Design Of Multiplexer for PCSrc Select Line
`timescale 1ns / 1ps

module MUX_for_PCSrc(
input PCPlus4, PCTarget, PCSrc,
output  PCNext
    );
    
    assign PCNext = PCSrc?PCTarget:PCPlus4; 
endmodule
