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
module led_decoder(input [3:0] bin_value, output reg [7:0] disp_val);

always @ (bin_value) begin
	case(bin_value)
		0:disp_val =        8'b01111110;
		1:disp_val =        8'b00110000;
		2:disp_val =        8'b01101101;
		3:disp_val =        8'b01111001;
		4:disp_val =        8'b00110011;
		5:disp_val =        8'b01011011;
		6:disp_val =        8'b01011111;
		7:disp_val =        8'b01110000;
		8:disp_val =        8'b01111111;
		9:disp_val =        8'b01111011;
		10:disp_val =       8'b01110111;
		11:disp_val =       8'b00011111;
		12:disp_val =       8'b01001110;
		13:disp_val =       8'b00111101;
		14:disp_val =       8'b01001111;
		15:disp_val =       8'b01000111;
		default:disp_val =  8'b00000000;
	endcase
end

endmodule
