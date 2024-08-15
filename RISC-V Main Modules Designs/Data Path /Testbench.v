`timescale 1ns / 1ps

module RISC_V_Testbench;

// Clock and Reset Signals
reg clk;
reg reset;

// Outputs from the Data Path
wire zero;
wire [31:0] PC;
wire [31:0] WriteData;
wire [31:0] ReadData;
wire [31:0] ALUResult;

// Wires for the control signals
wire PCSrc, jump, ALUSrc, RegWrite;
wire [1:0] MemWrite, ResultSrc;
wire [2:0] ALUControl;
wire [1:0] ImmSrc;

// Instruction memory output
wire [31:0] instruction;


// Instantiate the Data Path
Data_Path datapath(
    .clk(clk),
    .reset(reset),
    .PCSrc(PCSrc),
    .jump(jump),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .ALUControl(ALUControl),
    .ImmSrc(ImmSrc),
    .instruction(instruction),
    .zero(zero),
    .PC(PC),
    .WriteData(WriteData),
    .ReadData(ReadData),
    .ALUResult(ALUResult)
);


initial begin
$dumpfile("dump.vcd");
$dumpvars(0);

clk <=1'b0;
reset <=1'b0;
  
  

#10 $finish();
end

always #2 clk<=~clk;
always #1.2 reset<=~reset;


endmodule
