module HorizontalCnt(vga_clk, reset, HcntValue, VcntEnable);
	input vga_clk, reset;
	output reg [9:0] HcntValue=0;
	output reg VcntEnable=0;

	always @(posedge vga_clk or posedge reset) begin
		if (reset) begin
			HcntValue <= 0;
			VcntEnable <= 0;
		end
		else begin
			if(HcntValue < 800) begin
				HcntValue <= HcntValue + 1;
				VcntEnable <= 0;
			end
			else begin
				HcntValue <= 0;
				VcntEnable <=1;
			end
		end
	end
endmodule
