`include "parameters.v"

module VerticalCnt(vga_clk, reset, VcntEnable, VcntValue);
	input vga_clk, reset, VcntEnable;
	output reg [8:0] VcntValue=0;

	always @(posedge vga_clk or posedge reset) begin
		if (reset) VcntValue <= 0;
		else begin
			if(VcntEnable == 1'b1)
				if(VcntValue < `VMAX) VcntValue <= VcntValue + 1;
				else VcntValue <= 0;				
		end
	end
endmodule
