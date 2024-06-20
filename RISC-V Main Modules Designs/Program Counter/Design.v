// The Program Counter (PC) Design 

module program_counter(
input clk, reset, 
input [31:0] pc_in, // Input Port
output reg [31:0] pc_out // Output Port
    );

    always@(posedge clk)
    if (reset)
        pc_out<=pc_in; // In initial Stage, output of PC will be the initial address i,e, 1000
    else
        pc_out<=pc_in + 4;  // In the next cycle, output will be incremented to four of previous stage. Example: 1000 + 4= 1004, in next cycle it is 1008
endmodule
