`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:52:33 06/01/2022 
// Design Name: 
// Module Name:    led_decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module led_decoder(input [4:0] bin_value, output reg [7:0] disp_value);

reg [7:0] memory[0:16];
initial begin
	memory[0] = 8'b11111100;
	memory[1] = 8'b01100000;
	memory[2] = 8'b11011010;
	memory[3] = 8'b11110010;
	memory[4] = 8'b01100110;
	memory[5] = 8'b10110110;
	memory[6] = 8'b10111110;
	memory[7] = 8'b11100000;
	memory[8] = 8'b11111110;
	memory[9] = 8'b11110110;
	memory[10] = 8'b11101110;
	memory[11] = 8'b00111110;
	memory[12] = 8'b10011100;
	memory[13] = 8'b01111010;
	memory[14] = 8'b10011110;
	memory[15] = 8'b10001110;
	memory[16] = 8'b00000000;
end

always @ (bin_value) begin
	disp_value <= memory[bin_value];
end

endmodule
