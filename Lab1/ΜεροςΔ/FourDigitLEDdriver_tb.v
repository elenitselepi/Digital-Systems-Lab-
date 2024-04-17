//Testbench file for testing the FourDigitLEDdriver .
//Author Tselepi Eleni 03272

`timescale 1ns/1ps
`define clock_period 10
`include "parameters.vh" 


module FourDigitLEDdriver_tb;

reg clk,reset;
wire an3,an2,an1,an0;
wire a,b,c,d,e,f,g,dp;


FourDigitLEDdriver FourDigitLEDdriver_inst(reset,clk,an3,an2,an1,an0,a,b,c,d,e,f,g,dp) ; //instantiate FourDigitLEDdriver

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