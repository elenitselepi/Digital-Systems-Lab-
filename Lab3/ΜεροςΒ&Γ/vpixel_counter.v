//Module for vpixel_counter.vpixel increases when signal five_enable has came .
//Author Tselepi Eleni 

module vpixel_counter(clk,reset,five_enable,VPIXEL);

input clk,reset;
input five_enable; //when five lines have passed vpixel increases


output reg [6:0] VPIXEL;//2^7=127 we want the 96 of them


always@(posedge clk or posedge reset)
begin

  if(reset)
  begin
    VPIXEL<='d0;
  end
  else if (five_enable)
  begin
    VPIXEL<=(VPIXEL=='d96)?'d0:VPIXEL+1;
  end
  else //if not five enable and 96 be zero 
  begin
    VPIXEL<=(VPIXEL=='d96)?'d0:VPIXEL;
  end

end


endmodule