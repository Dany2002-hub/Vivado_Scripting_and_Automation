`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2023 23:39:45
// Design Name: 
// Module Name: top_trafficsignal
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


module top_trafficsignal(clk, reset, north_dir, south_dir, east_dir, west_dir, clk_out);
//inpput variables
input clk, reset;
output logic [2:0] north_dir, south_dir, east_dir, west_dir;
output logic clk_out; // output of frequency divider 

parameter [2:0] green = 3'b001, yellow = 3'b010, red = 3'b100; //declared parameters for green, yellow, red


typedef enum{north,south,east,west} current_state; // states for north, south, east, and west direction

current_state state;

logic [3:0]count; //counter to count seconds

frequency_divider fd(clk, clk_out); //frequency divider instance

always@(posedge clk_out)
if(reset)
// when reset is one state is north and count is zero
    begin
        state = north;
        count = 0;
    end
else begin
//case statement for north, south, east, and west states
    case(state)
    north: if(count < 4'b1010)begin //when count is less than 10 north direction shows green light for 10sec. (count:0-9)
            
            north_dir = green;
            south_dir = red;
            east_dir = red;
            west_dir = red;
            
            count = count +1;
            end
            else if(count >= 4'b1010 && count < 4'b1110)begin // when count is greater than equal to 10 and less than 14 then north direction shows yellow light
            north_dir = yellow;
            south_dir = red;
            east_dir = red;
            west_dir = red;
            
            count = count +1;
            end 
            else begin // when count is 15 state = south and north direction = red light
            state = south;
            count = 4'b0000;    
            end
    south: if(count < 4'b1010)begin
            north_dir = red;
            south_dir = green;
            east_dir = red;
            west_dir = red;
            
            count = count +1;
            end
            else if(count >= 4'b1010 && count < 4'b1110)begin
            north_dir = red;
            south_dir = yellow;
            east_dir = red;
            west_dir = red;
            
            count = count +1;
            end 
            else begin
            state = east;
            count = 4'b0000;    
            end
    east: if(count < 4'b1010)begin
            
            north_dir = red;
            south_dir = red;
            east_dir = green;
            west_dir = red;
            
            count = count +1;
            end
            else if(count >= 4'b1010 && count < 4'b1110)begin
            north_dir = red;
            south_dir = red;
            east_dir = yellow;
            west_dir = red;
            
            count = count +1;
            end 
            else begin
            state = west;
            count = 4'b0000;    
            end
    west: if(count < 4'b1010)begin
            
            north_dir = red;
            south_dir = red;
            east_dir = red;
            west_dir = green;
            
            count = count +1;
            end
            else if(count >= 4'b1010 && count < 4'b1110)begin
            north_dir = red;
            south_dir = red;
            east_dir = red;
            west_dir = yellow;
            
            count = count +1;
            end 
            else begin
            state = north;
            count = 4'b0000;    
            end                        
    
    endcase
end
endmodule

module frequency_divider(clock_in, clock_out);
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

