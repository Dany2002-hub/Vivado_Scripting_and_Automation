`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2023 03:42:57
// Design Name: 
// Module Name: top_PE_struct
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


module top_PE_struct(en, data_in, data_out, valid);

input en;
input [7:0] data_in;
output [2:0] data_out;
output valid;

wire [13:0] int_val;

not n1(int_val[0], data_in[7]);
not n2(int_val[1], data_in[6]);
not n3(int_val[2], data_in[5]);
not n4(int_val[3], data_in[4]);
not n5(int_val[4], data_in[2]);

and a1(int_val[5], int_val[1], int_val[3], data_in[3]);
and a2(int_val[6], int_val[2], int_val[3], data_in[3]);
and a3(int_val[7], int_val[2], int_val[3], data_in[2]);
and a4(int_val[8], int_val[1], data_in[5]);
and a5(int_val[9], int_val[1], int_val[3], int_val[4], data_in[1]);

or o1(int_val[10], data_in[4], data_in[5], data_in[6], data_in[7]);
or o2(int_val[11], data_in[6], data_in[7], int_val[6], int_val[7]);
or o3(int_val[12], data_in[7], int_val[5], int_val[8], int_val[9]);
or o4(int_val[13], data_in[0], data_in[1], data_in[2], data_in[3], data_in[4], data_in[5], data_in[6], data_in[7]);

and a6(data_out[2], int_val[10], en);
and a7(data_out[1], int_val[11], en);
and a8(data_out[0], int_val[12], en);
and a9(valid, int_val[13], en);

endmodule