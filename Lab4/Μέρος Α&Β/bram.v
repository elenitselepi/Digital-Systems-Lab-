//Module for the BRAM
//Author Tselepi Eleni

module bram(clk,reset,address,writedata,readdata,we);

input clk,reset;
input [9:0] address; //2^10=1024 32.768/32(write width) = 1024  addresses . The rest out of 36.000 are parity bits 
input [31:0] writedata; //input 32bits data to write to the memory 
input [3:0] we; // write enable
output [31:0] readdata; //output data when read from the memory 


   BRAM_SINGLE_MACRO #(
      .BRAM_SIZE("36Kb"), // Target BRAM, "18Kb" or "36Kb" 
      .DEVICE("7SERIES"), // Target Device: "7SERIES" 
      .DO_REG(0), // Optional output register (0 or 1)
      .INIT(36'h000000000), // Initial values on output port
      .INIT_FILE ("NONE"),
      .WRITE_WIDTH(32), // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .READ_WIDTH(32),  // Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      .SRVAL(36'h000000000), // Set/Reset value for port output
      .WRITE_MODE("WRITE_FIRST"), // "WRITE_FIRST", "READ_FIRST", or "NO_CHANGE" 
      .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),

      // The next set of INIT_xx are valid when configured as 36Kb
      .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),

      // The next set of INITP_xx are for the parity bits
      .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),

      // The next set of INIT_xx are valid when configured as 36Kb
      .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000)
   ) BRAM_SINGLE_MACRO_inst (
      .DO(readdata),       // Output data, width defined by READ_WIDTH parameter
      .ADDR(address),   // Input address, width defined by read/write port depth
      .CLK(clk),     // 1-bit input clock
      .DI(writedata),       // Input data port, width defined by WRITE_WIDTH parameter
      .EN(1),       // 1-bit input RAM enable
      //.REGCE(REGCE), // 1-bit input output register enable
      .RST(reset),    // 1-bit input reset
      .WE(we)        // Input write enable, width defined by write port depth
   );


endmodule
