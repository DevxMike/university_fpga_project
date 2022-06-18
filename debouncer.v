`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:29:07 06/17/2022 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
	input CLK,
	input[3:0] iSWITCH,
	output reg [3:0] oSWITCH
);

reg [7:0] tim = 0;

always @(posedge CLK) begin
	
	if(tim == 0)begin
		oSWITCH = iSWITCH;
		tim = 50;
	end
	else begin
		tim = tim - 1;
	end
end

endmodule
