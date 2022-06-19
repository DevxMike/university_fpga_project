`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:10:57 06/17/2022 
// Design Name: 
// Module Name:    main_graph 
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
module main_graph(
		input CLK,
		input [3:0] SWITCH,
		output reg [3:0] LED,
		output reg [2:0] sim_state
);



parameter[15:0] t_delay_default = 2000; 						//default 2000ms delay
parameter[15:0] t_delay_0_3 = t_delay_default - 300;     //t_del - 0.3s
parameter[15:0] t_delay_0_2 = t_delay_default - 200;     //t_del - 0.2s 
parameter[15:0] t_delay_0_8 = t_delay_default * 0.8;     //t_del * 0.8
parameter[15:0] t_delay_1_2 = t_delay_default * 1.2;		//t_del * 1.2

reg diff_is_positive = 0;
reg [63:0] millis = 0;
reg [63:0] t1 = 0;
reg [63:0] t2 = 0;
reg [63:0] t_diff = 0;
reg [15:0] t_delay = t_delay_default;
reg [2:0] state = 0;
reg [15:0] tim;
reg t_diff_state = 0;
wire [3:0] oSWITCH;
wire t_out;

timer time_base(
	.clk(CLK), 
	.prescaler(12-1), 
	.period(1000-1), 
	.out(t_out)
);

debouncer d(
	.CLK(CLK), 
	.iSWITCH(SWITCH), 
	.oSWITCH(oSWITCH)
);

always @(oSWITCH[1]) begin
	t1 = millis;
end

always @(oSWITCH[2]) begin
	t2 = millis;
end

always @(t_diff) begin
	if(diff_is_positive && t_diff <= 1000) begin
		t_delay = t_delay_default;
	end
	else begin
		case(t_diff_state)
			0: begin
				if(diff_is_positive) begin
					t_delay = t_delay_0_3;
				end
				else begin
					t_delay = t_delay_0_2;
				end
			end
			
			1: begin
				if(diff_is_positive) begin
					t_delay = t_delay_0_8;
				end
				else begin
					t_delay = t_delay_1_2;
				end
			end
		endcase
	end
end

always @(posedge t_out) begin
	case(state)
		0:begin
			LED = 4'b0000;
			if(oSWITCH[3] == 0) begin
				state = 1;
				tim = t_delay;
			end
		end
		
		1:begin
			LED = 4'b0001;
			if(tim == 0) begin
				state = 2;
			end
		end
		
		2:begin
			LED = 4'b0011;
			if(oSWITCH[1] == 0 || oSWITCH[2] == 0) begin
				state = 3;
				tim = 1000;
			end
		end
		
		3:begin
			LED = 4'b0011;
			if(tim == 0) begin
				state = 4; 
				tim = 5000;
			end 
			else if(oSWITCH[1] == 0 && oSWITCH[2] == 0) begin
				if(t2 > t1) begin
					t_diff = t2 - t1;
					diff_is_positive = 1;
					t_diff_state = 0;
				end
				else begin
					t_diff = t1 - t2;
					diff_is_positive = 0;
					t_diff_state = 1;
				end
				state = 5;
			end
		end
		
		4:begin
			LED = 4'b0111;
			if(tim == 0) begin
				state = 7; 
			end 
			else if(oSWITCH[1] == 0 && oSWITCH[2] == 0) begin
				if(t2 > t1) begin
					t_diff = t2 - t1;
					diff_is_positive = 1;
					t_diff_state = 1;
				end
				else begin
					t_diff = t1 - t2;
					diff_is_positive = 0;
					t_diff_state = 1;
				end
				state = 5;
			end
		end
		
		5:begin
			LED = 4'b1011;
			if(oSWITCH[0] == 0) begin
				state = 6;
			end
		end
		
			6:begin
				LED = 4'b1011;
				if(oSWITCH[3]) begin
					state = 7;
				end
			end
			
			7:begin
				LED = 4'b0000;
				if(oSWITCH[0] == 0) begin
					state = 0;
				end
			end
		endcase
		
		if(tim) begin
			tim = tim - 1;
		end
		
		millis = millis + 1;
		
		sim_state = state;
	end

	endmodule
