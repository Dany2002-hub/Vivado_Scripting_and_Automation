`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2023 17:27:04
// Design Name: 
// Module Name: top_Memory_RW
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_Memory_RW(data_in, clk ,reset, we, rw, r1, r2, q1, q2);
//parameters
parameter n = 32;
parameter m = 32;

//input variables
input [n-1:0]data_in; //data to write
input clk,reset, we; //clock, reset, write enable
input [$clog2(m)-1:0] rw, r1, r2; // address for destination register and source registers
output logic [n-1:0] q1, q2; //output data

logic [n-1:0]regfile[m-1:0]; // 32X32 register file


always@(posedge clk)
begin 
//read data from two ports at posedge of clock
q1 = regfile[r1];
q2 = regfile[r2];
if(we == 1'b1)  // when write enable = 1 write data in destination register
begin
regfile[rw]<=data_in;
end
end

endmodule
