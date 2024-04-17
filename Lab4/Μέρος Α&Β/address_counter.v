//Module for the active address of the memeory for the recording . The output flag_finish signal is sent when the 32.768 bits 
//are full and we are out of memory in order to finish recording.
//Author Tselepi Eleni 

module address_counter(clk,reset,flag_record,we,thirtytwo_enable,address,flag_finish);

input clk,reset,flag_record;
input [3:0] we;
input thirtytwo_enable;
output reg [9:0]address; //10bit address
output reg flag_finish; //when memory is full sent this message

always@(posedge clk or posedge reset )
begin

  if(reset)
  begin
   address<='d1023;  //1024-1 in order to do overflow and be at 0 the first time
   flag_finish<=1'b0;
  end
  else if (flag_record && thirtytwo_enable) //when recording has began
  begin
    address<=(address=='d1023)?'d0:address+1; 
  
  end
  
   flag_finish<=(address=='d1023 && we==4'b1111)?1'b1:1'b0; // when address is at 1023 we write the last 32bits.At the next cycle finish the recording because memory is full 

end

endmodule