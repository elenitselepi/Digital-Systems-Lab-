//This module is one counter counting 20cycles of the clock .
//Each 20cycles Hpixel = Hpixel+1 . D section has 2560 cycles / 128 bit in the memory we want 20cycles per 1bit of the memory .
//Author Tselepi Eleni 

module counter_twenty(clk,reset,flag_D,twenty_enable);

input clk,reset;
input flag_D;//this is a flag in order for the counter to start counting only when the hsync fsm is in state_D

output reg twenty_enable; //the output of the counter when 20 cycles have passed

reg [4:0] counter;//5bit counter 2^5=32 counting until 20

always@(posedge clk or posedge reset)
begin

  if(reset)
  begin
    counter<='d0;
  end
  else if (flag_D)
  begin
    counter<=(counter=='d19)?'d0:counter+1;
  end
  else
  begin
    counter<=(counter=='d19)?'d0:counter;
  end


end

//when counter is 19 sent a hpixel enable in ordel hpixel ++
always@(counter)
begin
 if(counter=='d19)
 begin
  twenty_enable=1'b1;
 end
 else
  twenty_enable=1'b0;
end

endmodule