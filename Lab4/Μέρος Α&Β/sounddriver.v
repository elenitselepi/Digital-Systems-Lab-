//Top level Module
//Author Tselepi Eleni

module sounddriver(reset,clk,recordEN, micGenCLK, micDataPDM, micLRselPDM, playbackEN, audDataPWM, audEnPWM);

input clk,reset;

// Recording Interface //
input recordEN;
input micDataPDM;//Data from microphone
output micGenCLK, micLRselPDM;

// Playback Interface //
input playbackEN;
output audDataPWM, audEnPWM;

wire [31:0]deserialised; //the output of the shifter(deserialiser)
wire [31:0] readdata; //DO bram
wire [9:0] address,write_address,read_address;
wire [3:0]we; //write enable 
wire flag_record,flag_play;
wire clk_fbout,big_clk,small_clk;

wire antibounce_recordEN,antibounce_playbackEN;


MMCME2_BASE #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming (OPTIMIZED, HIGH, LOW)
      .CLKFBOUT_MULT_F(6),  //M   // Multiply value for all CLKOUT (2.000-64.000).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (-360.000-360.000).
      .CLKIN1_PERIOD(10),       // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      //.CLKOUT1_DIVIDE(3),
      //.CLKOUT2_DIVIDE(1),
      //.CLKOUT3_DIVIDE(1),
      .CLKOUT4_DIVIDE(100),
      //.CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(3),
      //.CLKOUT0_DIVIDE_F(1.0),    // Divide amount for CLKOUT0 (1.000-128.000).
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      // .CLKOUT0_DUTY_CYCLE(0.5),
      // .CLKOUT1_DUTY_CYCLE(0.5),
      // .CLKOUT2_DUTY_CYCLE(0.5),
      // .CLKOUT3_DUTY_CYCLE(0.5),
      // .CLKOUT4_DUTY_CYCLE(0.5),
      // .CLKOUT5_DUTY_CYCLE(0.5),
      // .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      // .CLKOUT0_PHASE(0.0),
      // .CLKOUT1_PHASE(0.0),
      // .CLKOUT2_PHASE(0.0),
      // .CLKOUT3_PHASE(0.0),
      // .CLKOUT4_PHASE(0.0),
      // .CLKOUT5_PHASE(0.0),
      // .CLKOUT6_PHASE(0.0),
       .CLKOUT4_CASCADE("TRUE"), // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      .DIVCLK_DIVIDE(1)         // Master division value (1-106)
      //.REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      //.STARTUP_WAIT("FALSE")     // Delays DONE until MMCM is locked (FALSE, TRUE)
   )
   MMCME2_BASE_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      //.CLKOUT0(CLKOUT0),     // 1-bit output: CLKOUT0
      //.CLKOUT0B(CLKOUT0B),   // 1-bit output: Inverted CLKOUT0
      //.CLKOUT1(big_clk),     // 1-bit output: CLKOUT1
      // .CLKOUT1B(CLKOUT1B),   // 1-bit output: Inverted CLKOUT1
      // .CLKOUT2(CLKOUT2),     // 1-bit output: CLKOUT2
      // .CLKOUT2B(CLKOUT2B),   // 1-bit output: Inverted CLKOUT2
      // .CLKOUT3(CLKOUT3),     // 1-bit output: CLKOUT3
      // .CLKOUT3B(CLKOUT3B),   // 1-bit output: Inverted CLKOUT3
       .CLKOUT4(small_clk),     // 1-bit output: CLKOUT4
      // .CLKOUT5(CLKOUT5),     // 1-bit output: CLKOUT5
       .CLKOUT6(big_clk),     // 1-bit output: CLKOUT6
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(clk_fbout),   // 1-bit output: Feedback clock
      // .CLKFBOUTB(CLKFBOUTB), // 1-bit output: Inverted CLKFBOUT
      // // Status Ports: 1-bit (each) output: MMCM status ports
      // .LOCKED(LOCKED),       // 1-bit output: LOCK
      // Clock Inputs: 1-bit (each) input: Clock input
      .CLKIN1(clk),       // 1-bit input: Clock
      // Control Ports: 1-bit (each) input: MMCM control ports
      //.PWRDWN(PWRDWN),       // 1-bit input: Power-down
      .RST(reset),             // 1-bit input: Reset
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(clk_fbout)      // 1-bit input: Feedback clock
   );

   recorddriver recorddriver_inst(big_clk,small_clk,reset,recordEN,micDataPDM ,micGenCLK, micLRselPDM,we,deserialised,write_address,flag_record);//FSM for recording the message
   playdriver playdriver_inst(big_clk,small_clk,reset,playbackEN,readdata,audDataPWM,read_address,flag_play,audEnPWM);//FSM for playing the message 
   address_controller address_controller_inst(flag_record,flag_play,write_address,read_address,address); //controller about the addresses
   bram bram_inst(big_clk,reset,address,deserialised,readdata,we); //BRAM inst
   antibounce antibounce_inst_record(recordEN,big_clk,antibounce_recordEN);
   antibounce antibounce_inst_play(playbackEN,big_clk,antibounce_playbackEN);


endmodule