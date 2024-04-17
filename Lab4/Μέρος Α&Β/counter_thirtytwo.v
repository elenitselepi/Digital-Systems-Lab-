//This module is the counter counting until 32 . When 32 cycles of the 2Mhz clock have passed the thirtytwo_enable is high
//Author Tselepi Eleni

module counter_thirtytwo(clk,reset,flag,thirtytwo_enable,counter);

input clk,reset;
input flag;//this is a flag in order for the counter to start counting only when the fsm is in state recording/playing

output reg thirtytwo_enable; //the output of the counter when 32 cycles of the 2Mhz clk have passed

output reg [4:0] counter;//5bit counter 2^5=32 

always@(posedge clk or posedge reset)
begin
  if(reset)
  begin
    counter<='d0;
  end
  else if (flag)
  begin
    counter<=(counter=='d31)?'d0:counter+1;
  end
end

//when counter is 31 sent the enable signal 
always@(counter)
begin
 if(counter=='d31)
 begin
  thirtytwo_enable=1'b1;
 end
 else
  thirtytwo_enable=1'b0;
end

endmodule