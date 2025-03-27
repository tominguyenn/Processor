`timescale 1ns / 1ps

// Module definition
module FlipFlop (clk, reset, d, q );

// Define input and output signals
    input clk;
    input reset;
    input [7:0] d;
    output reg [7:0] q = 0;

// Define the D Flip flop modules ' behaviour
always @ (posedge clk) begin
    if (reset)                  // Synchronous reset
        q <= 8'b0;
    else                        
        q <= d;
end

endmodule // FlipFlop
