//Testbench file for testing baud_cntroller
//Author Tselepi Eleni 

`timescale 1ns/1ps
`define clock_period 10
`include "baud_rate.vh"

module baud_controller_tb;

reg clk,reset;
reg [2:0] baud_select;
wire sample_ENABLE;

baud_controller baud_controller_inst(reset,clk,baud_select,sample_ENABLE);

initial
begin
clk=1'b0;
reset=1'b0;
baud_select=3'b111;

//Baud Rate 115200 bits/sec
#(53*`clock_period) //54-1 cycles 
if(sample_ENABLE==1'b1)
    $display("PASS");
else
    $display("NOT PASS");

#30 baud_select=3'b110;   //wait to change the baud_select
//Baud Rate 57600
#(107*`clock_period) //108-1 cycles 
if(sample_ENABLE==1'b1)
    $display("PASS");
else
    $display("NOT PASS");

#30 baud_select=3'b101;
//Baud Rate 38400   
#(161*`clock_period) //162-1 cycles 
if(sample_ENABLE==1'b1)
    $display("PASS");
else
    $display("NOT PASS");

#30 baud_select=3'b100;    
//Baud Rate 19200
#(324*`clock_period) //325-1 cycles 
if(sample_ENABLE==1'b1)
    $display("PASS");
else
    $display("NOT PASS");

#30 baud_select=3'b011;
//Baud Rate 9600    
#(650*`clock_period) //651-1 cycles 
if(sample_ENABLE==1'b1)
    $display("PASS");
else
    $display("NOT PASS");

#30 baud_select=3'b010;
//Baud Rate 4800   
#(1301*`clock_period) //1302-1 cycles 
if(sample_ENABLE==1'b1)
    $display("PASS");
else
    $display("NOT PASS");

#30 baud_select=3'b001;   
//Baud Rate 1200       
#(5207*`clock_period) //5208-1 cycles 
if(sample_ENABLE==1'b1)
    $display("PASS");
else
    $display("NOT PASS");

#30 baud_select=3'b000;    
//Baud Rate 300  
#(20832*`clock_period) //20833-1 cycles 
if(sample_ENABLE==1'b1)
    $display("PASS");
else
    $display("NOT PASS");

end

always
  #(`clock_period/2)clk = ~clk;

endmodule
