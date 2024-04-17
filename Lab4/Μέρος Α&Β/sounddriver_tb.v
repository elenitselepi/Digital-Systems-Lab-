//Testbench file for testing the sounddriver .
//Author Tselepi Eleni 

`timescale 1ns/1ps
`define clock_period 10

module sounddriver_tb;

reg reset,clk,recordEN,micDataPDM,playbackEN;
wire micGenCLK,micLRselPDM,audDataPWM,audEnPWM;

sounddriver sounddriver_inst(reset,clk,recordEN, micGenCLK, micDataPDM, micLRselPDM, playbackEN, audDataPWM, audEnPWM);//instantiation of the top module

initial
begin

  clk=1'b0;
  reset=1'b0;
  recordEN=1'b0;
  playbackEN=1'b0;
  #(2*`clock_period) reset=1'b1;
  #(2*`clock_period) reset =1'b0;
 
  
  #352 recordEN=1'b1; //start record
  
  micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b1;//end of firstdata
  
  #500 micDataPDM = 1'b0;//secodndata
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b0;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  #500 micDataPDM = 1'b1;
  
  #500 micDataPDM = 1'b0;//thirddata

  
  #20122 playbackEN=1'b1; //start playing the message 
  
end

always
  #(`clock_period/2)clk = ~clk;

endmodule
