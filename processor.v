`timescale 1ns / 1ps

module processor
(
    input clk, reset,
    output [31:0] Result
);

// Define the input and output signals
// Wires from Datapath
wire [6:0] Opcode;
wire [2:0] Funct3;
wire [6:0] Funct7;

// Wire from Controller
wire [1:0] ALUOp;
wire MemtoReg;
wire MemWrite;
wire MemRead;
wire ALUSrc;
wire RegWrite;

// Wire from ALU Controller
wire [3:0] Operation;

// Define the processor modules behavior
// Datapath module
data_path datapath (
    .opcode (Opcode),
    .funct3 (Funct3),
    .funct7 (Funct7),
    .mem2reg (MemtoReg),
    .mem_write (MemWrite),
    .mem_read (MemRead),
    .alu_src (ALUSrc),
    .reg_write (RegWrite),
    .alu_cc (Operation),
    .clk (clk),
    .reset (reset),
    .alu_result (Result)
);

// Controller module
Controller controller (
    .Opcode (Opcode),
    .MemtoReg (MemtoReg),
    .MemWrite (MemWrite),
    .MemRead (MemRead),
    .ALUSrc (ALUSrc),
    .RegWrite (RegWrite),
    .ALUOp (ALUOp)
);

// ALU Controller module
ALUController ALU_Controller (
    .ALUOp (ALUOp),
    .Funct3 (Funct3),
    .Funct7 (Funct7),
    .Operation (Operation)
);


endmodule   // processor
