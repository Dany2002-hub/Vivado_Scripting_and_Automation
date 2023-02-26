`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2023 00:45:18
// Design Name: 
// Module Name: top_RCA
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


module top_RCA(data_A, data_B, Carry_in, Sum, Carry_out);

input [7:0] data_A, data_B;
input Carry_in;
output [7:0] Sum;
output Carry_out;
wire [6:0] Carry;

full_adder fa1(data_A[0], data_B[0], Carry_in, Sum[0], Carry[0]);
full_adder fa2(data_A[1], data_B[1], Carry[0], Sum[1], Carry[1]);
full_adder fa3(data_A[2], data_B[2], Carry[1], Sum[2], Carry[2]);
full_adder fa4(data_A[3], data_B[3], Carry[2], Sum[3], Carry[3]);
full_adder fa5(data_A[4], data_B[4], Carry[3], Sum[4], Carry[4]);
full_adder fa6(data_A[5], data_B[5], Carry[4], Sum[5], Carry[5]);
full_adder fa7(data_A[6], data_B[6], Carry[5], Sum[6], Carry[6]);
full_adder fa8(data_A[7], data_B[7], Carry[6], Sum[7], Carry_out);

endmodule

module full_adder(A, B, Cin, Sum, Carry);

input A, B, Cin;
output Sum, Carry;
wire sum_h1, carry_h1, sum_h2, carry_h2;

half_adder ha1(A, B, sum_h1, carry_h1);
half_adder ha2(sum_h1, Cin, sum_h2, carry_h2);

assign Sum = sum_h2;
assign Carry = carry_h1 | carry_h2;

endmodule

module half_adder(A, B, Sum, Carry);

input A, B;
output Sum, Carry;

assign Sum = A^B;
assign Carry = A&B;

endmodule
