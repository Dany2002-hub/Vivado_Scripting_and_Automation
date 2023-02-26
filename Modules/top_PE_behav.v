`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2023 03:13:05
// Design Name: 
// Module Name: top_PE_behav
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


module top_PE_behav(en, data_in, data_out);

input en;
input [7:0] data_in;
output reg [2:0] data_out;

always@(en, data_in)
begin
if(en)
begin

if(data_in[7])
begin
data_out = 3'd7;
end
else if (data_in[6])
begin
data_out = 3'd6;
end
else if (data_in[5])
begin
data_out = 3'd5;
end
else if (data_in[4])
begin
data_out = 3'd4;
end
else if (data_in[3])
begin
data_out = 3'd3;
end
else if (data_in[2])
begin
data_out = 3'd2;
end
else if (data_in[1])
begin
data_out = 3'd1;
end
else if (data_in[0])
begin
data_out = 3'd0;
end
else 
begin
data_out = 3'bxxx;
end
end

else
begin
data_out = 3'bzzz;
end
end
endmodule
