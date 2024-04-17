//Module for counting 16 sample_enables in order to sample the middle of the data
//Author Tselepi Eleni

module sixteen_counter(clk,reset,Rx_sample_ENABLE,flag_data,flag_afterdata,enable_sixteen,sixteen_counter);

input clk,reset,Rx_sample_ENABLE,flag_data,flag_afterdata;
output reg enable_sixteen; // the signal from the 16counter

output reg [3:0] sixteen_counter; //4bit counter used for counting until 16 from Data until the middle of the other Data 

//this is the counter that counts 16 times
always@(posedge clk or posedge reset)
begin
  if(reset)
  begin
    sixteen_counter<=0;
  end
  else if (Rx_sample_ENABLE && (flag_data||flag_afterdata))   //counting only when we are at the state data or the states after data  
  begin
    sixteen_counter<=(sixteen_counter=='d15)? 0:sixteen_counter+1;
  end
  else
  begin
   sixteen_counter<=(sixteen_counter=='d15)? 0:sixteen_counter;
  end
   
end

//when counter reaches 15 enable_twentyfour siganl is 1
always@(sixteen_counter)
begin
  if(sixteen_counter=='d15) 
    enable_sixteen=1'b1;
  else
    enable_sixteen=1'b0;
end

endmodule