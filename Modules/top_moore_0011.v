`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2023 02:22:08
// Design Name: 
// Module Name: top_moore_0011
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


module top_moore_0011(w, clk, rst, z, clk_out);
    input w, clk, rst;                           
    output z, clk_out;
    wire clock_out;
    
    clk_div cd1(clk, clock_out);                      
    moore_0011 m1(w, clock_out, rst, z, clk_out);     
endmodule

module moore_0011(w, clk, rst, z, clk_out);
    input w,clk,rst;                         
    output z;                         
    output clk_out;
    reg [2:0] present, next;              
    parameter [2:0] a = 3'b000, b = 3'b001, c = 3'b010, d = 3'b011, e = 3'b100;
    assign clk_out = clk;
  
  always@(w or present)
    begin
      case(present)
        a: if(w==0) next=b;
           else     next=a;
        b: if(w==0) next=c;
           else     next=a;
        c: if(w==0) next=c;
           else     next=d;
        d: if(w==0) next=b;
           else     next=e;
        e: if(w==0) next=b;
           else     next=a;
        default:    next=3'bxxx;
      endcase
    end
  
    always@(posedge clk or negedge rst)
       if(rst == 0)
           present <= a;
       else
           present <= next;
  
assign z=(present==e)? 1'b1: 1'b0;
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
