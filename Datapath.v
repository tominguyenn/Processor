`timescale 1ns / 1ps

////   Data Path /////
module data_path #(
    parameter PC_W = 8,       // Program Counter
    parameter INS_W = 32,     // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32,    // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4    // ALU Control Code Width
 )(
    input                  clk ,        // CLK in datapath figure
    input                  reset,       // Reset in datapath figure      
    input                  reg_write,   // RegWrite in datapath figure
    input                  mem2reg,     // MemtoReg in datapath figure
    input                  alu_src,     // ALUSrc in datapath figure 
    input                  mem_write,   // MemWrite in datapath figure  
    input                  mem_read,    // MemRead in datapath figure          
    input  [ALU_CC_W-1:0]  alu_cc,      // ALUCC in datapath figure
    output          [6:0]  opcode,      // opcode in dataptah figure
    output          [6:0]  funct7,      // Funct7 in datapath figure
    output          [2:0]  funct3,      // Funct3 in datapath figure
    output   [DATA_W-1:0]  alu_result   // Datapath_Result in datapath figure
 );

// Wires
wire [PC_W-1:0] PC, PCPlus4;
wire [INS_W-1:0] Instruction;
wire [RF_ADDRESS-1:0] Reg, Reg1, Reg2;
wire [DATA_W-1:0] reg_data1, reg_data2, ExtImm, SreB, alu_out, DataMem_read, WriteBack_Data;

// Flip Flop for PC
FlipFlop PC_Reg (
    .clk(clk),
    .reset(reset),
    .d(PCPlus4),
    .q(PC)
);

// Instruction Memory
InstMem Instr_mem (
    .addr(PC),
    .instruction(Instruction) 
);

// Register File
RegFile RegisterFile (
    .clk(clk), 
    .reset(reset), 
    .rg_wrt_en(reg_write),
    .rg_wrt_addr(Reg),
    .rg_rd_addr1(Reg1),
    .rg_rd_addr2(Reg2),
    .rg_wrt_data(WriteBack_Data),
    .rg_rd_data1(reg_data1),
    .rg_rd_data2(reg_data2)
);

// Immediate Generator
ImmGen Immediate_Generator (
    .InstCode(Instruction),
    .ImmOut(ExtImm)
);

// Mux (Reg File to ALU)
Mux Mux1(
    .S(alu_src),
    .D1(reg_data2),
    .D2(ExtImm),
    .Y(SreB)
);

// ALU
ALU ALU_Module (
    .A_in(reg_data1), 
    .B_in(SreB),
    .ALU_Sel(alu_cc),
    .ALU_Out(alu_out)
);

// Data Memory
DataMem data_mem(
    .MemRead(mem_read),
    .MemWrite(mem_write),
    .addr(alu_out),
    .write_data(reg_data2),
    .read_data(DataMem_read)
);

// MemToReg Mux (data memory to Reg File)
Mux Mux2(
    .S(mem2reg),
    .D1(alu_out),
    .D2(DataMem_read),
    .Y(WriteBack_Data)
);

// Assign Instruction
assign opcode = Instruction[6:0];
assign funct3 = Instruction[14:12];
assign funct7 = Instruction[31:25];
assign Reg = Instruction[11:7];
assign Reg1 = Instruction[19:15];
assign Reg2 = Instruction[24:20];

// PC update
assign PCPlus4 = PC + 4;

// Output Result
assign alu_result = alu_out;


endmodule
