# RISC-V Single Cycle Processor Design

In this repository of RISC-V, you will get to know the main modules of the MIPS Architecture with their codes, testbench and the design using the Verilog Language only. The purpose of this repository is to make an understable and easy-to-go code for the complex project i.e., RISC-V, where anyone with the basic knowledge on the Verilog can create. 

## Software used
Xilinx Vivado version 2023.1
This is an industry level tool, which will produce the gate level design, schematic design and it can also implement the code in an FPGA kit by using bitstream generation.

## Architecture Design
![image](https://github.com/EkthaReddy/RISC-V-Single-Cycle-Processor/assets/152515939/a96949c0-6e89-426c-97c5-8d158f3afae8)

## What I did
The instruction I-type, B-type, S-type snd J-type have been proposed. 

## what are the main blocks in this Single cycle processor?
The RISC-V contains the four essential blocks,
#### ‣ Program Counter (PC)
#### ‣ Instruction Memory
#### ‣ Register File
#### ‣ Data Memory
This four blocks are the key componenets of the processor. But, to bluid the whole architecture it is not enough, you need the connecting components for the above which plays a greater role in selecting the data, to ensure data is being read or written to we need,
#### ‣ Multiplexers - 3 are required
The count is 3, for selecting their desired selection line which are PCSrc, ALUSrc, Memwrite
#### ‣ Adders - 2 are required
The adder will increment the value. For PCPlus4 the previous input is added with four as an output to give the next input for program counter. And, for PCTarget the addition is between the ImmExt( output of Extend File) and PC input.
#### ‣ Arithmetic logic unit
#### ‣ ALU Control unit
#### ‣ Main Decoder
#### ‣ ALU Decoder
#### ‣ Extend File
#### ‣ Datapath

All this combined together with the appropriate logic flow will give the architecture of MIPS.
## What to expect from this repository?

You can expect four things which will be given for every modules 
### Verilog Code: 
Design of the sub main modules of risc-v will be build with the logic to implement it in a very simpler way.
### Testbench: 
This will test the various case scenario of your main design of the particluar sub module to ensure the correctness, range and fulfillment of every test cases given.
### Simulation output:
The simulation will generate the waveform based on the test cases provided in testbench and also make ensure it is instatiating the suitable main design module in the testbench. It will check for errors in the main design and testbench, whether it be syntax, junk error, bit length error or logic flow error.
### Elaborated Design:
After the passing the simulation, if the code is meeting the expected ouput, it will show the elaborated design of the module created.




