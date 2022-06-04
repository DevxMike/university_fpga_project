`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:17:19 06/02/2022 
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
module hardware_timer_test(input Clk, output reg LD0, output reg [7:0] SevenSegment, output reg[2:0] Enable);
wire timer_out1, timer_out2;
wire [7:0] driver_segment_vals;
reg [1:0] segment;
reg [3:0] time_elapsed;

reg[4:0] bin_value;

timer t1(Clk, 12000-1, 1000-1, timer_out1);
timer t2(Clk, 12000, 5-1, timer_out2);
led_decoder decoder(bin_value, driver_segment_vals);

initial begin
	LD0 = 0;
	time_elapsed = 0;
	segment = 0;
end

always @(posedge timer_out1)begin
	LD0 <= ~LD0;
	time_elapsed <= time_elapsed + 1;
end

always @ (posedge timer_out2) begin
	case(segment)
		0: begin Enable <= 3'b110; segment <= segment + 1; bin_value <= time_elapsed; end
		1: begin Enable <= 3'b101; segment <= segment + 1; bin_value <= 15; end
		2: begin Enable <= 3'b011; segment <= 0; bin_value <= 14; end
	endcase 
end

always @(driver_segment_vals)begin
	SevenSegment <= ~driver_segment_vals;
end

endmodule
