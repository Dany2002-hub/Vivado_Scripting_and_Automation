`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2023 09:30:54
// Design Name: 
// Module Name: top_mealy_0011
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


module top_mealy_0011(w, clk, rst, z, clk_out);
    input w, clk, rst;                           
    output z, clk_out;
    wire clock_out;
    
    clk_div cd1(clk, clock_out);                      
    mealy_0011 m1(w, clock_out, rst, z, clk_out);     
endmodule

module mealy_0011(w, clk, rst, z, clk_out);
    input w,clk,rst;                         
    output reg z;                         
    output clk_out;
    reg [1:0] present, next;              
    parameter [1:0] a = 2'b00, b = 2'b01, c = 2'b10, d = 2'b11;
    assign clk_out = clk;
    
    always@(w or present)
    case(present)
        a: if(w == 0)begin
            z = 0;
            next <= b;
           end
           else begin
            z = 0;
            next <= a;
           end
        b: if(w == 0)begin
            z = 0;
            next <= c;
           end
           else begin
            z = 0;
            next <= a;
           end
        c: if(w == 0)begin
            z = 0;
            next <= c;
           end
           else begin
            z = 0;
            next <= d;
           end
        d: if(w == 0)begin
            z = 0;
            next <= b;
           end
           else begin
            z = 1;
            next <= a;
           end
     default: next = 2'bxx;
     endcase
     
     always@(posedge clk or negedge rst)
        if(rst == 0)
            present <= a;
        else
            present <= next;
endmodule

module clk_div(clock_in,clock_out);
    input clock_in;                   
    output reg clock_out;            
    reg [27:0] counter = 28'd0;
    parameter total = 28'd100000000;   
    

    always@(posedge clock_in)begin
        counter <= counter + 28'd1;
        if(counter >= (total-1))begin
            counter <= 28'd0;
        end
        clock_out <= (counter < total/2)?1'b1:1'b0;
    end
endmodule
