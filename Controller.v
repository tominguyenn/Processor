`timescale 1ns / 1ps

// Module definition
module Controller(
    Opcode,
    ALUSrc , MemtoReg , RegWrite , MemRead , MemWrite ,
    ALUOp
    );
    
// Define the input and output signals
input [6:0] Opcode;
output reg ALUSrc;          // control mutiplexers
output reg MemtoReg;        // control multiplexerrs
output reg RegWrite;        // controls reads and writes in register file and data memory
output reg MemRead;         // controls reads and writes in register file and data memory
output reg MemWrite;        // controls reads and writes in register file and data memory
output reg [1:0] ALUOp;     // control signal for the ALUController


// Define the Controller modules behavior
always @ (*) begin
    // Initialize values to prevent latching
    ALUSrc = 0;
    MemtoReg = 0;
    RegWrite = 0;
    MemRead = 0;
    MemWrite = 0;
    ALUOp = 2'b00;
    
    case (Opcode) 
        7'b0110011: begin       // Opcode = AND, OR, ADD, SUB, SLT, NOR
            MemtoReg = 0;
            MemWrite = 0;
            MemRead = 0;
            ALUSrc = 0;
            RegWrite = 1;
            ALUOp = 2'b10;
        end
        
        7'b0010011: begin       // Opcode = ANDI, ORI, ADDI, SLTI, NORI
            MemtoReg = 0;
            MemWrite = 0;
            MemRead = 0;
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 2'b00;
        end
        
        7'b0000011: begin       // Opcode = load
            MemtoReg = 1;
            MemWrite = 0;
            MemRead = 1;
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 2'b01;
        end
        
        7'b0100011: begin       // Opcode = store
            MemtoReg = 0;
            MemWrite = 1;
            MemRead = 0;
            ALUSrc = 1;
            RegWrite = 0;
            ALUOp = 2'b01;
        end       
    endcase    
end    
endmodule   //Controller
