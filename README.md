# RISC-V Single Cycle Processor Design

In this repository of RISC-V, you will get to know the main modules of the MIPS Architecture with their codes, testbench and the design using the Verilog Language only. The purpose of this repository is to make an understable and easy-to-go code for the complex project i.e., RISC-V, where anyone with the basic knowledge on the Verilog can create. 

## Software used
Xilinx Vivado version 2023.1
This is an industry level tool, which will produce the gate level design, schematic design and it can also implement the code in an FPGA kit by using bitstream generation.

## What to expect
The instruction I-type, B-type, S-type snd J-type have been proposed. 
This repository will picture out the main idea on various main block of RISC-V along with the excecution of each module in Vivado.


## Architecture Design

![image](https://github.com/EkthaReddy/RISC-V-Single-Cycle-Processor/assets/152515939/a96949c0-6e89-426c-97c5-8d158f3afae8)

## Instruction Set

![image](https://github.com/EkthaReddy/RISC-V-Single-Cycle-Processor/assets/152515939/e5042813-b772-4bf1-a8a8-44d33539c6b8)

## ALU Table

![image](https://github.com/EkthaReddy/RISC-V-Single-Cycle-Processor/assets/152515939/9b26d4e0-50c2-43be-aef5-47effa00f8ff)




## what are the main blocks in this Single cycle processor?
The RISC-V contains the four essential blocks,
#### ‣ [Program Counter](https://github.com/EkthaReddy/RISC-V-Single-Cycle-Processor/tree/main/RISC-V%20Main%20Modules%20Designs/Program%20Counter)
#### ‣ [Instruction Memory](https://github.com/EkthaReddy/RISC-V-Single-Cycle-Processor/tree/main/RISC-V%20Main%20Modules%20Designs/Instruction%20Memory)
#### ‣ [Register File](https://github.com/EkthaReddy/RISC-V-Single-Cycle-Processor/tree/main/RISC-V%20Main%20Modules%20Designs/Register%20File)
#### ‣ [Data Memory](https://github.com/EkthaReddy/RISC-V-Single-Cycle-Processor/tree/main/RISC-V%20Main%20Modules%20Designs/Data%20Memory)
This four blocks are the key componenets of the processor. But, to bluid the whole architecture it is not enough, you need the connecting components for the above which plays a greater role in selecting the data, to ensure data is being read or written to. We need,
#### ‣ Multiplexers - 3 are required
The count is 3, for selecting their desired selection line which are PCSrc, ALUSrc, Memwrite
#### ‣ Adders - 2 are required
The adder will increment the value. For PCPlus4 the previous input is added with four as an output to give the next input for program counter. And, for PCTarget the addition is between the ImmExt (output of Extend File) and PC input.
#### ‣ Arithmetic logic unit
#### ‣ ALU Control unit
#### ‣ Main Decoder
#### ‣ ALU Decoder
#### ‣ Extend File
#### ‣ Datapath

All this combined together with the appropriate logic flow will give the architecture of MIPS.


## What datapath does the load word, store word, and Branch equal word follow

### Load Word
Step 1: The type of instruction used will determine the path for data to flow. To explain in simpler ways, the data will follow a path from the program counter at an initial address let's take 1000. It will give the instruction in machine code language after being fed into the instruction Memory.


Step 2: The opcode and instruction used will excute path in a certain direction. To know which path to choose the multiplexer is been placed.


Step 3:The sourse register from instruction set is fed into the register file at source operand A1(for single source register) which now gives us SrcA. For SrcB, Adding the extend file which will convert the small bits to 32 bit wide.

Note: If two single source register are used then, both A1 and A2 source operand are used.


Step 4: The SrcA and SrcB will be computed in ALU Logice where it comprise of Main Decoder and ALU Decoder which is being controlled by ALU Controller.


Step 5: The ALUResult is fed into the Data memory and where the Result is added back to the Register File of WD3. RegWrite is added as a control signal to ALU Controller.
Now, we need the next instruction to pass on, the adder is used which gives output as PCPlus4 which addes the previous input with four.


### Store word
Step 1: The whole structure of store word is almost same like the load word. 
The changes to be made are 
- Two single source register is used.
- ImmSrc from from extend file and MemWrite from the Data memory as a control signal is supplied to the ALU Controller.
- Second Register is fed into the A2 source operand.

### Branch Equal

Follow the same data path till store word.
additionals are

- Perform substraction operation on SrcA and SrcB, if the result gives us zerothen add zero flag to show the results are obtained for beq instructions.
- ResultSrc and RD is disabled.
- Calcualte the Target Address 
  PCTarget = PC input + ImmExt
  the PCTarget is fed into the Program Counter by using multipler which 



## What does the repository contain?

You can expect four things which will be given for every modules 
### Verilog Code
Design of the sub main modules of risc-v will be build with the logic to implement it in a very simpler way.
### Testbench
This will test the various case scenario of your main design of the particluar sub module to ensure the correctness, range and fulfillment of every test cases given.
### Simulation output
The simulation will generate the waveform based on the test cases provided in testbench and also make ensure it is instatiating the suitable main design module in the testbench. It will check for errors in the main design and testbench, whether it be syntax, junk error, bit length error or logic flow error.
### Elaborated Design
After the passing the simulation, if the code is meeting the expected ouput, it will show the elaborated design of the module created.




