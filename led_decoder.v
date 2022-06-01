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
module led_decoder(input [3:0] bin_value, output reg [6:0] disp_value);

reg [6:0] memory[0:15];
initial begin
	memory[0] = 7'b1111110;
	memory[1] = 7'b0110000;
	memory[2] = 7'b1101101;
	memory[3] = 7'b1111001;
	memory[4] = 7'b0110011;
	memory[5] = 7'b1011011;
	memory[6] = 7'b1011111;
	memory[7] = 7'b1110000;
	memory[8] = 7'b1111111;
	memory[9] = 7'b1111011;
	memory[10] = 7'b1110111;
	memory[11] = 7'b0011111;
	memory[12] = 7'b1001110;
	memory[13] = 7'b0111101;
	memory[14] = 7'b1001111;
	memory[15] = 7'b1000111;
end

always @ (bin_value) begin
	disp_value <= memory[bin_value];
end

endmodule
