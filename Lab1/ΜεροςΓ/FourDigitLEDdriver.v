//Top level module 
//Author Tselepi Eleni 03272

module FourDigitLEDdriver(reset,clk,an3,an2,an1,an0,a,b,c,d,e,f,g,dp,button);

input clk,reset,button;//button is the M17 pin
output an3,an2,an1,an0;
output a,b,c,d,e,f,g,dp;


wire [3:0] char,address;
wire clk_out;
wire antibounce_reset; //the reset after the adibounce 
wire antibounce_button; //the button after the adibounce 
wire an3,an2,an1,an0;
wire clk_fbout;

wire [3:0]anodes_counter;

assign dp=1'b1; //dp is always off


 MMCME2_BASE #(
   .BANDWIDTH("OPTIMIZED"),   
   .CLKFBOUT_MULT_F(6), //M    
   .CLKFBOUT_PHASE(0.0),      
   .CLKIN1_PERIOD(10),      
   // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
   .CLKOUT1_DIVIDE(120), //O
   //.CLKOUT2_DIVIDE(1),
   //.CLKOUT3_DIVIDE(1),
   // .CLKOUT4_DIVIDE(1),
   // .CLKOUT5_DIVIDE(1),
   // .CLKOUT6_DIVIDE(1),
   // .CLKOUT0_DIVIDE_F(1.0),    // Divide amount for CLKOUT0 (1.000-128.000).
   // // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
   // .CLKOUT0_DUTY_CYCLE(0.5),
   //.CLKOUT1_DUTY_CYCLE(0.5),
   // .CLKOUT2_DUTY_CYCLE(0.5),
   // .CLKOUT3_DUTY_CYCLE(0.5),
   // .CLKOUT4_DUTY_CYCLE(0.5),
   // .CLKOUT5_DUTY_CYCLE(0.5),
   // .CLKOUT6_DUTY_CYCLE(0.5),
   // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
   //.CLKOUT0_PHASE(0.0),
   .CLKOUT1_PHASE(0.0),
   // .CLKOUT2_PHASE(0.0),
   // .CLKOUT3_PHASE(0.0),
   // .CLKOUT4_PHASE(0.0),
   // .CLKOUT5_PHASE(0.0),
   // .CLKOUT6_PHASE(0.0),
   // .CLKOUT4_CASCADE("FALSE"), 
   .DIVCLK_DIVIDE(1)     //D    
   //.REF_JITTER1(0.0),         
   //.STARTUP_WAIT("FALSE")     
 )

 MMCME2_BASE_inst (
   // Clock Outputs: 1-bit (each) output: User configurable clock outputs
  // .CLKOUT0(CLKOUT0),     
  // .CLKOUT0B(CLKOUT0B),   
   .CLKOUT1(clk_out),     
   // .CLKOUT1B(CLKOUT1B),   
   // .CLKOUT2(CLKOUT2),     
   // .CLKOUT2B(CLKOUT2B),   
   // .CLKOUT3(CLKOUT3),     
   // .CLKOUT3B(CLKOUT3B),   
   // .CLKOUT4(CLKOUT4),     
   // .CLKOUT5(CLKOUT5),     
   // .CLKOUT6(CLKOUT6),     
   // Feedback Clocks: 1-bit (each) output: Clock feedback ports
   .CLKFBOUT(clk_fbout),   
   //.CLKFBOUTB(CLKFBOUTB), 
   // Status Ports: 1-bit (each) output: MMCM status ports
   //.LOCKED(LOCKED),       
   // Clock Inputs: 1-bit (each) input: Clock input
   .CLKIN1(clk),       
   // Control Ports: 1-bit (each) input: MMCM control ports
   //.PWRDWN(PWRDWN),       
   .RST(reset),             
   // Feedback Clocks: 1-bit (each) input: Clock feedback ports
   .CLKFBIN(clk_fbout)      
 );

antibounce antibounce_inst_reset(reset,clk_out,antibounce_reset); //instatiate the antibounce module for the reset

antibounce antibounce_inst_button(button,clk_out,antibounce_button); //instatiate the antibounce module for the button 

rise_anodes rise_anodes_inst(clk_out,antibounce_reset,anodes_counter,an0,an1,an2,an3);//instantiate the module for the anodes.

address_counter address_counter(clk_out,antibounce_reset,antibounce_button,address);//instatiate the counter for the memory.

drive_char drive_char_inst(clk_out,anodes_counter,address,char); //instantiate the module about the value of the char

LEDdecoder LEDdecoder_inst(char,{a,b,c,d,e,f,g}); //instantiate the LEDdecoder

endmodule