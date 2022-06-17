`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:53:55 06/15/2022 
// Design Name: 
// Module Name:    hardware_timer_test 
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
module hardware_timer_test(
	input Clk, 
	output reg LD0
);

wire t_out;

timer blink_timer(
	.clk(Clk), 
	.prescaler(12000-1), 
	.period(1000-1), 
	.out(t_out)
);

always @(posedge t_out) begin
	LD0 <= ~LD0;
end

endmodule
