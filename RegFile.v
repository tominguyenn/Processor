`timescale 1ns / 1ps

// Module definition
module RegFile (
clk , reset , rg_wrt_en ,
rg_wrt_addr ,
rg_rd_addr1 ,
rg_rd_addr2 ,
rg_wrt_data ,
rg_rd_data1 ,
rg_rd_data2
);

// Define the input and output signals
input clk;
input reset;
input rg_wrt_en;                    // enable
input [4:0] rg_wrt_addr;            // write address
input [4:0] rg_rd_addr1;            // read address 1
input [4:0] rg_rd_addr2;            // read address 2
input [31:0] rg_wrt_data;           // write data
output reg [31:0] rg_rd_data1;      // read data 1
output reg [31:0] rg_rd_data2;      // read data 2

// Define the Register File module behavior
reg [31:0] register [31:0];        // 32 registers with 32 bits

integer i;

always @ (posedge clk or posedge reset) begin
    if(reset) begin
        for(i=0; i < 32; i = i+1) begin
            register[i] = 32'h00000000;
        end 
    end
    
    else if (rg_wrt_en) begin
        register[rg_wrt_addr] <= rg_wrt_data;
    end
end

// asynchronous read
always @ (*) begin
    rg_rd_data1 = register[rg_rd_addr1];
    rg_rd_data2 = register[rg_rd_addr2];
end

endmodule // RegFile