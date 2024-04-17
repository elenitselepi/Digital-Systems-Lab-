//Testbench file for testing transmitter
//Authro Tselepi Eleni 

`timescale 1ns/1ps
`define clock_period 10

module uart_transmitter_tb;

reg clk,reset;
reg [2:0] baud_select=3'b111;
reg [7:0] Tx_DATA=8'b10001001;
reg Tx_WR,Tx_EN;
wire TxD,Tx_BUSY;


uart_transmitter uart_transmitter_inst(reset,clk,Tx_DATA,baud_select,Tx_WR,Tx_EN,TxD,Tx_BUSY);

initial
begin
  clk=1'b0;
  reset=1'b0;
  Tx_WR=1'b0;
  #(2*`clock_period) reset=1'b1;
  #(2*`clock_period) reset =1'b0;
  Tx_EN=1'b1;

  #20 Tx_WR=1'b1;
  #10 Tx_WR=1'b0;
  
end

always
  #(`clock_period/2)clk = ~clk;



endmodule