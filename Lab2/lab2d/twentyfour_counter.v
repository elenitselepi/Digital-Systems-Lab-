//The 24 counter counting from thr fisrt startbit until the middle of the fisrt data

module twentyfour_counter(clk,reset,Rx_sample_ENABLE,flag_startbit,enable_twentyfour);

input clk,reset,Rx_sample_ENABLE;
input flag_startbit;

output reg enable_twentyfour;
reg [4:0] twentyfour_counter; //5bit counter used for counting until 24 when start to Data 0


//this is the counter counting 24times of Rx_Sample_ENABLE 
always@(posedge clk or posedge reset)
begin
  if(reset)
  begin
    twentyfour_counter<=0;
  end
  else if (Rx_sample_ENABLE && flag_startbit) //the counter starts counting only when the Start_bit has come
  begin
    twentyfour_counter<=(twentyfour_counter=='d23)?0:twentyfour_counter+1;
  end
  else
  begin
    twentyfour_counter<=(twentyfour_counter=='d23)?0:twentyfour_counter; //stay the same if Rx_sample enable has not come 
  end
   
end

//when counter reaches 23 enable_twentyfour siganl is 1
always@(twentyfour_counter)
begin
  if(twentyfour_counter=='d23) 
    enable_twentyfour=1'b1;
  else
    enable_twentyfour=1'b0;
end

endmodule