//testbench module for testing the vga controller

`timescale 1ns/1ps
`define clock_period 10

module vgacontroller_tb;

reg clk,reset;
wire VGA_RED,VGA_GREEN,VGA_BLUE,VGA_HSYNC,VGA_VSYNC;

vgacontroller vgacontroller_inst(reset,clk,VGA_RED,VGA_GREEN,VGA_BLUE,VGA_HSYNC,VGA_VSYNC);

initial 
begin

  clk=1'b0;
  reset=1'b0;

  #(2*`clock_period) reset=1'b1;
  #(2*`clock_period) reset =1'b0;

end

always
  #(`clock_period/2)clk = ~clk;

endmodule