    // --- Horizontal Total Time = ( HD + HF + HSP + HBP ) = 800 ------------

    `define HD  640             // horizontal display area width in pixels
    `define HF  16              // horizontal front porch width in pixels
    `define HSYNC_PULSE  96     // horizontal Sync Pulse
    `define HB  48              // horizontal back porch width in pixels

    `define HMAX  800           //HD+HF+HB+HSYNC_PULSE; // max value of horizontal counter = 800
    
    
    // --- Vertical Total Time = ( VDR + VFP + VSP + VBP ) = 449 --------------

    `define VD  400             // vertical display area length in pixels 
    `define VF  12              // vertical front porch length in pixels  
    `define VB  35              // vertical back porch length in pixels   
    `define VSYNC_PULSE  2      // vertical retrace length in pixels  
    `define VMAX  449            //VD+VF+VB+VSYNC_PULSE;   // max value of vertical counter = 449 

    // Character Print Area Horizontal
    //`define left  235           //Left Limit
    //`define right  465         //Right Limit

    // Character Print Area Vertical


    //`define top  220            //Top Limit
    //`define bottom  440         //Bottom Limit
	 
