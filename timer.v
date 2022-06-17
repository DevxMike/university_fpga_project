`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:32:29 06/02/2022 
// Design Name: 
// Module Name:    timer 
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
module timer(input clk, input [31:0] prescaler, input [31:0] period, output reg out);
//f_out = f_osc/[(prescaler + 1)(period + 1)]
//note that prescaler == 0 is forbidden
reg [31:0] current_presc_value = 0;
reg [31:0] current_period_value = 0;
reg internal_clk = 0;

always @(posedge clk)begin
	if(current_presc_value == prescaler)begin
		internal_clk <= 1;
		current_presc_value <= 0;
	end
	else begin
		current_presc_value <= current_presc_value + 1;
		internal_clk <= 0;
	end
end

always @(posedge internal_clk)begin
	if(current_period_value == period)begin
		out <= 1;
		current_period_value <= 0;
	end
	else begin 
		out <= 0;
		current_period_value <= current_period_value + 1;
	end
end

endmodule
