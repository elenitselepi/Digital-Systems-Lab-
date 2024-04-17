//Top module file for the vga driver
//Author Tselepi Eleni 

module vgacontroller(reset,clk,VGA_RED,VGA_GREEN,VGA_BLUE,VGA_HSYNC,VGA_VSYNC);

input reset,clk;

output VGA_RED,VGA_GREEN,VGA_BLUE; 
output VGA_HSYNC,VGA_VSYNC;

wire [6:0] HPIXEL; //7bit wire for the 128 horizontal position of the memory
wire [6:0] VPIXEL; //7bit wire for the 96 vertical positions of the memory 
wire flag_D,flagR; //flag when D state of hsync and R state of vsync is active
wire twenty_enable,five_enable; //flag when counters have count the 5 times the same pixel and the same line 
wire[2:0]colours;


vram vram_inst(clk,reset,{VPIXEL,HPIXEL},colours); //instantiation of the memory

HSYNC HSYNC_inst(clk,reset,flagR,flag_D,VGA_HSYNC);//instantiation of the hsync fsm
counter_twenty counter_twenty_inst(clk,reset,flag_D,twenty_enable);//instantiation of counter counting the same pixel 5 more times
hpixel_counter hpixel_counter_inst(clk,reset,twenty_enable,HPIXEL); //counter for hpixel

VSYNC VSYNC_inst(clk,reset,flagR,VGA_VSYNC);//instantiation of the vsync fsm   
five_counter five_counter_inst(clk,reset,flagR,five_enable);//instantiation of the counter counting 5 times the same line
vpixel_counter vpixel_counter_inst(clk,reset,five_enable,VPIXEL);//instantiation of the Vpixel counter 

RGB_enable RGB_enable_inst(flagR,flag_D,colours,{VGA_RED,VGA_GREEN,VGA_BLUE});//instantiation of the module for deciding the output of the colours  
endmodule