`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2023 02:02:16
// Design Name: 
// Module Name: top_multiplier
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


module top_multiplier(data_A, data_B, data_out);

input [3:0] data_A, data_B;
output [7:0] data_out;

wire [39:0] int_val;

//Bit-wise multiplication
and a1(int_val[0], data_A[0], data_B[0]);
and a2(int_val[1], data_A[1], data_B[0]);
and a3(int_val[2], data_A[2], data_B[0]);
and a4(int_val[3], data_A[3], data_B[0]);

and a5(int_val[4], data_A[0], data_B[1]);
and a6(int_val[5], data_A[1], data_B[1]);
and a7(int_val[6], data_A[2], data_B[1]);
and a8(int_val[7], data_A[3], data_B[1]);

and a9(int_val[8], data_A[0], data_B[2]);
and a10(int_val[9], data_A[1], data_B[2]);
and a11(int_val[10], data_A[2], data_B[2]);
and a12(int_val[11], data_A[3], data_B[2]);

and a13(int_val[12], data_A[0], data_B[3]);
and a14(int_val[13], data_A[1], data_B[3]);
and a15(int_val[14], data_A[2], data_B[3]);
and a16(int_val[15], data_A[3], data_B[3]);

//Full Adders Instantiation
full_adder fa1(1'b0, int_val[1], int_val[4], int_val[16], int_val[17]);
full_adder fa2(1'b0, int_val[2], int_val[5], int_val[18], int_val[19]);
full_adder fa3(1'b0, int_val[3], int_val[6], int_val[20], int_val[21]);

full_adder fa4(int_val[8], int_val[17], int_val[18], int_val[22], int_val[23]);
full_adder fa5(int_val[9], int_val[19], int_val[20], int_val[24], int_val[25]);
full_adder fa6(int_val[10], int_val[7], int_val[21], int_val[26], int_val[27]);

full_adder fa7(int_val[12], int_val[23], int_val[24], int_val[28], int_val[29]);
full_adder fa8(int_val[13], int_val[25], int_val[26], int_val[30], int_val[31]);
full_adder fa9(int_val[14], int_val[11], int_val[27], int_val[32], int_val[33]);

full_adder fa10(1'b0, int_val[29], int_val[30], int_val[34], int_val[35]);
full_adder fa11(int_val[31], int_val[32], int_val[35], int_val[36], int_val[37]);
full_adder fa12(int_val[15], int_val[33], int_val[37], int_val[38], int_val[39]);

assign data_out[0] = int_val[0];
assign data_out[1] = int_val[16];
assign data_out[2] = int_val[22];
assign data_out[3] = int_val[28];
assign data_out[4] = int_val[34];
assign data_out[5] = int_val[36];
assign data_out[6] = int_val[38];
assign data_out[7] = int_val[39];

endmodule

module full_adder(A, B, Cin, Sum, Carry);

input A, B, Cin;
output Sum, Carry;

assign Sum = A^B^Cin;
assign Carry = (A&B) | (B&Cin) | (Cin&A);

endmodule