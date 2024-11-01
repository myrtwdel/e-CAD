module top(reset, clk, ps2clk, ps2data, hsync, vsync, red, green, blue);
	
	input reset, clk;
	input ps2clk, ps2data;
	
	output hsync, vsync;
	output [2:0] red, green, blue;
	
	wire [9:0] Hcount;
	wire [8:0] Vcount;
	wire clk25;
	wire enable;
	wire [7:0]scancode;
	
	TwentyFiveMHz cl25(clk, reset, clk25);
	HorizontalCnt hcnt(clk25, reset, Hcount, Venable);
	VerticalCnt vcnt(clk25, reset, Venable, Vcount);
	kbd_protocol kbdp (reset, clk25, ps2clk, ps2data, scancode, enable);
	vgasync vga(reset, clk25, Hcount, Vcount, hsync, vsync, red, green, blue, scancode, enable);

endmodule
