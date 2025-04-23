# Single-Cycle RISC-V Processor

This project implements a single-cycle processor based on the RISC-V instruction set architecture using Verilog. It was built to execute basic arithmetic, logic, memory, and branching operations in a single clock cycle. The processor integrates key components such as the Datapath, Controller, and ALU Controller, and is verified through testbenches.

## Features

- Supports R-type, I-type, S-type, B-type, and U-type instructions
- Single-cycle execution per instruction
- Modular design for clarity and scalability
- Testbenches included to verify functionality

## Project Structure

- `Datapath.v` – Handles data flow between registers, ALU, memory, and immediate values
- `Controller.v` – Decodes opcodes and generates control signals
- `ALUController.v` – Interprets `funct3` and `funct7` to generate ALU operation codes
- `ALU.v` – Performs arithmetic and logic operations
- `InstructionMemory.v` – Stores instructions to be executed
- `DataMemory.v` – Handles memory read/write operations
- `Registers.v` – Register file with read/write functionality
- `ImmGen.v` – Extracts and sign-extends immediate values
- `tb_processor.v` – Testbench to simulate processor behavior

## Technologies Used

- Verilog HDL
- Xilinx Vivado (used for simulation)

## How to Run

1. Open the project files in Vivado or your preferred Verilog simulation environment.
2. Compile all modules and run `tb_processor.v`.
3. View the output waveform to verify correct execution and signal transitions.

## What I Learned

- How to design and integrate hardware modules to create a functioning CPU
- The inner workings of the RISC-V architecture and instruction formats
- Debugging and verifying hardware designs through simulation and waveform analysis

## Contact

**Tomi Nguyen**  
Email: tominguyen25@gmail.com  
GitHub: [github.com/tominguyenn](https://github.com/tominguyenn)
