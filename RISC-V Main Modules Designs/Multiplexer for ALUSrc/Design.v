`timescale 1ns / 1ps

module MUX_for_ALUSrc(
input RD2, ImmExt, ALUSrc,
output SrcB
    );
    assign SrcB = ALUSrc?ImmExt:RD2; // ALUSrc is the select line which will select the output for SrcB. One indicates for ImmExt and zero indicates for RD2.
endmodule
