//Testbench file for testing receiver
//Authro Tselepi Eleni 

`timescale 1ns/1ps
`define clock_period 10

module uart_receiver_tb;

reg clk,reset;
reg [2:0] baud_select=3'b111;
reg Rx_EN; //the enable signal for the receiver
reg RxD=1'b0; //the input message
wire [7:0] Rx_DATA;
wire Rx_FERROR,Rx_PERROR,Rx_VALID;


uart_receiver uart_receiver_inst(reset,clk,Rx_DATA,baud_select,Rx_EN,RxD,Rx_FERROR,Rx_PERROR,Rx_VALID);

initial
begin
  clk=1'b0;
  reset=1'b0;
  Rx_EN=1'b0;
  #(2*`clock_period) reset=1'b1;
  #(2*`clock_period) reset =1'b0;
  #10 Rx_EN=1'b1;
  #15 RxD=1'b0; //start bit 
  #8640 RxD=1'b1;//first data 54*10*16
  #8640 RxD=1'b0;
  #8640 RxD=1'b0;
  #8640 RxD=1'b1;
  #8640 RxD=1'b0;
  #8640 RxD=1'b0;
  #8640 RxD=1'b0;
  #8640 RxD=1'b1;
  #8640 RxD=1'b1; //parity bit 
  #8640 RxD=1'b1; // stopbit
  
  
  
  
  

  
  
end

always
  #(`clock_period/2)clk = ~clk;



endmodule