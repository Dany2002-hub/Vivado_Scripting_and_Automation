`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.01.2023 11:20:15
// Design Name: 
// Module Name: top_fifo
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


module top_fifo(clk,reset,write_data, WE, RE, read_data, full, empty, half_full);
//parameters
parameter n = 16;
parameter m = 32;
//input variables
input clk, reset, WE, RE; //clock, write enable, read enable, reset
input [n-1:0]write_data; //input data to write
//output variables
output logic [n-1:0]read_data; //output data

output logic full; //full =1 when memory will be full i.e, counter = 32 
output logic empty; //empty =1 when memory will be empty i.e, counter = 0 
output logic half_full; //half_full =1 when memory will be half_full i.e, counter = 16 

logic [n-1:0]fifo[0:m-1]; //fifo32X16 memory 

logic [$clog2(m)-1:0]wp,rp; // write pointer and read pointer

logic [$clog2(m):0]counter; // counter to keep track memory status

assign full = (counter == m)?1'b1:1'b0 ; //full = 1 when counter = 32 
assign empty = (counter ==0)?1'b1:1'b0; //empty = 1 when counter = 0
assign half_full = (counter == (m>>1))? 1'b1: 1'b0; //half_full = 1 when counter = 16


always_ff@(posedge clk)

begin

 if(!reset)
 begin
 // when reset = 1 counter, write pointer and read pointer will be zero
    wp <= 0;
    rp <= 0;
    counter <=0;
end
else
     if(WE) //when WE is one following statements will execute
        begin
            assert(!full) //when fifo is not full then we will write the data at location shown by write pointer
            begin
            fifo[wp] <= write_data; 
            wp <= wp+1; // after writing data increament the write pointer by 1
            counter <= counter +1; // after writing data we will increase counter to show that that much data is present in fifo
            end
            else
            $error ("FIFO is full can't write anymore");
            end
     if (RE) //when RE is one following statements will execute
     begin
     assert(!empty) //when fifo is not empty then we can read the data from the fifo from the location indicated by read pointer
     begin
     read_data <= fifo[rp]; 
     rp <= rp + 1; //after reading data increament the read pointer by 1
     counter <= counter - 1; //after readiing data we will decrease the counter to indicate that data is removed from fifo
     end
     else
     begin
     $error ("FIFO is empty can't read the data");
     end
     end                          
 end
endmodule
