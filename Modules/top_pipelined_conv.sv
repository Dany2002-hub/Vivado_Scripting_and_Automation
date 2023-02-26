`timescale 1ps / 1fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2023 22:41:51
// Design Name: 
// Module Name: pipelined_conv
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

module top_pipelined_conv(stage1_en, clk, reset, pixel_r, pixel_g, pixel_b, conv_out, conv_end, stage5_en);
parameter INPUT_SIZE = 16;
parameter OUTPUT_SIZE = 14;


input logic clk, reset, stage1_en;
input logic [7:0] pixel_r, pixel_g, pixel_b;
logic stage2_en, stage3_en, stage4_en;
output logic stage5_en;
logic [8:0] i1, j1, i2, j2, i3, j3, i4, j4, i5, j5;
logic [INPUT_SIZE-1:0][INPUT_SIZE-1:0][7:0] mem_r ;
logic [INPUT_SIZE-1:0][INPUT_SIZE-1:0][7:0] mem_g ;
logic [INPUT_SIZE-1:0][INPUT_SIZE-1:0][7:0] mem_b ;
logic signed [OUTPUT_SIZE-1:0][OUTPUT_SIZE-1:0][10:0] stage2_r_out;
logic signed [OUTPUT_SIZE-1:0][OUTPUT_SIZE-1:0][10:0] stage2_g_out;
logic signed [OUTPUT_SIZE-1:0][OUTPUT_SIZE-1:0][10:0] stage2_b_out;
logic signed [OUTPUT_SIZE-1:0][OUTPUT_SIZE-1:0][10:0] stage3_r_out;
logic signed [OUTPUT_SIZE-1:0][OUTPUT_SIZE-1:0][10:0] stage3_g_out;
logic signed [OUTPUT_SIZE-1:0][OUTPUT_SIZE-1:0][10:0] stage3_b_out;
logic signed [OUTPUT_SIZE-1:0][OUTPUT_SIZE-1:0][10:0] stage4_r_out;
logic signed [OUTPUT_SIZE-1:0][OUTPUT_SIZE-1:0][10:0] stage4_g_out;
logic signed [OUTPUT_SIZE-1:0][OUTPUT_SIZE-1:0][10:0] stage4_b_out;
logic signed [OUTPUT_SIZE-1:0][OUTPUT_SIZE-1:0][12:0] result ;
logic [19:0] counter;
output logic [12:0] conv_out;
output logic conv_end;


always_ff@(posedge clk)
begin
if(!reset)
begin
i1 <= 9'b0;
j1 <= 9'b0;
end

else if (stage1_en)
begin
mem_r[i1][j1] <= pixel_r;
mem_g[i1][j1] <= pixel_g;
mem_b[i1][j1] <= pixel_b;
//mem_r[511][511] = 8'd0;
//mem_g[511][511] = 8'd0;
//mem_b[511][511] = 8'd0;

if(i1==9'd1 && j1==9'd1)
begin
stage2_en <= 1'b1;
end

if(j1 == INPUT_SIZE-1)
begin
i1 <= i1 + 1;
end
j1 <= j1 + 1;
end
end

always_ff@(posedge clk)
begin
if(!reset)
begin
i2 <= 9'b0;
j2 <= 9'b0;
end

else if(stage2_en)
begin
stage2_r_out[i2][j2] <= -(4*mem_r[i2+1][j2+1]);
stage2_g_out[i2][j2] <= -(4*mem_g[i2+1][j2+1]);
stage2_b_out[i2][j2] <= -(4*mem_b[i2+1][j2+1]);

if(i2 ==9'd1 && j2 == 9'd1)
begin
stage3_en <= 1'b1;
end

if(j2 == OUTPUT_SIZE-1)
begin
i2 <= i2 + 1;
j2 <= 0;
end
j2 <= j2 + 1;
end

else
begin
end
end

always_ff@(posedge clk)
begin
if(!reset)
begin
i3 <= 9'b0;
j3 <= 9'b0;
end

else if(stage3_en)
begin
stage3_r_out[i3][j3] <= mem_r[i3][j3+1] + mem_r[i3+1][j3] + mem_r[i3+1][j3+2] + mem_r[i3+2][j3+1];
stage3_g_out[i3][j3] <= mem_g[i3][j3+1] + mem_g[i3+1][j3] + mem_g[i3+1][j3+2] + mem_g[i3+2][j3+1];
stage3_b_out[i3][j3] <= mem_b[i3][j3+1] + mem_b[i3+1][j3] + mem_b[i3+1][j3+2] + mem_b[i3+2][j3+1];
stage4_en <= 1'b1;

if(j3 == OUTPUT_SIZE-1)
begin
i3 <= i3 + 1;
j3 <= 0;
end
j3 <= j3 + 1;
end

else
begin
end
end

always_ff@(posedge clk)
begin
if(!reset)
begin
i4 <= 9'b0;
j4 <= 9'b0;

end
else if(stage4_en)
begin
stage4_r_out[i4][j4] <= stage3_r_out[i4][j4] + stage2_r_out[i4][j4];
stage4_g_out[i4][j4] <= stage3_g_out[i4][j4] + stage2_g_out[i4][j4];
stage4_b_out[i4][j4] <= stage3_b_out[i4][j4] + stage2_b_out[i4][j4];
stage5_en <= 1'b1;

if(j4 == OUTPUT_SIZE-1)
begin
i4 <= i4 + 1;
j4 <= 0;
end
j4 <= j4 + 1;
end

else
begin
end
end


always_ff@(posedge clk)
begin
if(!reset)
begin
i5 <= 9'b0;
j5 <= 9'b0;
end
else if(stage5_en)
begin
result[i5][j5] <= stage4_r_out[i5][j5] + stage4_g_out[i5][j5] + stage4_b_out[i5][j5];
conv_out <= stage4_r_out[i5][j5] + stage4_g_out[i5][j5] + stage4_b_out[i5][j5];
if(j5 == OUTPUT_SIZE-1)
begin
i5 <= i5 + 1;
j5 <= 0;
end
j5 <= j5 + 1;
end

else
begin
end

end

endmodule