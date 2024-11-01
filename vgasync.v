`include "parameters.v"

module vgasync(reset, clk25, HcntValue, VcntValue, hsync, vsync, r, g, b, scancode, enable);
input clk25, enable, reset;
input [7:0] scancode;
input [9:0] HcntValue;
input [8:0] VcntValue;

output hsync, vsync;
output [2:0] r, g, b;
wire [3:0] section;
reg [8:0] r_rgb1, r_rgb2, r_rgb3, r_rgb4, r_rgb5, r_rgb6;
reg [4:0] zone;

reg [2:0] red1, green1, blue1;
reg [2:0] red2, green2, blue2;
reg [2:0] red3, green3, blue3;
reg [2:0] red4, green4, blue4;
reg [2:0] red5, green5, blue5;
reg [2:0] red6, green6, blue6;

reg r_check1, g_check1, b_check1;
reg r_check2, g_check2, b_check2;
reg r_check3, g_check3, b_check3;
reg r_check4, g_check4, b_check4;
reg r_check5, g_check5, b_check5;
reg r_check6, g_check6, b_check6;



assign hsync = (HcntValue > (`HF - 1) && HcntValue < (`HF + `HSYNC_PULSE - 1)) ? 0:1; //high apo 16 - 111
assign vsync = (VcntValue > (`VF - 1) && VcntValue < (`VF + `VSYNC_PULSE - 1)) ? 1:0; //high apo 12 - 13

assign section =	 (HcntValue > (`HF + `HSYNC_PULSE + `HB) && HcntValue <= ((`HF + `HSYNC_PULSE + `HB) + 213) && VcntValue > (`VF + `VSYNC_PULSE + `VB) && VcntValue <= ((`VF + `VSYNC_PULSE + `VB) + 200)) ? 4'd1 :																	

					    (HcntValue > ((`HF + `HSYNC_PULSE + `HB) + 213) && HcntValue <= ((`HF + `HSYNC_PULSE + `HB) + 2 * 213) && VcntValue > (`VF + `VSYNC_PULSE + `VB) && VcntValue <= ((`VF + `VSYNC_PULSE + `VB) + 200)) ? 4'd2 : 

					    (HcntValue > ((`HF + `HSYNC_PULSE + `HB) + 2 * 213) && HcntValue <= ((`HF + `HSYNC_PULSE + `HB) + 3 * 213) && VcntValue > (`VF + `VSYNC_PULSE + `VB) && VcntValue <= ((`VF + `VSYNC_PULSE + `VB) + 200)) ? 4'd3 : 

					    (HcntValue > (`HF + `HSYNC_PULSE + `HB) && HcntValue <= ((`HF + `HSYNC_PULSE + `HB) + 213) && VcntValue > ((`VF + `VSYNC_PULSE + `VB) + 200) && VcntValue <= ((`VF + `VSYNC_PULSE + `VB) + 2 * 200)) ? 4'd4 : 

                	 (HcntValue > ((`HF + `HSYNC_PULSE + `HB) + 213) && HcntValue <= ((`HF + `HSYNC_PULSE + `HB) + 2 * 213) && VcntValue > ((`VF + `VSYNC_PULSE + `VB) + 200) && VcntValue <= ((`VF + `VSYNC_PULSE + `VB) + 2 * 200)) ? 4'd5 : 

					    (HcntValue > ((`HF + `HSYNC_PULSE + `HB) + 2 * 213) && HcntValue <= ((`HF + `HSYNC_PULSE + `HB) + 3 * 213) && VcntValue > ((`VF + `VSYNC_PULSE + `VB) + 200) && VcntValue <= ((`VF + `VSYNC_PULSE + `VB) + 2 * 200)) ? 4'd6 : 4'd0;
					 
always @(posedge clk25 or posedge reset) 
begin
	
	if(reset)
		begin
			zone<=0;
		end
	else if(enable)
	begin
		zone <=(scancode == 8'h16) ? 4'd1 : //1
				 (scancode == 8'h1E) ? 4'd2 : //2
				 (scancode == 8'h26) ? 4'd3 : //3
				 (scancode == 8'h25) ? 4'd4 : //4
				 (scancode == 8'h2E) ? 4'd5 : //5
				 (scancode == 8'h36) ? 4'd6 : //6
				 (scancode == 8'h76) ? 4'd0 : zone;//Loop 
		
		if(zone==1)
			begin
			if (scancode==8'h2D) begin //Red
					if(!r_check1) begin
						red1 <= (red1 + 3'd1);
						if(red1 == 3'd6) r_check1 <= 1;
					end
					else if(r_check1) begin
						red1 <= (red1 - 3'd1);
						if(red1 == 3'd1) r_check1 <= 0;
					end				
            end
			else if (scancode == 8'h34) begin //Green
					if(!g_check1) begin
						green1 <= (green1 + 3'd1);
						if(green1 == 3'd6) g_check1 <= 1;
					end
					else if(g_check1) begin
						green1 <= (green1 - 3'd1);
						if(green1 == 3'd1) g_check1 <= 0;
					end
            end
			else if(scancode == 8'h32) begin //Blue
					if(!b_check1) begin
						blue1 <= (blue1 + 3'd1);
						if(blue1 == 3'd6) b_check1 <= 1;
					end
					else if(b_check1) begin
						blue1 <= (blue1 - 3'd1);
						if(blue1 == 3'd1) b_check1 <= 0;
					end
            
        end
		  r_rgb1 <= {blue1, green1, red1};
			end
		if(zone==2)
			begin
			if (scancode == 8'h2D) begin //Red
					if(!r_check2) begin
						red2 <= (red2 + 3'd1);
						if(red2 == 3'd6) r_check2 <= 1;
					end
					else if(r_check2) begin
						red2 <= (red2 - 3'd1);
						if(red2 == 3'd1) r_check2 <= 0;
					end				
            end
			else if (scancode == 8'h34) begin //Green
					if(!g_check2) begin
						green2 <= (green2 + 3'd1);
						if(green2 == 3'd6) g_check2 <= 1;
					end
					else if(g_check2) begin
						green2 <= (green2 - 3'd1);
						if(green2 == 3'd1) g_check2 <= 0;
					end
            end
			else if(scancode == 8'h32) begin //Blue
					if(!b_check2) begin
						blue2 <= (blue2 + 3'd1);
						if(blue2 == 3'd6) b_check2 <= 1;
					end
					else if(b_check2) begin
						blue2 <= (blue2 - 3'd1);
						if(blue2 == 3'd1) b_check2 <= 0;
					end
         end
        
		  r_rgb2 <= {blue2, green2, red2};
			end
		if(zone==3) 
			begin
			if (scancode == 8'h2D) begin //Red
					if(!r_check3) begin
						red3 <= (red3 + 3'd1);
						if(red3 == 3'd6) r_check3 <= 1;
					end
					else if(r_check3) begin
						red3 <= (red3 - 3'd1);
						if(red3 == 3'd1) r_check3 <= 0;
					end				
            end
			else if (scancode == 8'h34) begin //Green
					if(!g_check3) begin
						green3 <= (green3 + 3'd1);
						if(green3 == 3'd6) g_check3 <= 1;
					end
					else if(g_check3) begin
						green3 <= (green3 - 3'd1);
						if(green3 == 3'd1) g_check3 <= 0;
					end
            end
			else if(scancode == 8'h32) begin //Blue
					if(!b_check3) begin
						blue3 <= (blue3 + 3'd1);
						if(blue3 == 3'd6) b_check3 <= 1;
					end
					else if(b_check3) begin
						blue3 <= (blue3 - 3'd1);
						if(blue3 == 3'd1) b_check3 <= 0;
					end
         end
        
		  r_rgb3 <= {blue3, green3, red3};
		  end
		if(zone==4) 
			begin
			if (scancode == 8'h2D) begin //Red
					if(!r_check4) begin
						red4 <= (red4 + 3'd1);
						if(red4 == 3'd6) r_check4 <= 1;
					end
					else if(r_check4) begin
						red4 <= (red4 - 3'd1);
						if(red4 == 3'd1) r_check4 <= 0;
					end				
            end
			else if (scancode == 8'h34) begin //Green
					if(!g_check4) begin
						green4 <= (green4 + 3'd1);
						if(green4 == 3'd6) g_check4 <= 1;
					end
					else if(g_check4) begin
						green4 <= (green4 - 3'd1);
						if(green4 == 3'd1) g_check4 <= 0;
					end
            end
			else if(scancode == 8'h32) begin //Blue
					if(!b_check4) begin
						blue4 <= (blue4 + 3'd1);
						if(blue4 == 3'd6) b_check4 <= 1;
					end
					else if(b_check4) begin
						blue4 <= (blue4 - 3'd1);
						if(blue4 == 3'd1) b_check4 <= 0;
					end
         end
        
		  r_rgb4 <= {blue4, green4, red4};
			end
		if(zone==5) 
			begin
			if (scancode == 8'h2D) begin //Red
					if(!r_check5) begin
						red5 <= (red5 + 3'd1);
						if(red5 == 3'd6) r_check5 <= 1;
					end
					else if(r_check5) begin
						red5 <= (red5 - 3'd1);
						if(red5 == 3'd1) r_check5 <= 0;
					end				
            end
			else if (scancode == 8'h34) begin //Green
					if(!g_check5) begin
						green5 <= (green5 + 3'd1);
						if(green5 == 3'd6) g_check5 <= 1;
					end
					else if(g_check5) begin
						green5 <= (green5 - 3'd1);
						if(green5 == 3'd1) g_check5 <= 0;
					end
            end
			else if(scancode == 8'h32) begin //Blue
					if(!b_check5) begin
						blue5 <= (blue5 + 3'd1);
						if(blue5 == 3'd6) b_check5 <= 1;
					end
					else if(b_check5) begin
						blue5 <= (blue5 - 3'd1);
						if(blue5 == 3'd1) b_check5 <= 0;
					end
         end
        
		  r_rgb5 <= {blue5, green5, red5};
			end
		if(zone==6) 
			begin
			if (scancode == 8'h2D) begin //Red
					if(!r_check6) begin
						red6 <= (red6 + 3'd1);
						if(red6 == 3'd6) r_check6 <= 1;
					end
					else if(r_check6) begin
						red6 <= (red6 - 3'd1);
						if(red6 == 3'd1) r_check6 <= 0;
					end				
            end
			else if (scancode == 8'h34) begin //Green
					if(!g_check6) begin
						green6 <= (green6 + 3'd1);
						if(green6 == 3'd6) g_check6 <= 1;
					end
					else if(g_check6) begin
						green6 <= (green6 - 3'd1);
						if(green6 == 3'd1) g_check6 <= 0;
					end
            end
			else if(scancode == 8'h32) begin //Blue
					if(!b_check6) begin
						blue6 <= (blue6 + 3'd1);
						if(blue6 == 3'd6) b_check6 <= 1;
					end
					else if(b_check6) begin
						blue6 <= (blue6 - 3'd1);
						if(blue6 == 3'd1) b_check6 <= 0;
					end
         end
        
		  r_rgb6 <= {blue6, green6, red6};
			end
		if(zone == 0) //reset with ESC
			begin
				r_rgb1 <= 9'b000000000;
				r_rgb2 <= 9'b000000000;
				r_rgb3 <= 9'b000000000;
				r_rgb4 <= 9'b000000000;
				r_rgb5 <= 9'b000000000;
				r_rgb6 <= 9'b000000000;
				
			end
		end
end




assign {b, g, r} = (section == 4'd1) ? r_rgb1 :
						 (section == 4'd2) ? r_rgb2 :
						 (section == 4'd3) ? r_rgb3 :
						 (section == 4'd4) ? r_rgb4 :
						 (section == 4'd5) ? r_rgb5 :
						 (section == 4'd6) ? r_rgb6 : {3'h0, 3'h0, 3'h0};
endmodule