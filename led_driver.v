`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:28:07 06/02/2022 
// Design Name: 
// Module Name:    led_driver 
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
module led_driver(input Clk, output reg [7:0] SevenSegment, output reg[2:0] Enable);
wire [7:0] driver_segment_vals;
reg [1:0] segment = 0;
wire ton_et1, ton_et2, ton_et3;
wire ton_q1, ton_q2, ton_q3;

TON t1(
.CLK(Clk),
.RST(0),
.IN(segment == 0),
.PT(12000000),
.ET(ton_et1),
.Q(ton_q1)
);
TON t2(
.CLK(Clk),
.RST(0),
.IN(segment == 1),
.PT(12000000),
.ET(ton_et2),
.Q(ton_q2)
);
TON t3(
.CLK(Clk),
.RST(0),
.IN(segment == 2),
.PT(12000000),
.ET(ton_et3),
.Q(ton_q3)
);
reg[3:0] bin_value;
led_decoder decoder(bin_value, driver_segment_vals);



always @ (posedge Clk) begin
	case(segment)
		0: begin Enable = 3'b110; bin_value = 1; if(ton_q1)segment = 1; end
		1: begin Enable = 3'b101; bin_value = 11; if(ton_q2)segment = 2; end
		2: begin Enable = 3'b011; bin_value = 5; if(ton_q3)segment = 0; end
	endcase 
	
	SevenSegment = ~driver_segment_vals;
end

endmodule
