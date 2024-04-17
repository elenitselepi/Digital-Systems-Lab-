//Testbench for checking the uart protocol

`timescale 1ns/1ps
`define clock_period 10

module uart_testbench;


reg clk,reset;
reg [2:0] baud_select ;
reg [7:0] Tx_DATA ;
reg Rx_EN,Tx_EN,Tx_WR;

wire Rx_FERROR,Rx_PERROR,Rx_VALID,Tx_BUSY,TxD;
wire [7:0] Rx_DATA;


uart uart_inst(reset,clk,Tx_DATA,baud_select,Tx_WR,Tx_EN,Rx_EN,Rx_DATA,Rx_FERROR,Rx_PERROR,Rx_VALID,TxD,Tx_BUSY);

initial
begin
  clk=1'b0;
  reset=1'b0;
  Rx_EN=1'b0;
  Tx_EN=1'b0;
  
  baud_select=3'b110;
  Tx_DATA=8'b10101010;

  #(2*`clock_period) reset=1'b1;
  #(2*`clock_period) reset =1'b0;

  #60 Tx_EN=1'b1;
  Rx_EN=1'b1;
  #20 Tx_WR=1'b1;
  #10 Tx_WR=1'b0;
  
  #1800000 Tx_WR=1'b1;
  Tx_DATA = 8'b01010101; //send 55
  #10 Tx_WR=1'b0;
  
  #1800000 Tx_WR=1'b1;
  Tx_DATA = 8'b11001100; //send cc 
  #10 Tx_WR=1'b0;
  
  #1800000 Tx_WR=1'b1;
  Tx_DATA = 8'b10001001; //send 89
  #10 Tx_WR=1'b0;
  
  #2000030 baud_select=3'b100; //change the baud select 
  Tx_DATA=8'b10101010; //send aa
   
  #20 Tx_WR=1'b1;
  #10 Tx_WR=1'b0;
  
  #1800000 Tx_WR=1'b1;
  Tx_DATA = 8'b01010101; //send 55
  #10 Tx_WR=1'b0;
  
  #1800000 Tx_WR=1'b1;
  Tx_DATA = 8'b11001100; //send cc
  #10 Tx_WR=1'b0;
  
  #1800000 Tx_WR=1'b1;
  Tx_DATA = 8'b10001001; //send 89
  #10 Tx_WR=1'b0;
  


end

always
  #(`clock_period/2)clk = ~clk;


endmodule