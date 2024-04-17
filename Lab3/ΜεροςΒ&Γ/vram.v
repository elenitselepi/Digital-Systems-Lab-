//Module for VRAM using BRAMs each for one colour

module vram(clk,reset,address,colours);

input clk,reset;
input [13:0] address; //2^14=16.384addresses
output [2:0]colours; //3bit colours RED,GRN,BLUE
wire red_colour,green_colour,blue_colour;


assign colours={red_colour,green_colour,blue_colour};



   BRAM_SINGLE_MACRO #(
      .BRAM_SIZE("18Kb"), // Target BRAM, "18Kb" or "36Kb" 
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .DO_REG(0), // Optional output register (0 or 1)
      .INIT(36'h000000000), // Initial values on output port
      .INIT_FILE ("NONE"),
      .WRITE_WIDTH(1), // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .READ_WIDTH(1),  // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .SRVAL(36'h000000000), // Set/Reset value for port output
      .WRITE_MODE("WRITE_FIRST"), // "WRITE_FIRST", "READ_FIRST", or "NO_CHANGE" 
      .INIT_00(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),  //2 lines white
      .INIT_01(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff), //2 lines red 
      .INIT_02(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_03(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_04(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_05(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_06(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_07(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_08(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_09(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_0A(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_0B(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      
      
      .INIT_0C(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff), //2lines white
      .INIT_0D(256'h00000000000000000000000000000000_00000000000000000000000000000000), //2lines green
      .INIT_0E(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_0F(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_10(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_11(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_12(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_13(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_14(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_15(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_16(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_17(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      
      
      .INIT_18(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),//2lines white
      .INIT_19(256'h00000000000000000000000000000000_00000000000000000000000000000000),//2lines blue
      .INIT_1A(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1B(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_1C(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1D(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_1E(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1F(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_20(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_21(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_22(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_23(256'h00000000000000000000000000000000_00000000000000000000000000000000), //2blue lines
      
                    //second line                    //fisrt line
      .INIT_24(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff), //first two lines are white 
      .INIT_25(256'h0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c_00000000000000000000000000000000),//fisrt line is black second line is 2black 1 red 2 green 2 blue
      .INIT_26(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f_0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
      .INIT_27(256'h0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c_0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c),
      .INIT_28(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f_0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
      .INIT_29(256'h0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c_0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c),
      .INIT_2A(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f_0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
      .INIT_2B(256'h0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c_0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c),
      .INIT_2C(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f_0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
      .INIT_2D(256'h0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c_0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c),
      .INIT_2E(256'h0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f_0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f),
      .INIT_2F(256'h00000000000000000000000000000000_0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c) //last line is black //00000000000000000000000000000000
      
     ) 
     BRAM_SINGLE_MACRO_instRED (
      .DO(red_colour),       // Output data, width defined by READ_WIDTH parameter
      .ADDR(address),   // Input address, width defined by read/write port depth
      .CLK(clk),     // 1-bit input clock
   //   .DI(DI),       // Input data port, width defined by WRITE_WIDTH parameter
      .EN(1),       // 1-bit input RAM enable
      //.REGCE(1), // 1-bit input output register enable
      .RST(reset),     // 1-bit input reset
      .WE(0)        // Input write enable, width defined by write port depth
   );
   
   
   
   
      BRAM_SINGLE_MACRO #(
      .BRAM_SIZE("18Kb"), // Target BRAM, "18Kb" or "36Kb" 
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .DO_REG(0), // Optional output register (0 or 1)
      .INIT(36'h000000000), // Initial values on output port
      .INIT_FILE ("NONE"),
      .WRITE_WIDTH(1), // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .READ_WIDTH(1),  // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .SRVAL(36'h000000000), // Set/Reset value for port output
      .WRITE_MODE("WRITE_FIRST"), // "WRITE_FIRST", "READ_FIRST", or "NO_CHANGE" 
      .INIT_00(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff), //first 2line white
      .INIT_01(256'h00000000000000000000000000000000_00000000000000000000000000000000), //2lines red
      .INIT_02(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_03(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_04(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_05(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_06(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_07(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_08(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_09(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_0A(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_0B(256'h00000000000000000000000000000000_00000000000000000000000000000000),//red
      
      
      .INIT_0C(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),//2lines white
      .INIT_0D(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),//2lines green
      .INIT_0E(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_0F(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_10(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_11(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_12(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_13(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_14(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_15(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_16(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_17(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      
      
      .INIT_18(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),//2lines white 
      .INIT_19(256'h00000000000000000000000000000000_00000000000000000000000000000000), //2lines blue
      .INIT_1A(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1B(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_1C(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1D(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_1E(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1F(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_20(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_21(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_22(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_23(256'h00000000000000000000000000000000_00000000000000000000000000000000),//blue
      
                   //second line                     //first line
      .INIT_24(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff), //2lines white
      .INIT_25(256'h30303030303030303030303030303030_00000000000000000000000000000000),//first line black
      .INIT_26(256'h33333333333333333333333333333333_33333333333333333333333333333333),
      .INIT_27(256'h30303030303030303030303030303030_30303030303030303030303030303030),
      .INIT_28(256'h33333333333333333333333333333333_33333333333333333333333333333333),
      .INIT_29(256'h30303030303030303030303030303030_30303030303030303030303030303030),
      .INIT_2A(256'h33333333333333333333333333333333_33333333333333333333333333333333),
      .INIT_2B(256'h30303030303030303030303030303030_30303030303030303030303030303030),
      .INIT_2C(256'h33333333333333333333333333333333_33333333333333333333333333333333),
      .INIT_2D(256'h30303030303030303030303030303030_30303030303030303030303030303030),
      .INIT_2E(256'h33333333333333333333333333333333_33333333333333333333333333333333),
      .INIT_2F(256'h00000000000000000000000000000000_30303030303030303030303030303030)
      
   ) BRAM_SINGLE_MACRO_instGREEN (
      .DO(green_colour),       // Output data, width defined by READ_WIDTH parameter
      .ADDR(address),   // Input address, width defined by read/write port depth
      .CLK(clk),     // 1-bit input clock
     // .DI(DI),       // Input data port, width defined by WRITE_WIDTH parameter
      .EN(1),       // 1-bit input RAM enable
      //.REGCE(1), // 1-bit input output register enable
      .RST(reset),     // 1-bit input reset
      .WE(0)        // Input write enable, width defined by write port depth
   );
   
     BRAM_SINGLE_MACRO #(
      .BRAM_SIZE("18Kb"), // Target BRAM, "18Kb" or "36Kb" 
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .DO_REG(0), // Optional output register (0 or 1)
      .INIT(36'h000000000), // Initial values on output port
      .INIT_FILE ("NONE"),
      .WRITE_WIDTH(1), // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .READ_WIDTH(1),  // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .SRVAL(36'h000000000), // Set/Reset value for port output
      .WRITE_MODE("WRITE_FIRST"), // "WRITE_FIRST", "READ_FIRST", or "NO_CHANGE" 
      .INIT_00(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff), //2lines white 
      .INIT_01(256'h00000000000000000000000000000000_00000000000000000000000000000000), //red
      .INIT_02(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_03(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_04(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_05(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_06(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_07(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_08(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_09(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_0A(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_0B(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      
      
      .INIT_0C(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),//white
      .INIT_0D(256'h00000000000000000000000000000000_00000000000000000000000000000000),//greem
      .INIT_0E(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_0F(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_10(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_11(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_12(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_13(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_14(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_15(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      .INIT_16(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_17(256'h00000000000000000000000000000000_00000000000000000000000000000000),
      
      
      .INIT_18(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),//white
      .INIT_19(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),//blue
      .INIT_1A(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1B(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1C(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1D(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1E(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_1F(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_20(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_21(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_22(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      .INIT_23(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),
      
      
      .INIT_24(256'hffffffffffffffffffffffffffffffff_ffffffffffffffffffffffffffffffff),//2white
      .INIT_25(256'hc0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0_00000000000000000000000000000000),//1black
      .INIT_26(256'hc3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3_c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3),
      .INIT_27(256'hc0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0_c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0),
      .INIT_28(256'hc3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3_c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3),
      .INIT_29(256'hc0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0_c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0),
      .INIT_2A(256'hc3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3_c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3),
      .INIT_2B(256'hc0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0_c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0),
      .INIT_2C(256'hc3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3_c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3),
      .INIT_2D(256'hc0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0_c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0),
      .INIT_2E(256'hc3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3_c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3c3),
      .INIT_2F(256'h00000000000000000000000000000000_c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0)
      
   ) BRAM_SINGLE_MACRO_instBLUE (
      .DO(blue_colour),       // Output data, width defined by READ_WIDTH parameter
      .ADDR(address),   // Input address, width defined by read/write port depth
      .CLK(clk),     // 1-bit input clock
      //.DI(DI),       // Input data port, width defined by WRITE_WIDTH parameter
      .EN(1),       // 1-bit input RAM enable
      //.REGCE(1), // 1-bit input output register enable
      .RST(reset),     // 1-bit input reset
      .WE(0)        // Input write enable, width defined by write port depth
   );
   
   
   





endmodule