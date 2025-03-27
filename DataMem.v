`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/// data memory
//////////////////////////////////////////////////////////////////////////////////

module DataMem(MemRead, MemWrite, addr, write_data, read_data);

// Define I/O ports
input MemRead;
input MemWrite;
input [8:0] addr;
input [31:0] write_data;
output reg [31:0] read_data;

// Describe DataMem behavior 
reg [31:0] memory [127:0];       // 128 words (32 bit each)

always @ (*) begin
    if (MemRead) begin
        read_data = memory[addr[8:2]];       // read from memory
    end
end

always @ (MemWrite) begin
    if (MemWrite) begin
        memory[addr[8:2]] = write_data;     // write data to memory
    end
end

endmodule   // data_mem
