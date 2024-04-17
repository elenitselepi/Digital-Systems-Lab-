//Module for the counter for counting 16times the Tx_Sample_enable is one
//Author Tselepi Eleni 03272

module counter(clk,reset,Tx_sample_ENABLE,Tx_BUSY,enable);

input clk,reset;
input Tx_sample_ENABLE ,Tx_BUSY;
output reg enable; //the output signal that the counter has come to an end 

reg [3:0] counter=4'b0000; //the counter for the 16 times 

//this is the counter for counting 16times the Tx_Sample_Enable has come
always@(posedge clk or posedge reset)
begin
  if(reset)
  begin
    counter<=0;
  end
  else if (Tx_sample_ENABLE && Tx_BUSY) //when tx_busy then the transmitter has began sending data
  begin
    counter<=(counter==4'b1111)?0:counter+1;
  end
  else
  begin
    counter<=(counter==4'b1111)?0:counter;
  end
   
end

//when counter reaches 15 then enable is 1 
always@(counter)
begin
  if(counter==4'b1111) 
    enable=1'b1;
  else
    enable=1'b0;
end





endmodule



