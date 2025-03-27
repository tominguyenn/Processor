`timescale 1ns / 1ps

module ALUController(
    ALUOp, Funct7, Funct3, Operation
    );
    
// Define the input and output signals
input [1:0] ALUOp;
input [6:0] Funct7;
input [2:0] Funct3;
output reg [3:0] Operation;


// Define the ALUController modules behavior    
always @ (*) begin
    case (ALUOp)
        2'b10: begin // R-type instructions: AND, OR, NOR, SLT, ADD, SUB
            case (Funct3)
                3'b111: Operation = (Funct7 == 7'b0000000) ? 4'b0000 : 4'bxxxx; // AND
                3'b110: Operation = (Funct7 == 7'b0000000) ? 4'b0001 : 4'bxxxx; // OR
                3'b100: Operation = (Funct7 == 7'b0000000) ? 4'b1100 : 4'bxxxx; // NOR
                3'b010: Operation = (Funct7 == 7'b0000000) ? 4'b0111 : 4'bxxxx; // SLT
                3'b000: Operation = (Funct7 == 7'b0000000) ? 4'b0010 : // ADD
                                    (Funct7 == 7'b0100000) ? 4'b0110 : 4'bxxxx; // SUB
                default: Operation = 4'bxxxx; // Undefined
            endcase
        end
        
        2'b00: begin // I-type instructions: ANDI, ORI, NORI, SLTI, ADDI
            case (Funct3)
                3'b111: Operation = 4'b0000; // ANDI
                3'b110: Operation = 4'b0001; // ORI
                3'b100: Operation = 4'b1100; // NORI
                3'b010: Operation = 4'b0111; // SLTI
                3'b000: Operation = 4'b0010; // ADDI
                default: Operation = 4'bxxxx; // Undefined
            endcase
        end
        
        2'b01: begin // Memory instructions: LW, SW
            case (Funct3)
                3'b010: Operation = 4'b0010; // LW, SW
                default: Operation = 4'bxxxx; // Undefined
            endcase
        end
        
        default: Operation = 4'bxxxx; // Undefined
    endcase
end
endmodule   // ALUController
