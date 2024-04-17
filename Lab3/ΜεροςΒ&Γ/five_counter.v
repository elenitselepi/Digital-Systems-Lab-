//Counter counting five times we want to dislay the same line 96*5=480
//count 16000 cycles , R=1536000cycles/96=16000 for each Vpixel 
//Author Tselepi Eleni 

module five_counter(clk,reset,flagR,five_enable);

input clk,reset;
input flagR;

output reg five_enable; //the output signal that 16000 cycles have passed

reg [13:0] counter; //14bit counter 2^14=16384 counting until 16000=3200*5


always@(posedge clk or posedge reset)
begin

  if(reset)
  begin
    counter<='d0;
  end
  else if (flagR)
  begin
    counter<=(counter=='d15999)?'d0:counter+1;
  end
  else
  begin
    counter<=(counter=='d15999)?'d0:counter;
  end

end

//when counter is 15999 sent a five enable in order vpixel++
always@(counter)
begin
 if(counter=='d15999)
 begin
  five_enable=1'b1;
 end
 else
  five_enable=1'b0;
end


endmodule
