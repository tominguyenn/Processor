`timescale 1ns / 1ps
// Module definition
module Mux 
(
    input S,            // selec signal
    input [31:0] D1,    // first input
    input [31:0] D2,    // second input
    output [31:0] Y     // output
);

// Define the MUX2 :1 module behaviour
assign Y = (S==1'b0)?D1:
           D2;

endmodule // Mux