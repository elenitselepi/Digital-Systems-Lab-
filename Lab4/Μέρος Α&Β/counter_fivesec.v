//Module counter for counting 5 sec .5sec/5ns(the period of the 200MHz clock) = 1*10^9 cycles
//Author Tselepi Eleni 

module counter_fivesec(clk,reset,flag_play,flag_finish);

input clk,reset,flag_play;
output reg flag_finish; //output signal that states the finish of the 5 sec

reg [29:0] counter; //2^30=1,07*10^9

always@(posedge clk or posedge reset)
begin

  if(reset)
  begin
    counter<='d0;
  end
  else if (flag_play)
  begin
    counter<=(counter=='d1_000_000_000)?'d0:counter+1; 
  end
  else
  begin
    counter<=(counter=='d1_000_000_000)?'d0:counter;
  end
end


always@(counter)
begin
 if(counter=='d1_000_000_000)
 begin
  flag_finish=1'b1;
 end
 else
  flag_finish=1'b0;
end



endmodule