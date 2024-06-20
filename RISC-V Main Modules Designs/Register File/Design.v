// Design of Register File

module RegFile(
input WE3, clk,
input [4:0] A1,
input [4:0] A2,
input [4:0] A3,
input [31:0] WD3,
output reg [31:0] RD1, 
output reg [31:0] RD2
    );
    
    reg [31:0] register_file[31:0];
    
    always@(posedge clk)
    if (WE3)
        register_file[A3] <= WD3;
    
    always@(*) begin
        RD1 = (A1==1)? register_file[A1]:0;
        RD2 = (A2==1)? register_file[A2]:0;
    end
    
endmodule
