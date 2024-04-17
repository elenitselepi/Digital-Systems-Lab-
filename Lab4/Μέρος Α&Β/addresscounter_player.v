//Module for address about the player FSM.It is a counter counting until 1024 
//Author Tselepi Eleni 

module addresscounter_player(clk,reset,flag_play,thirtytwo_enable,address);

input clk,reset,flag_play,thirtytwo_enable;
output reg [9:0] address; //10bit address 2^10=1024 32.768/32=1024

always@(posedge clk or posedge reset )
begin

  if(reset)
  begin
   address<='d0;  
  end
  else if (flag_play && thirtytwo_enable) //when 32 cycles of the clock have passes make address+32
  begin
    address<=(address=='d1023)?'d0:address+1; 
  end

end

endmodule

