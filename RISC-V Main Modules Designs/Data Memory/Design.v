// Design of Data Memory

module Data_Memory(
input clk, WE, 
input [31:0]A, // Address Input
input [31:0] WD, // Write Data Input
output  [31:0]RD // Read Data Output
    );
    reg [31:0] mem[63:0]; // Memory of 64 register each 32 bit wide
    
    assign RD = mem[A[31:2]];
    
    always @(posedge clk) begin
        if (WE) 
           mem[A[31:2]]<= WD;
    end
    
      
endmodule
