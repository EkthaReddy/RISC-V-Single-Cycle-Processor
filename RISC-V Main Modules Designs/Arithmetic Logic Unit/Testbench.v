// Testbench

module ALU_tb;

reg [1:0] A, B;
reg [2:0] ALUControl;
wire zero;
wire [2:0] ALUResult;

    // Instantiate the ALU module
ALU uut (.A(A), .B(B), .ALUControl(ALUControl), .zero(zero), .ALUResult(ALUResult));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
 
       
        // Test Add operation (ALUControl = 3'b000)
        A = 2'b01; B = 2'b01; ALUControl = 3'b000;
        #10;
        
        // Test Subtract operation (ALUControl = 3'b001)
        A = 2'b10; B = 2'b01; ALUControl = 3'b001;
        #10;

        // Test AND operation (ALUControl = 3'b010)
        A = 2'b11; B = 2'b01; ALUControl = 3'b010;
        #10;

        // Test OR operation (ALUControl = 3'b011)
        A = 2'b10; B = 2'b01; ALUControl = 3'b011;
        #10;

        // Test SLT operation (ALUControl = 3'b100)
        A = 2'b01; B = 2'b10; ALUControl = 3'b100;
        #10;
        
        // Test BEQ operation (ALUControl = 3'b101)
        A = 2'b01; B = 2'b10; ALUControl = 3'b101;
        #10;
        
        // Test default case
        ALUControl = 3'b111;
        #10;

        // End the simulation
        $finish;
    end
endmodule
