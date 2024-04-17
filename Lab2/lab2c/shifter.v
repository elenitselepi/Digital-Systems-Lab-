//Module shifter for shifting the input bits into a register
//Author Tselepi Eleni

module shifter(clk,SI,counter,sample_enable,flag,PO);

input clk, SI,sample_enable,flag;//Sample_enable is the Rx_sample_enable and flag is the flag that we are at the data state 
input [3:0] counter; //in order to shift a bit i want the 16counter to be zero because i want to shift the fisrt RxD
output [7:0] PO;
reg [7:0] tmp=8'bx;

always@(posedge clk)
begin
  if(sample_enable && counter=='d0 && flag) //the sample enable must be one and the counter 0 and the counter counting the data state (flag==1)
    tmp <= {SI,tmp[7:1]};  //right shift because of the least significant bit 
  else
    tmp=tmp;
end

assign PO = tmp;

endmodule

