module clock_divider(reset, clk, enable, clkdiv4);
  input reset, clk, enable;
  output clkdiv4;
  
  reg [1:0] cnt;

  assign clkdiv4 = (cnt==2'd3);
  always@ (posedge reset or posedge clk)
    if (reset) cnt <= 0;
    else if(enable) 
      if(clkdiv4) cnt <= 0; 
		else cnt <= cnt + 1;

endmodule

module TwentyFiveMHz(clk, reset, en_nxt);
	input clk, reset;
	output en_nxt;
	wire clk25MHz;
	
	clock_divider i1 (reset, clk, 1'b1, clk25MHz);
	assign en_nxt = clk25MHz;
endmodule